import 'package:flutter/material.dart';
import 'package:flutter_device_type/flutter_device_type.dart';
import 'package:tuoc/page/academic_schedule/academic_list/academic_list_page.dart';
import 'package:tuoc/page/activity_schedule/activity_list/activity_list_page.dart';
import 'package:tuoc/page/home/date_time_view.dart';
import 'package:tuoc/page/home/home_presenter.dart';
import 'package:tuoc/page/service_schedule/service_list/service_list_page.dart';
import 'package:tuoc/page/surgery_schedule/surgery_room/surgery_schedule_room.dart';
import 'package:tuoc/service/size_service.dart';
import 'package:tuoc/widget/base_container.dart';

import 'home_menu_item.dart';

class HomePage extends StatefulWidget {
  HomePage({Key key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  HomePresenter _presenter;
  bool isTablet = Device.get().isTablet;

  @override
  void initState() {
    super.initState();

    _presenter = HomePresenter(this);
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BaseContainer(
      title: 'Orthopaedics Calendar',
      child: _context(context),
    );
  }

  Widget _context(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(
        right: SizeService.getPadding(82),
        left: SizeService.getPadding(82),
        top: SizeService.getPadding(isTablet ? 20 : 84),
        bottom: MediaQuery.of(context).padding.bottom +
            SizeService.getPadding(isTablet ? 40 : 84),
      ),
      child: Column(
        children: <Widget>[
          DateTimeView(),
          SizedBox(height: SizeService.getPadding(isTablet ? 32 : 56)),
          Expanded(
            child: Row(
              children: <Widget>[
                Expanded(
                  child: HomeMenuItem(
                    imagePath: 'assets/icons/ic_surgery.png',
                    title: 'Surgery',
                    color: Color(0xffFF9900),
                    // page: SurgeryScheduleListPage(),
                    page: SurgeryScheduleRoom(),
                  ),
                ),
                SizedBox(width: SizeService.getPadding(66)),
                Expanded(
                  child: HomeMenuItem(
                    imagePath: 'assets/icons/ic_service.png',
                    title: 'Service',
                    color: Color(0xffF2A7BE),
                    page: ServiceListPage(),
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: SizeService.getPadding(isTablet ? 32 : 56)),
          Expanded(
            child: Row(
              children: <Widget>[
                Expanded(
                  child: HomeMenuItem(
                    imagePath: 'assets/icons/ic_academic.png',
                    title: 'Academic',
                    color: Color(0xff4FAFA1),
                    page: AcademicListPage(),
                  ),
                ),
                SizedBox(width: SizeService.getPadding(66)),
                Expanded(
                  child: HomeMenuItem(
                    imagePath: 'assets/icons/ic_activities.png',
                    title: 'Activity',
                    color: Color(0xffDF6F5B),
                    page: ActivityListPage(),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}