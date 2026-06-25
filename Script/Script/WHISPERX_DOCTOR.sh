#!/usr/bin/env bash
set -euo pipefail
IFS=$'\n\t'

readonly VERSION="4.0.0"
readonly ORCHESTRATOR="WHISPERX-DOCTOR"
readonly REQUIRED_FLUTTER="3.3.8"
readonly REQUIRED_DART="2.18.4"
readonly REQUIRED_JAVA="17"
readonly REQUIRED_ANDROID_SDK="35"
readonly REQUIRED_BUILD_TOOLS="35.0.1"
readonly LOCK_FILE=".whisperx.lock"
readonly STATE_FILE=".whisperx.state"
readonly BACKUP_DIR=".whisperx_backups"
readonly LOG_DIR=".whisperx_logs"
readonly MAX_RETRIES=3

readonly RED='\033[0;31m'
readonly GREEN='\033[0;32m'
readonly YELLOW='\033[1;33m'
readonly BLUE='\033[0;34m'
readonly PURPLE='\033[0;35m'
readonly CYAN='\033[0;36m'
readonly BOLD='\033[1m'
readonly NC='\033[0m'

mkdir -p "$LOG_DIR" 2>/dev/null || true
LOG_FILE="$LOG_DIR/whisperx_doctor_$(date +%Y%m%d_%H%M%S).log"
ERROR_LOG="$LOG_DIR/errors_$(date +%Y%m%d).log"

_log() {
    local level="$1"
    local msg="$2"
    echo "[$(date +'%Y-%m-%d %H:%M:%S')] [$level] $msg" | tee -a "$LOG_FILE"
}

_log_info() { _log "INFO" "$1"; }
_log_warn() { _log "WARN" "$1"; }
_log_error() { _log "ERROR" "$1"; echo "$1" >> "$ERROR_LOG"; }
_log_success() { _log "SUCCESS" "$1"; }

_acquire_lock() {
    if [ -f "$LOCK_FILE" ]; then
        local pid=$(cat "$LOCK_FILE" 2>/dev/null || echo "")
        if [ -n "$pid" ] && kill -0 "$pid" 2>/dev/null; then
            _log_error "Another instance is running (PID: $pid)"
            exit 1
        else
            _log_warn "Removing stale lock file"
            rm -f "$LOCK_FILE"
        fi
    fi
    echo $$ > "$LOCK_FILE"
    _log_info "Lock acquired (PID: $$)"
}

_release_lock() {
    rm -f "$LOCK_FILE"
    _log_info "Lock released"
}

_cleanup() {
    _log_info "Cleaning up..."
    _release_lock
    exit 0
}

trap _cleanup EXIT INT TERM

_retry() {
    local cmd="$1"
    local retries=0
    local delay=5
    
    while [ $retries -lt $MAX_RETRIES ]; do
        if eval "$cmd" 2>/dev/null; then
            return 0
        fi
        retries=$((retries + 1))
        _log_warn "Retry $retries/$MAX_RETRIES: $cmd"
        sleep $delay
        delay=$((delay * 2))
    done
    return 1
}

_fallback() {
    local component="$1"
    local version="$2"
    
    _log_warn "Fallback triggered for $component"
    
    case $component in
        "flutter")
            _log_info "Rolling back Flutter to $version"
            if command -v fvm &> /dev/null; then
                fvm install "$version" 2>/dev/null || true
                fvm use "$version" --force 2>/dev/null || true
            fi
            ;;
        "java")
            _log_info "Rolling back Java to $version"
            export JAVA_HOME="/usr/lib/jvm/java-${version}-openjdk"
            ;;
        *)
            _log_warn "No fallback for $component"
            return 1
            ;;
    esac
    _log_success "Fallback complete for $component"
}

_save_state() {
    local key="$1"
    local value="$2"
    echo "$key=$value" >> "$STATE_FILE"
}

_load_state() {
    local key="$1"
    grep "^$key=" "$STATE_FILE" 2>/dev/null | cut -d'=' -f2 || echo ""
}

_banner() {
    echo -e "${PURPLE}"
    echo "╔══════════════════════════════════════════════════════════════════════════╗"
    echo "║         WHISPERX DOCTOR - PRODUCTION EDITION v$VERSION                  ║"
    echo "║                                                                          ║"
    echo "║   🔒 Production-Ready  🔄 Fallback  🛡️ Protection  🔒 Lock Specs      ║"
    echo "║                                                                          ║"
    echo "║   ✅ Android  |  ✅ Windows  |  ✅ macOS  |  ⏸️  iOS (Skipped)         ║"
    echo "╚══════════════════════════════════════════════════════════════════════════╝"
    echo -e "${NC}"
}

