import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:tuoc/environment/custom_text_theme.dart';
import 'package:tuoc/environment/resource_string.dart';
import 'package:tuoc/model/my_profile/my_profile.dart';
import 'package:tuoc/page/my_schedule/my_list/my_list_page.dart';
import 'package:tuoc/page/profile/profile_presenter.dart';
import 'package:tuoc/service/size_service.dart';
import 'package:tuoc/widget/base_container.dart';
import 'package:tuoc/widget/data_not_found.dart';
import 'package:tuoc/widget/profile_image.dart';

class ProfilePage extends StatefulWidget {
  ProfilePage({Key key}) : super(key: key);

  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  final TextStyle _detailTextStyle = TextStyle(
    fontSize: SizeService.getFontSize(45),
    color: Color(0xff2E363C),
  );

  final double _detailSpace = 32;
  final double _detailRowSpace = 26;

  ProfilePresenter _presenter;

  @override
  void initState() {
    super.initState();

    _presenter = ProfilePresenter(this);
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BaseContainer(
      title: ResourceString.getString('my_profile'),
      hasProfile: false,
      child: _presenter.data != null && _presenter.data.length > 0
          ? _content()
          : Container(),
    );
  }

  Widget _content() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: SizeService.getPadding(86)),
      child: SingleChildScrollView(
        child: Stack(
          alignment: Alignment.topCenter,
          children: <Widget>[
            Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                SizedBox(height: SizeService.getWidth(240)),
                Container(
                  width: MediaQuery.of(context).size.width,
                  padding: EdgeInsets.only(top: SizeService.getPadding(240)),
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.5),
                    border: Border.all(color: Colors.white, width: 1.5),
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: Column(
                    children: _presenter.data.length > 0
                        ? <Widget>[
                            _titleDetail(_presenter.data[0]),
                            _detail(_presenter.data[0]),
                          ]
                        : _presenter.loader
                            ? [Container()]
                            : [DataNotFound()],
                  ),
                ),
                SizedBox(height: SizeService.getHeight(66)),
              ],
            ),
            ProfileImage(
              width: 480,
              showShadow: true,
            ),
          ],
        ),
      ),
    );
  }

  Widget _titleDetail(MyProfileDataModel data) {
    return Column(
      children: <Widget>[
        Text(
          '${data.fname ?? ''} ${data.lname ?? ''}',
          style: CustomTextTheme.content(context).copyWith(
            fontSize: SizeService.getFontSize(55),
          ),
        ),
        GestureDetector(
          onTap: _presenter.gotoEditProfile,
          child: Container(
            padding: EdgeInsets.symmetric(
                horizontal: SizeService.getPadding(20),
                vertical: SizeService.getPadding(8)),
            child: Text(
              ResourceString.getString('edit_profile'),
              style: CustomTextTheme.hintTextField(context).copyWith(
                decoration: TextDecoration.underline,
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _detail(MyProfileDataModel data) {
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(
            margin:
                EdgeInsets.symmetric(horizontal: SizeService.getPadding(46)),
            padding: EdgeInsets.only(
              bottom: SizeService.getPadding(_detailSpace),
              right: SizeService.getPadding(50),
              left: SizeService.getPadding(50),
            ),
            decoration: BoxDecoration(
                border:
                    Border(bottom: BorderSide(color: Colors.white, width: 1))),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                ///name
                Padding(
                  padding: EdgeInsets.only(
                    top: SizeService.getPadding(52),
                    bottom: SizeService.getPadding(_detailSpace),
                  ),
                  child: Text(
                    '${data.fname ?? ''} ${data.lname ?? ''}',
                    style: _detailTextStyle,
                  ),
                ),

                ///position
                Padding(
                  padding: EdgeInsets.only(
                      bottom: SizeService.getPadding(_detailSpace)),
                  child: Text(
                    '${data.work_position ?? ''}',
                    style: _detailTextStyle,
                  ),
                ),

                ///email
                Padding(
                  padding: EdgeInsets.only(
                      bottom: SizeService.getPadding(_detailSpace)),
                  child: Row(
                    children: <Widget>[
                      ImageIcon(
                        AssetImage('assets/icons/ic_mail.png'),
                        color: Color(0xff2E363C),
                        size: SizeService.getFontSize(64),
                      ),
                      SizedBox(width: SizeService.getPadding(_detailRowSpace)),
                      Expanded(
                        child: Text(
                          '${data.email ?? ''}',
                          style: _detailTextStyle,
                        ),
                      )
                    ],
                  ),
                ),

                ///phone number
                Padding(
                  padding: EdgeInsets.only(
                      bottom: SizeService.getPadding(_detailSpace)),
                  child: Row(
                    children: <Widget>[
                      ImageIcon(
                        AssetImage('assets/icons/ic_phone.png'),
                        color: Color(0xff2E363C),
                        size: SizeService.getFontSize(64),
                      ),
                      SizedBox(width: SizeService.getPadding(_detailRowSpace)),
                      Expanded(
                        child: Text(
                          '${data.phone ?? ''}',
                          style: _detailTextStyle,
                        ),
                      )
                    ],
                  ),
                ),

                ///fax
                Padding(
                  padding: EdgeInsets.only(
                      bottom: SizeService.getPadding(_detailSpace)),
                  child: Row(
                    children: <Widget>[
                      ImageIcon(
                        AssetImage('assets/icons/ic_fax.png'),
                        color: Color(0xff2E363C),
                        size: SizeService.getFontSize(64),
                      ),
                      SizedBox(width: SizeService.getPadding(_detailRowSpace)),
                      Expanded(
                        child: Text(
                          '${data.fax ?? ''}',
                          style: _detailTextStyle,
                        ),
                      )
                    ],
                  ),
                ),
              ],
            ),
          ),

          ///my schedule
          MaterialButton(
            padding: EdgeInsets.all(0),
            onPressed: () => Navigator.push(
                context, CupertinoPageRoute(builder: (_) => MyListPage())),
            child: Container(
              margin:
                  EdgeInsets.symmetric(horizontal: SizeService.getPadding(46)),
              padding: EdgeInsets.only(
                  left: SizeService.getPadding(50),
                  right: SizeService.getPadding(50),
                  bottom: SizeService.getPadding(_detailSpace),
                  top: SizeService.getPadding(_detailSpace)),
              decoration: BoxDecoration(
                  border: Border(
                      bottom: BorderSide(color: Colors.white, width: 1))),
              child: Row(
                children: <Widget>[
                  ImageIcon(
                    AssetImage('assets/icons/ic_calendar.png'),
                    color: Color(0xff2E363C),
                    size: SizeService.getFontSize(64),
                  ),
                  SizedBox(width: SizeService.getPadding(_detailRowSpace)),
                  Expanded(
                    child: Text(
                      ResourceString.getString('my_schedule'),
                      style: _detailTextStyle,
                    ),
                  )
                ],
              ),
            ),
          ),

          ///logout
          MaterialButton(
            padding: EdgeInsets.all(0),
            onPressed: _presenter.logout,
            child: Container(
              margin:
                  EdgeInsets.symmetric(horizontal: SizeService.getPadding(46)),
              padding: EdgeInsets.only(
                  left: SizeService.getPadding(50),
                  right: SizeService.getPadding(50),
                  bottom: SizeService.getPadding(_detailSpace),
                  top: SizeService.getPadding(_detailSpace)),
              decoration: BoxDecoration(
                  border: Border(
                      bottom: BorderSide(color: Colors.white, width: 1))),
              child: Row(
                children: <Widget>[
                  ImageIcon(
                    AssetImage('assets/icons/ic_logout.png'),
                    color: Color(0xff2E363C),
                    size: SizeService.getFontSize(64),
                  ),
                  SizedBox(width: SizeService.getPadding(_detailRowSpace)),
                  Expanded(
                    child: Text(
                      ResourceString.getString('logout'),
                      style: _detailTextStyle,
                    ),
                  )
                ],
              ),
            ),
          ),
          Container(
            margin: EdgeInsets.only(top: 14),
            child: Center(
              child: Text(
                _presenter.versionApp,
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: SizeService.getFontSize(45),
                  color: Color(0xff2E363C),
                ),
              ),
            ),
          ),
          SizedBox(height: SizeService.getPadding(50)),
        ],
      ),
    );
  }
}
