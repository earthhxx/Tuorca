import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_device_type/flutter_device_type.dart';
import 'package:intl/intl.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';
import 'package:tuoc/environment/base_color.dart';
import 'package:tuoc/environment/custom_text_theme.dart';
import 'package:tuoc/environment/resource_string.dart';
import 'package:tuoc/model/surgery/surgery_list.dart';
import 'package:tuoc/service/size_service.dart';
import 'package:tuoc/util/color_util.dart';
import 'package:tuoc/widget/base_container.dart';
import 'package:tuoc/widget/calendar_view.dart';
import 'package:tuoc/widget/custom_button.dart';
import 'package:tuoc/widget/data_not_found.dart';

import 'surgery_schedule_list_presenter.dart';

class SurgeryScheduleListPage extends StatefulWidget {
  final String roomId;
  final String roomName;

  SurgeryScheduleListPage({Key key, this.roomId, this.roomName})
      : super(key: key);

  @override
  _SurgeryScheduleListPageState createState() =>
      _SurgeryScheduleListPageState();
}

class _SurgeryScheduleListPageState extends State<SurgeryScheduleListPage> {
  SurgerySchedulePresenter _presenter;
  bool canExpand = true;
  var heightList = Device.get().isTablet ? 380.0 : 800.0;
  GlobalKey _containerKey = GlobalKey();
  double heightContainer = 0.0;

  @override
  void initState() {
    super.initState();

    _presenter = SurgerySchedulePresenter(
      this,
    );
    onOpen();
  }

  onOpen() {
    Future.delayed(Duration.zero, () async {
      RenderBox box = await _containerKey.currentContext.findRenderObject();
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
      title: '${widget.roomName}',
      child: _content(),
    );
  }

  Widget _content() {
    var maxHeight = MediaQuery.of(context).size.height -
        (MediaQuery.of(context).padding.top);
    var _dateFormat = DateFormat('d MMMM yyyy');
    var checkDate = _dateFormat.format(_presenter.selectedDate);

    String myDate = checkDate;
    // print(myDate);
    return Stack(
      key: _containerKey,
      alignment: Alignment.bottomCenter,
      children: <Widget>[
        SlidingUpPanel(
          minHeight: heightList,
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
            setListHeight: (double v) {
              setState(() {
                heightList =
                    heightContainer - v - MediaQuery.of(context).padding.bottom;
              });
            },
            eventColor: Color(0xffff8f00),
          ),
        ),
        Padding(
          padding: EdgeInsets.only(
            bottom: MediaQuery.of(context).padding.bottom +
                SizeService.getPadding(36),
            left: SizeService.getPadding(50),
            right: SizeService.getPadding(50),
          ),
          child: checkDate == "16" && widget.roomId == "4"
              ? Container()
              : CustomButton(
                  onPressed: _presenter.createSchedule,
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
          Text(
            'cases in the day:${_presenter.listEvent.length}',
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
              return DataNotFound(
                  colorText: Color(0xff2E363C),
                  height: SizeService.getPadding(
                      Device.get().isTablet ? 140 : 300));
            }
          },
        ),
      ),
    );
  }

  onSelectDate(DateTime date, List event, List holidays) {
    setState(() {
      _presenter.selectedDate = date;
    });
  }

  Widget _listScheduleItem(int index, SurgeryListDataModel data) {
    return MaterialButton(
      padding: EdgeInsets.all(0),
      onPressed: () => _presenter.gotoDetail(data.surgeryId),
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
                  color: data.groupColor != null
                      ? HexColor(data.groupColor)
                      : BaseColor.surgeryColor(),
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

  Widget _dateItem(SurgeryListDataModel data) {
    var monthFormat = DateFormat('MMM');
    var timeFormat = DateFormat('HH.mm');

    DateTime startDate = DateTime.parse(data.scheduleStartDatetime);
    DateTime endDate = DateTime.parse(data.scheduleEndDatetime);
    // print("datetime ${data.vip_name}");
    // print(timeFormat.format(startDate));
    var checkstartDate = double.parse(timeFormat.format(startDate));

    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: <Widget>[
              Text(
                '${startDate.day}',
                style: CustomTextTheme.content(context).copyWith(
                  fontSize: SizeService.getFontSize(65),
                  height: 1,
                ),
              ),
              SizedBox(width: SizeService.getPadding(16)),
              Text(
                '${monthFormat.format(startDate).toUpperCase()}',
                style: CustomTextTheme.content(context),
              )
            ],
          ),
          // Text(
          //   '${timeFormat.format(startDate)} - ${timeFormat.format(endDate)}',
          //   style: CustomTextTheme.content(context),
          // ),
          SizedBox(
            height: 16,
          ),
          data.vip_name == "YES" || data.vip_code == "V-001"
              ? Container(
                  alignment: Alignment.center,
                  child: Text(
                    'นอกเวลา',
                    style: TextStyle(color: Colors.red, fontSize: 24),
                  ),
                )
              : Container(
                  alignment: Alignment.center,
                  child: Text(
                    'ในเวลา',
                    style: TextStyle(color: Color(0xff3C95B5), fontSize: 24),
                  ),
                )
        ],
      ),
    );
  }

  Widget _detailItem(int index, SurgeryListDataModel data) {
    // print("getColor ${data.groupColor}");
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            '${data.staffName ?? ''}',
            style: CustomTextTheme.content(context).copyWith(
              height: 1,
            ),
          ),
//          data.dx != null && data.dx.length > 0 ? Text(
//            'DX : ${data.dx[0]}',
//            style: CustomTextTheme.content(context),
//          ) : Container(),
          data.op != null && data.op.length > 0
              ? Text(
                  'OP : ${data.op[0]}',
                  style: CustomTextTheme.content(context),
                )
              : Container(),
          SizedBox(
            height: 5,
          ),
          data.patientName != null && data.patientName.length > 0
              ? Container(
                  alignment: Alignment.center,
                  height: SizeService.getWidth(100),
                  decoration: BoxDecoration(
                    color: data.groupColor != null
                        ? HexColor(data.groupColor)
                        : BaseColor.surgeryColor(),
                    borderRadius: BorderRadius.circular(7.5),
                  ),
                  child: Text(
                    'Patient : ${data.patientName}',
                    style: TextStyle(color: Colors.white),
                  ),
                )
              : Container(),
        ],
      ),
    );
  }
}