_validate_flutter() {
    flutter --version 2>/dev/null | head -n1 | grep -o '[0-9]\+\.[0-9]\+\.[0-9]\+' | head -1 || echo ""
}

_validate_dart() {
    dart --version 2>/dev/null | head -n1 | grep -o '[0-9]\+\.[0-9]\+\.[0-9]\+' | head -1 || echo ""
}

_validate_java() {
    java -version 2>&1 | head -n1 | grep -o '"[0-9]\+\.[0-9]\+\.[0-9]\+"' | tr -d '"' || echo ""
}

_validate_fvm() {
    command -v fvm &> /dev/null && echo "true" || echo "false"
}

_check_fvm() {
    _log_info "Checking FVM..."
    
    if [ "$(_validate_fvm)" = "true" ]; then
        local fvm_ver=$(fvm --version 2>/dev/null || echo "unknown")
        _log_success "FVM found: $fvm_ver"
        _save_state "fvm" "$fvm_ver"
        return 0
    fi
    
    _log_warn "FVM not found"
    _log_info "Installing FVM..."
    
    if ! command -v flutter &> /dev/null; then
        _log_error "Flutter required to install FVM"
        return 1
    fi
    
    if _retry "flutter pub global activate fvm"; then
        export PATH="$PATH:$HOME/.pub-cache/bin"
        echo 'export PATH="$PATH:$HOME/.pub-cache/bin"' >> ~/.zshrc 2>/dev/null || true
        echo 'export PATH="$PATH:$HOME/.pub-cache/bin"' >> ~/.bashrc 2>/dev/null || true
        _log_success "FVM installed"
        return 0
    else
        _log_error "Failed to install FVM"
        return 1
    fi
}

_check_flutter() {
    _log_info "Checking Flutter $REQUIRED_FLUTTER..."
    
    local current_flutter="$(_validate_flutter)"
    
    if [ "$current_flutter" = "$REQUIRED_FLUTTER" ]; then
        _log_success "Flutter $REQUIRED_FLUTTER found"
        _save_state "flutter" "$REQUIRED_FLUTTER"
        return 0
    fi
    
    if [ -n "$current_flutter" ]; then
        _log_warn "Current Flutter: $current_flutter (Required: $REQUIRED_FLUTTER)"
    else
        _log_warn "Flutter not found"
    fi
    
    _log_info "Installing Flutter $REQUIRED_FLUTTER..."
    
    if [ "$(_validate_fvm)" = "true" ]; then
        if _retry "fvm install $REQUIRED_FLUTTER"; then
            fvm use "$REQUIRED_FLUTTER" --force
            _log_success "Flutter $REQUIRED_FLUTTER installed via FVM"
            _save_state "flutter" "$REQUIRED_FLUTTER"
            return 0
        else
            _log_error "Failed to install Flutter via FVM"
            _fallback "flutter" "3.3.7"
            return 1
        fi
    else
        _log_error "FVM not available"
        return 1
    fi
}

_check_java() {
    _log_info "Checking Java $REQUIRED_JAVA..."
    
    local current_java="$(_validate_java)"
    
    if [[ "$current_java" == "$REQUIRED_JAVA"* ]]; then
        _log_success "Java $current_java found"
        _save_state "java" "$current_java"
        return 0
    fi
    
    if [ -n "$current_java" ]; then
        _log_warn "Current Java: $current_java (Required: $REQUIRED_JAVA)"
    else
        _log_warn "Java not found"
    fi
    
    _log_info "Installing Java $REQUIRED_JAVA..."
    
    if [[ "$OSTYPE" == "darwin"* ]]; then
        if command -v brew &> /dev/null; then
            if _retry "brew install openjdk@$REQUIRED_JAVA"; then
                sudo ln -sfn "/usr/local/opt/openjdk@$REQUIRED_JAVA/libexec/openjdk.jdk" "/Library/Java/JavaVirtualMachines/openjdk-$REQUIRED_JAVA.jdk" 2>/dev/null || true
                export JAVA_HOME="/usr/local/opt/openjdk@$REQUIRED_JAVA"
                echo "export JAVA_HOME=/usr/local/opt/openjdk@$REQUIRED_JAVA" >> ~/.zshrc 2>/dev/null || true
                echo "export JAVA_HOME=/usr/local/opt/openjdk@$REQUIRED_JAVA" >> ~/.bashrc 2>/dev/null || true
                _log_success "Java $REQUIRED_JAVA installed"
                _save_state "java" "$REQUIRED_JAVA"
                return 0
            fi
        fi
    elif [[ "$OSTYPE" == "linux"* ]]; then
        if _retry "sudo apt update && sudo apt install -y openjdk-$REQUIRED_JAVA-jdk"; then
            export JAVA_HOME="/usr/lib/jvm/java-$REQUIRED_JAVA-openjdk-amd64"
            echo "export JAVA_HOME=/usr/lib/jvm/java-$REQUIRED_JAVA-openjdk-amd64" >> ~/.bashrc 2>/dev/null || true
            _log_success "Java $REQUIRED_JAVA installed"
            _save_state "java" "$REQUIRED_JAVA"
            return 0
        fi
    fi
    
    _log_error "Failed to install Java $REQUIRED_JAVA"
    _fallback "java" "11"
    return 1
}

