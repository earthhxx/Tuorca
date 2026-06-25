import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_device_type/flutter_device_type.dart';
import 'package:tuoc/environment/custom_text_theme.dart';
import 'package:tuoc/service/size_service.dart';
import 'package:tuoc/widget/profile_button.dart';

class BaseContainer extends StatelessWidget {
  final Widget child;
  final String title;
  final bool hasProfile;
  final Widget leading;

  BaseContainer({
    @required this.child,
    this.title,
    this.leading,
    this.hasProfile = true,
  });

  _appBar(BuildContext context) {
    final ModalRoute<dynamic> parentRoute = ModalRoute.of(context);
    final bool canPop = parentRoute?.canPop ?? false;

    var profile = [
      Container(
        padding: EdgeInsets.all(SizeService.getPadding(12)),
        child: ProfileButton(width: 124),
      ),
      SizedBox(width: SizeService.getPadding(36)),
    ];

    if (Device.get().isTablet) {
      return PreferredSize(
        preferredSize: Size(
          double.infinity,
          MediaQuery.of(context).padding.top + SizeService.getWidth(140),
        ),
        child: Row(
          children: <Widget>[
            Expanded(
              flex: 1,
              child: canPop
                  ? GestureDetector(
                      onTap: () => Navigator.pop(context),
                      child: Icon(Icons.arrow_back_ios,
                          color: Colors.white,
                          size: SizeService.getFontSize(52)),
                    )
                  : Container(),
            ),
            Expanded(
              flex: 4,
              child: Text(
                this.title ?? '',
                style: CustomTextTheme.titleBarText(context),
                textAlign: TextAlign.center,
              ),
            ),
            Expanded(
              flex: 1,
              child: this.hasProfile
                  ? AspectRatio(
                      aspectRatio: 1,
                      child: Container(
                        padding: EdgeInsets.all(SizeService.getPadding(26)),
                        child: ProfileButton(width: 124),
                      ),
                    )
                  : Container(),
            ),
          ],
        ),
      );
    } else {
      return AppBar(
        centerTitle: true,
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: Text(
          this.title ?? '',
          style: CustomTextTheme.titleBarText(context),
        ),
        leading: this.leading,
        actions: this.hasProfile ? profile : null,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment(-0.3, -1.2),
            end: Alignment(0.6, 1.05),
            colors: [
              Color(0xffA6F4D9),
              Color(0xff9FDFF8),
              Color(0xff3F95B6),
              Color(0xff3F95B6),
            ],
            stops: [
              0,
              0.2,
              0.5,
              1,
            ],
          ),
        ),
        child: Scaffold(
          backgroundColor: Colors.transparent,
          appBar: _appBar(context),
          body: child,
        ),
      ),
    );
  }
}
