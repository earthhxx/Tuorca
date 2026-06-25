import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:tuoc/service/size_service.dart';
import 'package:tuoc/util/account_util.dart';

class ProfileImage extends StatefulWidget {
  final String imageUrl;
  final double width;
  final bool showShadow;
  final double borderWidth;
  final File imageFile;

  ProfileImage(
      {this.width = 600,
      this.showShadow = false,
      this.borderWidth = 16,
      this.imageUrl,
      this.imageFile});

  @override
  _ProfileImageState createState() => _ProfileImageState();
}

class _ProfileImageState extends State<ProfileImage> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: SizeService.getWidth(this.widget.width),
      height: SizeService.getWidth(this.widget.width),
      child: Container(
        padding:
            EdgeInsets.all(SizeService.getPadding(this.widget.borderWidth)),
        decoration: BoxDecoration(
          color: Color(0xffafd8ed),
          borderRadius: BorderRadius.circular(1000),
          boxShadow: this.widget.showShadow
              ? [
                  BoxShadow(
                    color: Colors.black.withOpacity(.2),
                    offset: Offset(0, 5),
                    blurRadius: 5,
                  )
                ]
              : null,
        ),
        child: Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(1000),
          ),
          child: FutureBuilder<String>(
            future: AccountUtil.getImageProfile(),
            builder: (context, data) {
              if (data.data != null &&
                  data.connectionState == ConnectionState.done) {
                return ClipRRect(
                  borderRadius: BorderRadius.circular(1000),
                  child: this.widget.imageFile == null
                      ? CachedNetworkImage(
                          imageUrl: '${data.data ?? ''}',
                          errorWidget: (context, txt, t) {
                            return Image.asset(
                              'assets/icons/profile_defualt.png',
                              fit: BoxFit.fill,
                            );
                          },
                          fit: BoxFit.cover,
                        )
                      : Image.file(this.widget.imageFile, fit: BoxFit.cover),
                );
              } else {
                return Container();
              }
            },
          ),
        ),
      ),
    );
  }
}