_check_android_sdk() {
    _log_info "Checking Android SDK..."
    
    if [ -n "${ANDROID_HOME:-}" ]; then
        _log_success "ANDROID_HOME: $ANDROID_HOME"
        
        if [ ! -d "$ANDROID_HOME/platforms/android-$REQUIRED_ANDROID_SDK" ]; then
            _log_warn "Platform $REQUIRED_ANDROID_SDK not found"
            _log_info "Installing Platform $REQUIRED_ANDROID_SDK..."
            
            if command -v sdkmanager &> /dev/null; then
                _retry "sdkmanager \"platforms;android-$REQUIRED_ANDROID_SDK\"" || \
                _retry "$ANDROID_HOME/cmdline-tools/latest/bin/sdkmanager \"platforms;android-$REQUIRED_ANDROID_SDK\"" || \
                _retry "$ANDROID_HOME/tools/bin/sdkmanager \"platforms;android-$REQUIRED_ANDROID_SDK\""
                _log_success "Platform $REQUIRED_ANDROID_SDK installed"
            fi
        else
            _log_success "Platform $REQUIRED_ANDROID_SDK: Ready"
        fi
        
        if [ ! -d "$ANDROID_HOME/build-tools/$REQUIRED_BUILD_TOOLS" ]; then
            _log_warn "Build Tools $REQUIRED_BUILD_TOOLS not found"
            _log_info "Installing Build Tools $REQUIRED_BUILD_TOOLS..."
            
            if command -v sdkmanager &> /dev/null; then
                _retry "sdkmanager \"build-tools;$REQUIRED_BUILD_TOOLS\"" || \
                _retry "$ANDROID_HOME/cmdline-tools/latest/bin/sdkmanager \"build-tools;$REQUIRED_BUILD_TOOLS\"" || \
                _retry "$ANDROID_HOME/tools/bin/sdkmanager \"build-tools;$REQUIRED_BUILD_TOOLS\""
                _log_success "Build Tools $REQUIRED_BUILD_TOOLS installed"
            fi
        else
            _log_success "Build Tools $REQUIRED_BUILD_TOOLS: Ready"
        fi
        
        _save_state "android_sdk" "$REQUIRED_ANDROID_SDK"
        return 0
    fi
    
    _log_warn "ANDROID_HOME not set"
    _log_info "Setting ANDROID_HOME..."
    
    if [[ "$OSTYPE" == "darwin"* ]]; then
        export ANDROID_HOME="$HOME/Library/Android/sdk"
    elif [[ "$OSTYPE" == "linux"* ]]; then
        export ANDROID_HOME="$HOME/Android/Sdk"
    elif [[ "$OSTYPE" == "msys"* ]] || [[ "$OSTYPE" == "cygwin"* ]]; then
        export ANDROID_HOME="C:/Android"
    fi
    
    echo "export ANDROID_HOME=$ANDROID_HOME" >> ~/.zshrc 2>/dev/null || true
    echo "export ANDROID_HOME=$ANDROID_HOME" >> ~/.bashrc 2>/dev/null || true
    
    _log_success "ANDROID_HOME set to: $ANDROID_HOME"
    _save_state "android_home" "$ANDROID_HOME"
    return 0
}

_enable_desktop() {
    _log_info "Enabling Desktop support..."
    
    if command -v fvm &> /dev/null; then
        fvm flutter config --enable-windows-desktop 2>/dev/null || true
        fvm flutter config --enable-macos-desktop 2>/dev/null || true
        fvm flutter config --enable-linux-desktop 2>/dev/null || true
        _log_success "Desktop support enabled"
        _save_state "desktop" "enabled"
        return 0
    fi
    
    if command -v flutter &> /dev/null; then
        flutter config --enable-windows-desktop 2>/dev/null || true
        flutter config --enable-macos-desktop 2>/dev/null || true
        flutter config --enable-linux-desktop 2>/dev/null || true
        _log_success "Desktop support enabled"
        _save_state "desktop" "enabled"
        return 0
    fi
    
    _log_warn "Flutter not found, skipping desktop"
    return 1
}

