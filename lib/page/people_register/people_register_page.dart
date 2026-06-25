import 'package:flutter/material.dart';
import 'package:tuoc/page/people_register/people_register_presenter.dart';
import 'package:tuoc/service/size_service.dart';
import 'package:tuoc/widget/base_container.dart';
import 'package:tuoc/widget/custom_button.dart';
import 'package:tuoc/widget/custom_textfield.dart';

class PeopleRegisterPage extends StatefulWidget {
  PeopleRegisterPage({Key key}) : super(key: key);

  @override
  _PeopleRegisterPageState createState() => _PeopleRegisterPageState();
}

class _PeopleRegisterPageState extends State<PeopleRegisterPage> {
  PeopleRegisterPresenter _presenter;

  @override
  void initState() {
    super.initState();

    _presenter = PeopleRegisterPresenter(this);
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BaseContainer(
      hasProfile: false,
      title: 'Sign Up',
      child: Container(
        child: SingleChildScrollView(
          padding: EdgeInsets.only(
            top: SizeService.getPadding(84),
            right: SizeService.getPadding(66),
            left: SizeService.getPadding(66),
            bottom: MediaQuery.of(context).padding.bottom +
                SizeService.getPadding(66),
          ),
          child: Form(
            key: _presenter.formKey,
            child: Column(
              children: <Widget>[
                CustomTextField(
                  controller: _presenter.usernameCtrl,
                  hintText: 'Username',
                  fontSize: 45,
                  validator: _requiredField,
                ),
                SizedBox(height: SizeService.getPadding(60)),
                CustomTextField(
                  controller: _presenter.passCtrl,
                  hintText: 'Password',
                  fontSize: 45,
                  obscureText: true,
                  validator: _requiredField,
                ),
                SizedBox(height: SizeService.getPadding(60)),
                CustomTextField(
                  controller: _presenter.firstNameCtrl,
                  hintText: 'First Name',
                  fontSize: 45,
                  validator: _requiredField,
                ),
                SizedBox(height: SizeService.getPadding(60)),
                CustomTextField(
                  controller: _presenter.lastNameCtrl,
                  hintText: 'Last Name',
                  fontSize: 45,
                  validator: _requiredField,
                ),
                SizedBox(height: SizeService.getPadding(60)),
                CustomTextField(
                  controller: _presenter.emailCtrl,
                  hintText: 'Email',
                  fontSize: 45,
                  validator: _requiredField,
                ),
                SizedBox(height: SizeService.getPadding(60)),
                CustomTextField(
                  controller: _presenter.phoneCtrl,
                  hintText: 'Phone Number',
                  fontSize: 45,
                ),
                SizedBox(height: SizeService.getPadding(88)),
                CustomButton(
                  onPressed: _presenter.onSubmit,
                  buttonText: 'Sign Up',
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  String _requiredField(String txt) {
    if (txt.isEmpty) {
      return '';
    } else {
      return null;
    }
  }
}
