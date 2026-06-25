import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_device_type/flutter_device_type.dart';
import 'package:intl/intl.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';
import 'package:tuoc/environment/base_color.dart';
import 'package:tuoc/environment/custom_text_theme.dart';
import 'package:tuoc/environment/resource_string.dart';
import 'package:tuoc/model/activity/list/activity_list.dart';
import 'package:tuoc/page/activity_schedule/activity_list/activity_list_presenter.dart';
import 'package:tuoc/service/size_service.dart';
import 'package:tuoc/widget/base_container.dart';
import 'package:tuoc/widget/calendar_view.dart';
import 'package:tuoc/widget/custom_button.dart';
import 'package:tuoc/widget/data_not_found.dart';

class ActivityListPage extends StatefulWidget {
  ActivityListPage({Key key}) : super(key: key);

  @override
  _ActivityListPageState createState() => _ActivityListPageState();
}

class _ActivityListPageState extends State<ActivityListPage> {
  ActivityListPresenter _presenter;
  var heightList = Device.get().isTablet ? 500.0 : 800.0;
  GlobalKey _containerKey = GlobalKey();
  double heightContainer = 0.0;

  @override
  void initState() {
    super.initState();

    _presenter = ActivityListPresenter(this);

    Future.delayed(Duration.zero, () {
      RenderBox box = _containerKey.currentContext.findRenderObject();
      heightContainer = box.size.height;
    });
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BaseContainer(
      title: ResourceString.getString('activity_schedule'),
      child: _content(),
    );
  }

  Widget _content() {
    var maxHeight = MediaQuery.of(context).size.height -
        (MediaQuery.of(context).padding.top);

    return Stack(
      key: _containerKey,
      alignment: Alignment.bottomCenter,
      children: <Widget>[
        SlidingUpPanel(
          minHeight: heightList + MediaQuery.of(context).padding.bottom,
          maxHeight: maxHeight,
          borderRadius: BorderRadius.vertical(top: Radius.circular(40)),
          panel: ClipRRect(
            borderRadius: BorderRadius.vertical(top: Radius.circular(40)),
            child: Container(
              color: Colors.white,
              child: Column(
                children: <Widget>[
                  _linePush(),
                  _dateRow(),
                  _listSchedule(),
                ],
              ),
            ),
          ),
          body: CalendarView(
            controller: _presenter.calendarController,
            selectedDate: _presenter.selectedDate,
            onSelectDate: _presenter.onSelectDate,
            onChangeMonth: _presenter.onChangedMonth,
            events: _presenter.events,
            eventColor: BaseColor.activityColor(),
            setListHeight: (double v) {
              setState(() {
                heightList =
                    heightContainer - v - MediaQuery.of(context).padding.bottom;
              });
            },
          ),
        ),
        Padding(
          padding: EdgeInsets.only(
            bottom: MediaQuery.of(context).padding.bottom +
                SizeService.getPadding(36),
            left: SizeService.getPadding(50),
            right: SizeService.getPadding(50),
          ),
          child: CustomButton(
            onPressed: _presenter.gotoCreate,
            radius: 10,
            buttonText: ResourceString.getString('create_schedule'),
          ),
        ),
      ],
    );
  }

  Widget _linePush() {
    return Container(
      margin: EdgeInsets.only(
        top: SizeService.getPadding(50),
        bottom: SizeService.getPadding(20),
      ),
      width: SizeService.getWidth(150),
      height: SizeService.getWidth(16),
      decoration: BoxDecoration(
        color: Color(0xffCCCCCC),
        borderRadius: BorderRadius.circular(5),
      ),
    );
  }

