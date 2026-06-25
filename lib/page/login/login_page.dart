import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_device_type/flutter_device_type.dart';
import 'package:tuoc/environment/custom_text_theme.dart';
import 'package:tuoc/page/login/login_presenter.dart';
import 'package:tuoc/page/select_register_type/select_register_type_page.dart';
import 'package:tuoc/service/size_service.dart';
import 'package:tuoc/widget/base_container.dart';
import 'package:tuoc/widget/custom_button.dart';
import 'package:tuoc/widget/custom_textfield.dart';

class LoginPage extends StatefulWidget {
  LoginPage({Key key}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  LoginPresenter _presenter;

  @override
  void initState() {
    super.initState();

    _presenter = LoginPresenter(this);
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    SizeService(context);
    return BaseContainer(
      title: 'Login',
      hasProfile: false,
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: SizeService.getPadding(146)),
        child: SingleChildScrollView(
          padding: EdgeInsets.only(
            bottom: MediaQuery.of(context).padding.bottom +
                SizeService.getPadding(44),
          ),
          child: Column(
            children: <Widget>[
              SizedBox(height: SizeService.getPadding(38)),
//              Container(
//                child: ProfileImage(
//                  showShadow: true,
//                  width: 600,
//                  borderWidth: 28,
//                ),
//              ),
              Image.asset('assets/icons/ic_login.png',
                  width:
                      SizeService.getWidth(Device.get().isTablet ? 500 : 650)),
              SizedBox(height: SizeService.getPadding(80)),
              CustomTextField(
                controller: _presenter.usernameCtrl,
                hintText: 'Username',
                fontSize: 45,
              ),
              SizedBox(height: SizeService.getPadding(60)),
              CustomTextField(
                controller: _presenter.passwordCtrl,
                hintText: 'Password',
                fontSize: 45,
                obscureText: true,
              ),
              SizedBox(height: SizeService.getPadding(90)),
              CustomButton(
                buttonText: 'Sign in',
                onPressed: _presenter.onSubmit,
              ),
              SizedBox(height: SizeService.getPadding(64)),
              _register(),
              _forgotPasswordText(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _register() {
    if (_presenter.isFake != null && _presenter.isFake) {
      return Padding(
        padding: EdgeInsets.only(bottom: SizeService.getPadding(40)),
        child: GestureDetector(
          onTap: () => Navigator.push(context,
              CupertinoPageRoute(builder: (_) => SelectRegisterTypePage())),
          child: Text(
            'Sign Up',
            style: CustomTextTheme.buttonText(context).copyWith(
              fontSize: SizeService.getFontSize(55),
              decoration: TextDecoration.underline,
            ),
          ),
        ),
      );
    } else {
      return Container();
    }
  }

  Widget _forgotPasswordText() {
    return Text(
      'หากลืมรหัสผ่านโปรดติดต่อเจ้าหน้าที่',
      style: CustomTextTheme.content(context).copyWith(color: Colors.white),
    );
  }
}
