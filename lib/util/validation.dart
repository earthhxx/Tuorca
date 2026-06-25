class Validation {
  static String emptyField(value) {
    if (value == null || value.isEmpty)
      return '';
    else
      return null;
  }

  static String emailFormat(String email) {
    if (emptyField(email) != null) return emptyField(email);
    var format = new RegExp(
        '[^a-zA-Z0-9.!#\$%&\'*+/=?^_`{|}~-]+@[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,253}[a-zA-Z0-9])?(?:\.[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,253}[a-zA-Z0-9])?)*\$');
    if (format.hasMatch(email))
      return '';
    else
      return null;
  }

  static String confirmPassword(String pass, String cpass) {
    if (emptyField(cpass) != null) return emptyField(cpass);
    if (passwordFormat(cpass) != null) return passwordFormat(cpass);
    if (cpass != pass) return 'รหัสผ่านและยืนยันรหัสผ่านไม่ตรงกัน';
  }

  static String passwordFormat(String pass) {
    if (emptyField(pass) != null) return emptyField(pass);
    var format = new RegExp("[^a-zA-Z0-9]+");
    if (format.hasMatch(pass))
      return 'รหัสผ่านต้องเป็นภาษาอังกฤษและตัวเลขเท่านั้น';
  }

  static String userNameFormat(String user) {
    if (emptyField(user) != null) return emptyField(user);
    var format = new RegExp("^[a-zA-Z]+[0-9a-zA-Z]*");
    if (!format.hasMatch(user))
      return 'ชื่อผู้ใช้ต้องเป็นภาษาอังกฤษและตัวเลขเท่านั้น';
  }

  static String phoneFormat(String user) {
    if (emptyField(user) != null) return emptyField(user);
    var format = new RegExp("^[0-9]{10,}");
    if (!format.hasMatch(user))
      return '';
    else
      return null;
  }

  static String ageFormat(String user) {
    print(user.length);
    if (user == null || user.isEmpty || user.length > 3)
      return '';
    else
      return null;
  }
}
