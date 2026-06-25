import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_device_type/flutter_device_type.dart';
import 'package:intl/intl.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';
import 'package:tuoc/environment/base_color.dart';
import 'package:tuoc/environment/custom_text_theme.dart';
import 'package:tuoc/environment/resource_string.dart';
import 'package:tuoc/model/surgery/surgery_list.dart';
import 'package:tuoc/page/my_schedule/my_list/my_list_presenter.dart';
import 'package:tuoc/service/size_service.dart';
import 'package:tuoc/widget/base_container.dart';
import 'package:tuoc/widget/calendar_view.dart';
import 'package:tuoc/widget/data_not_found.dart';

class MyListPage extends StatefulWidget {
  MyListPage({Key key}) : super(key: key);

  @override
  _MyListPageState createState() => _MyListPageState();
}

class _MyListPageState extends State<MyListPage> {
  MyListPresenter _presenter;
  var heightList = Device.get().isTablet ? 500.0 : 800.0;
  GlobalKey _containerKey = GlobalKey();
  double heightContainer = 0.0;

  @override
  void initState() {
    super.initState();

    _presenter = MyListPresenter(this);

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
      title: ResourceString.getString('my_schedule'),
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
            eventColor: BaseColor.surgeryColor(),
            setListHeight: (double v) {
              print(v);
              setState(() {
                heightList =
                    heightContainer - v - MediaQuery.of(context).padding.bottom;
              });
            },
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
                  : DataNotFound(colorText: Color(0xff2E363C));
            }
          },
        ),
      ),
    );
  }

  Widget _listScheduleItem(int index, SurgeryListDataModel data) {
    return MaterialButton(
      padding: EdgeInsets.all(0),
      onPressed: () => _presenter.gotoDetail(data.surgeryId, data.roomId),
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
                  color: BaseColor.surgeryColor(),
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
          Text(
            '${timeFormat.format(startDate)} - ${timeFormat.format(endDate)}',
            style: CustomTextTheme.content(context),
          ),
          Text(
            '${data.roomName}',
            style: CustomTextTheme.content(context),
          )
        ],
      ),
    );
  }

  Widget _detailItem(int index, SurgeryListDataModel data) {
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
          data.op != null && data.op.length > 0
              ? Text(
                  'OP : ${data.op[0]}',
                  style: CustomTextTheme.content(context),
                )
              : Container(),
        ],
      ),
    );
  }
}
