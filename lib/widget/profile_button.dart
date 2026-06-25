import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:tuoc/page/profile/profile_page.dart';
import 'package:tuoc/widget/profile_image.dart';

class ProfileButton extends StatelessWidget {
  final double width;
  final bool showShadow;
  final double borderWidth;

  ProfileButton({this.width, this.showShadow = false, this.borderWidth = 8});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => Navigator.push(
          context, CupertinoPageRoute(builder: (_) => ProfilePage())),
      child: AspectRatio(
        aspectRatio: 1,
        child: ProfileImage(
          width: this.width,
          showShadow: this.showShadow,
          borderWidth: this.borderWidth,
        ),
      ),
    );
  }
}