  Widget _dateRow() {
    var _monthFormat = DateFormat('MMMM');
    var _dateFormat = DateFormat('d MMMM yyyy');

    return Padding(
      padding: EdgeInsets.symmetric(horizontal: SizeService.getPadding(64)),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Text(
            '${_monthFormat.format(_presenter.selectedDate)}',
            style: CustomTextTheme.regularText(context),
          ),
          Text(
            '${_dateFormat.format(_presenter.selectedDate)}',
            style: CustomTextTheme.regularText(context)
                .copyWith(color: Color(0xff2E363C).withOpacity(0.6)),
          ),
        ],
      ),
    );
  }

  Widget _listSchedule() {
    return Expanded(
      child: RefreshIndicator(
        key: _presenter.refreshKey,
        onRefresh: _presenter.onRefresh,
        child: ListView.builder(
          padding: EdgeInsets.only(
              bottom: MediaQuery.of(context).padding.bottom +
                  SizeService.getHeight(360)),
          itemCount:
              _presenter.listEvent.length > 0 ? _presenter.listEvent.length : 1,
          itemBuilder: (context, index) {
            if (_presenter.listEvent.length > 0) {
              return _listScheduleItem(index, _presenter.listEvent[index]);
            } else {
              return _presenter.loader
                  ? Container()
                  : DataNotFound(
                      colorText: Color(0xff2E363C),
                      height: SizeService.getPadding(
                          Device.get().isTablet ? 140 : 300));
            }
          },
        ),
      ),
    );
  }

  Widget _listScheduleItem(int index, ActivityListDataModel data) {
    return MaterialButton(
      padding: EdgeInsets.all(0),
      onPressed: () => _presenter.gotoDetail(data.activity_id),
      child: Container(
        padding: EdgeInsets.symmetric(vertical: SizeService.getPadding(64)),
        decoration: BoxDecoration(
            border: Border(
                bottom: BorderSide(color: Color(0xff3C95B5), width: 0.5))),
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: SizeService.getPadding(64)),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Expanded(
                flex: 4,
                child: _dateItem(data),
              ),
              Container(
                margin: EdgeInsets.symmetric(
                    horizontal: SizeService.getPadding(40)),
                height: SizeService.getHeight(100),
                width: SizeService.getWidth(15),
                decoration: BoxDecoration(
                  color: BaseColor.activityColor(),
                  borderRadius: BorderRadius.circular(7.5),
                ),
              ),
              Expanded(
                flex: 8,
                child: _detailItem(index, data),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _dateItem(ActivityListDataModel data) {
    var monthFormat = DateFormat('MMM');
    var timeFormat = DateFormat('HH.mm');
    var startData = DateTime.parse(data.schedule_start_datetime);
    var endData = DateTime.parse(data.schedule_end_datetime);

    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: <Widget>[
              Text(
                '${(startData.day != endData.day ? '${startData.day}-${endData.day}' : startData.day)}',
                style: CustomTextTheme.content(context).copyWith(
                  fontSize: SizeService.getFontSize(65),
                  height: 1,
                ),
              ),
              SizedBox(width: SizeService.getPadding(16)),
              Text(
                '${monthFormat.format(endData).toUpperCase()}',
                style: CustomTextTheme.content(context),
              )
            ],
          ),
          Text(
            '${timeFormat.format(startData)} - ${timeFormat.format(endData)}',
            style: CustomTextTheme.content(context),
          )
        ],
      ),
    );
  }

  Widget _detailItem(int index, ActivityListDataModel data) {
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          data.activity_type_code_name != null &&
                  data.activity_type_code_name.isNotEmpty
              ? Text(
                  '${data.activity_type_code_name ?? ''}',
                  style: CustomTextTheme.content(context).copyWith(
                    height: 1,
                  ),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                )
              : Container(),
          data.title != null && data.title.isNotEmpty
              ? Text(
                  '${data.title ?? ''}',
                  style: CustomTextTheme.content(context),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                )
              : Container(),
          data.presenter_1 != null && data.presenter_1.isNotEmpty
              ? Text(
                  '${data.presenter_1 ?? ''}',
                  style: CustomTextTheme.content(context),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                )
              : Container(),
          data.venue != null && data.venue.isNotEmpty
              ? Text(
                  '${data.venue ?? ''}',
                  style: CustomTextTheme.content(context),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                )
              : Container(),
        ],
      ),
    );
  }
}
