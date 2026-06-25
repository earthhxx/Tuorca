import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:tuoc/page/people_register/people_register_page.dart';
import 'package:tuoc/page/register/register_page.dart';
import 'package:tuoc/service/size_service.dart';
import 'package:tuoc/widget/base_container.dart';
import 'package:tuoc/widget/custom_button.dart';

class SelectRegisterTypePage extends StatefulWidget {
  SelectRegisterTypePage({Key key}) : super(key: key);

  @override
  _SelectRegisterTypePageState createState() => _SelectRegisterTypePageState();
}

class _SelectRegisterTypePageState extends State<SelectRegisterTypePage> {
  @override
  Widget build(BuildContext context) {
    return BaseContainer(
      hasProfile: false,
      title: 'Select Type',
      child: Container(
        padding: EdgeInsets.symmetric(
          vertical: SizeService.getPadding(66),
          horizontal: SizeService.getPadding(66),
        ),
        child: Column(
          children: <Widget>[
            CustomButton(
              buttonText: 'Physician',
              onPressed: () => Navigator.push(
                  context, CupertinoPageRoute(builder: (_) => RegisterPage())),
            ),
            SizedBox(height: SizeService.getPadding(44)),
            CustomButton(
              buttonText: 'People',
              onPressed: () => Navigator.push(context,
                  CupertinoPageRoute(builder: (_) => PeopleRegisterPage())),
            ),
          ],
        ),
      ),
    );
  }
}