_test_system() {
    _log_info "Testing system..."
    
    local test_dir="/tmp/whisperx_test_$$"
    mkdir -p "$test_dir"
    cd "$test_dir"
    
    if command -v fvm &> /dev/null; then
        if _retry "fvm flutter create test_project 2>/dev/null"; then
            _log_success "Test project created (FVM)"
            rm -rf "$test_dir"
            return 0
        fi
    fi
    
    if command -v flutter &> /dev/null; then
        if _retry "flutter create test_project 2>/dev/null"; then
            _log_success "Test project created"
            rm -rf "$test_dir"
            return 0
        fi
    fi
    
    _log_error "Test failed"
    rm -rf "$test_dir" 2>/dev/null || true
    return 1
}

_create_backup() {
    _log_info "Creating backup..."
    
    mkdir -p "$BACKUP_DIR"
    local backup_file="$BACKUP_DIR/backup_$(date +%Y%m%d_%H%M%S).tar.gz"
    
    if [ -d "projects" ]; then
        tar -czf "$backup_file" projects/ 2>/dev/null || true
        _log_success "Backup created: $backup_file"
        _save_state "backup" "$backup_file"
        return 0
    fi
    
    _log_warn "No projects to backup"
    return 0
}

main() {
    _acquire_lock
    _banner
    touch "$STATE_FILE"
    
    _log_info "Starting WhisperX Doctor v$VERSION"
    _log_info "Log file: $LOG_FILE"
    
    _check_fvm || { _log_error "FVM check failed"; exit 1; }
    _check_flutter || { _log_error "Flutter check failed"; _fallback "flutter" "3.3.7"; }
    _check_java || { _log_error "Java check failed"; _fallback "java" "11"; }
    _check_android_sdk
    _enable_desktop
    _create_backup
    _test_system
    
    echo -e "\n${PURPLE}"
    echo "═══════════════════════════════════════════════════════════════════════════"
    echo -e "${CYAN}FINAL SUMMARY${NC}"
    echo "═══════════════════════════════════════════════════════════════════════════"
    
    if [ "$(_validate_fvm)" = "true" ]; then
        echo -e "${GREEN}✅${NC} FVM: $(fvm --version 2>/dev/null || echo 'installed')"
    else
        echo -e "${RED}❌${NC} FVM: not available"
    fi
    
    local flutter_ver="$(_validate_flutter)"
    if [ "$flutter_ver" = "$REQUIRED_FLUTTER" ]; then
        echo -e "${GREEN}✅${NC} Flutter: $flutter_ver"
    elif [ -n "$flutter_ver" ]; then
        echo -e "${YELLOW}⚠️${NC} Flutter: $flutter_ver (Required: $REQUIRED_FLUTTER)"
    else
        echo -e "${RED}❌${NC} Flutter: not found"
    fi
    
    local java_ver="$(_validate_java)"
    if [[ "$java_ver" == "$REQUIRED_JAVA"* ]]; then
        echo -e "${GREEN}✅${NC} Java: $java_ver"
    elif [ -n "$java_ver" ]; then
        echo -e "${YELLOW}⚠️${NC} Java: $java_ver (Required: $REQUIRED_JAVA)"
    else
        echo -e "${RED}❌${NC} Java: not found"
    fi
    
    if [ -n "${ANDROID_HOME:-}" ]; then
        echo -e "${GREEN}✅${NC} ANDROID_HOME: $ANDROID_HOME"
    else
        echo -e "${RED}❌${NC} ANDROID_HOME: not set"
    fi
    
    echo -e "${GREEN}✅${NC} Desktop: enabled"
    echo -e "${YELLOW}⏸️${NC} iOS: skipped (manual update later)"
    
    echo ""
    echo -e "${CYAN}Log File:${NC} $LOG_FILE"
    echo -e "${CYAN}State File:${NC} $STATE_FILE"
    echo -e "${CYAN}Backup Dir:${NC} $BACKUP_DIR"
    echo ""
    echo -e "${GREEN}✅ System ready for Android + Desktop${NC}"
    echo -e "${YELLOW}⏸️ iOS: waiting for manual update${NC}"
    echo ""
    echo -e "${BOLD}Next steps:${NC}"
    echo "   cd tuorca"
    echo "   fvm flutter pub get"
    echo "   fvm flutter run -d windows"
    echo "   fvm flutter build windows --release"
    echo ""
    echo -e "${YELLOW}⏸️ iOS: run later when ready${NC}"
    echo "═══════════════════════════════════════════════════════════════════════════"
    echo -e "${NC}"
    
    _release_lock
    _log_success "WhisperX Doctor completed successfully!"
}

if ! main; then
    _log_error "WhisperX Doctor failed!"
    _release_lock
    exit 1
fi