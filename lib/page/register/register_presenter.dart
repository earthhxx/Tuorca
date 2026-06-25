import 'package:flutter/material.dart';
import 'package:tuoc/environment/base_presenter.dart';
import 'package:tuoc/page/register/register_page.dart';
import 'package:tuoc/service/api.dart';
import 'package:tuoc/util/alert.dart';

class RegisterPresenter extends BasePresenter<RegisterPage> {
  Api _api;

  final formKey = GlobalKey<FormState>();
  TextEditingController usernameCtrl = TextEditingController();
  TextEditingController passCtrl = TextEditingController();
  TextEditingController firstNameCtrl = TextEditingController();
  TextEditingController lastNameCtrl = TextEditingController();
  TextEditingController emailCtrl = TextEditingController();
  TextEditingController phoneCtrl = TextEditingController();

  RegisterPresenter(State<RegisterPage> state) : super(state);

  onSubmit() async {
    if (formKey.currentState.validate()) {
      _api = Api<Map<String, dynamic>>();

      var res = await _api.register({
        "username": usernameCtrl.text,
        "password": passCtrl.text,
        "account_type": "member",
        "fname": firstNameCtrl.text,
        "lname": lastNameCtrl.text,
        "email": emailCtrl.text,
        "phone": phoneCtrl.text,
      });

      if (res.fail == null) {
        Alert(state.context, message: "Success", onOk: () {
          Navigator.pop(state.context);
        });
      } else {
        Alert(state.context, message: res.fail.message.toString(), onOk: () {
          Navigator.pop(state.context);
        });
      }
    }
  }
}
