import 'package:flutter/material.dart';
import 'package:flutter_device_type/flutter_device_type.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:tuoc/service/size_service.dart';
import 'package:tuoc/util/string_format_util.dart';

class CalendarView extends StatefulWidget {
  CalendarController controller;
  final DateTime selectedDate;
  final void Function(DateTime) onSelectDate;

  final Function onChangeMonth;
  final Function onChangeMode;
  final Function setListHeight;
  final Color eventColor;
  final Map<DateTime, List<String>> events;

  CalendarView({
    Key key,
    this.selectedDate,
    this.onSelectDate,
    this.controller,
    this.events,
    this.onChangeMonth,
    this.eventColor = Colors.white,
    this.onChangeMode,
    this.setListHeight,
  }) {
    this.controller = this.controller ?? CalendarController();
  }

  @override
  _CalendarViewState createState() => _CalendarViewState();
}

class _CalendarViewState extends State<CalendarView> {
  GlobalKey calendarWidgetKey = GlobalKey();
  GlobalKey titleWidgetKey = GlobalKey();

  final double _fontSize = Device.get().isTablet ? 32 : 40;

  final double topPaddingDate = Device.get().isTablet ? 0 : 32;

  bool _expandCalendar = false;

  @override
  void initState() {
    super.initState();

    Future.delayed(Duration.zero, () {
      var box =
          calendarWidgetKey.currentContext.findRenderObject() as RenderBox;
      var titleBox =
          titleWidgetKey.currentContext.findRenderObject() as RenderBox;

      if (widget.setListHeight != null) {
        widget.setListHeight(box.size.height + titleBox.size.height);
      }
    });
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          _headerCalendar(),
          TableCalendar(
            key: calendarWidgetKey,
            rowHeight:
                Device.get().isTablet ? SizeService.getHeight(135) : null,
            calendarController: this.widget.controller,
            availableGestures: AvailableGestures.horizontalSwipe,
            initialSelectedDay: this.widget.selectedDate,
            availableCalendarFormats: {
              CalendarFormat.month: 'Month',
              CalendarFormat.twoWeeks: '2 weeks',
            },
            onVisibleDaysChanged: (f, l, fm) {
              if (widget.onChangeMonth != null) widget.onChangeMonth(f, l);
              if (widget.setListHeight != null) {
                Future.delayed(Duration(milliseconds: 200), () {
                  var box = calendarWidgetKey.currentContext.findRenderObject()
                      as RenderBox;
                  var titleBox = titleWidgetKey.currentContext
                      .findRenderObject() as RenderBox;
                  widget.setListHeight(box.size.height + titleBox.size.height);
                });
              }
            },
            daysOfWeekStyle: DaysOfWeekStyle(
              dowTextBuilder: (dt, e) {
                return '${DateFormat('EEE').format(dt).toUpperCase()}';
              },
              weekdayStyle: TextStyle(
                color: Colors.white,
                fontSize: SizeService.getFontSize(36),
              ),
              weekendStyle: TextStyle(
                color: Colors.white,
                fontSize: SizeService.getFontSize(36),
              ),
            ),
            onDaySelected: (DateTime date, List events, [List holidays]) {
              if (widget.onSelectDate != null) {
                setState(() {
                  widget.onSelectDate(date);
                  print(date);
                });
              }
            },

            // onDaySelected: widget.onSelectDate,
            builders: CalendarBuilders(
                dayBuilder: (context, dt, ldt) => _dateInsideWidget(dt),
                outsideWeekendDayBuilder: (context, dt, ldt) =>
                    _dateOutsideWidget(dt),
                outsideDayBuilder: (context, dt, ldt) => _dateOutsideWidget(dt),
                selectedDayBuilder: (context, dt, ldt) => _dateSelectWidget(dt),
                todayDayBuilder: (context, dt, ldt) => _dateToday(dt),
                markersBuilder: (context, dt, le, lh) {
                  final children = <Widget>[];

                  if (le.isNotEmpty) {
                    if (this.widget.selectedDate.day != dt.day)
                      children.add(
                        Container(
                          margin: EdgeInsets.all(SizeService.getPadding(8)),
                          decoration: BoxDecoration(
                            color: Colors.white.withOpacity(.4),
                            borderRadius: BorderRadius.circular(15),
                          ),
                          child: Column(
                            children: <Widget>[
                              SizedBox(
                                  height:
                                      SizeService.getPadding(topPaddingDate)),
                              Expanded(
                                child: Text(
                                  dt.day.toString(),
                                  style: TextStyle(
                                    fontSize:
                                        SizeService.getFontSize(_fontSize),
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                              Expanded(child: Container()),
                            ],
                          ),
                        ),
                      );
                    if (children.length < 3)
                      children.add(
                        Positioned(
                          bottom: SizeService.getPadding(
                              Device.get().isTablet ? 22 : 36),
                          child: Row(
                            children: le
                                .getRange(0, le.length > 2 ? 3 : le.length)
                                .map((e) {
                              // print("children ${children}");
                              // print("e ${e}");
                              // print("le ${le.length}");

                              return Container(
                                margin: EdgeInsets.symmetric(horizontal: 1.5),
                                decoration: BoxDecoration(
                                  color: le.length < 5
                                      ? Colors.green
                                      : le.length < 10
                                          ? this.widget.eventColor
                                          : Colors.red,
                                  borderRadius: BorderRadius.circular(50),
                                ),
                                width: SizeService.getWidth(26),
                                height: SizeService.getWidth(16),
                              );
                            }).toList(),
                          ),
                        ),
                      );
                  }

                  return children;
                }),
            headerVisible: false,
            events: this.widget.events,
          ),
        ],
      ),
    );
  }

  Widget _dateOutsideWidget(DateTime dt) {
    return Container(
      margin: EdgeInsets.all(SizeService.getPadding(8)),
      child: Column(
        children: <Widget>[
          SizedBox(height: SizeService.getPadding(topPaddingDate)),
          Expanded(
            child: Container(
              child: Text(
                dt.day.toString(),
                style: TextStyle(
                  fontSize: SizeService.getFontSize(_fontSize),
                  color: Colors.white.withOpacity(.4),
                ),
              ),
            ),
          ),
          Expanded(child: Container()),
        ],
      ),
    );
  }

  Widget _dateInsideWidget(DateTime dt) {
    return Container(
      margin: EdgeInsets.all(SizeService.getPadding(8)),
      color: Colors.transparent,
      child: Column(
        children: <Widget>[
          SizedBox(height: SizeService.getPadding(topPaddingDate)),
          Expanded(
            child: Text(
              dt.day.toString(),
              style: TextStyle(
                fontSize: SizeService.getFontSize(_fontSize),
                color: Colors.white,
              ),
            ),
          ),
          Expanded(child: Container()),
        ],
      ),
    );
  }

  Widget _dateToday(DateTime dt) {
    return Container(
      margin: EdgeInsets.all(SizeService.getPadding(8)),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
        border: Border.all(color: Color(0xffc00026)),
      ),
      child: Column(
        children: <Widget>[
          SizedBox(height: SizeService.getPadding(topPaddingDate)),
          Expanded(
            child: Text(
              dt.day.toString(),
              style: TextStyle(
                fontSize: SizeService.getFontSize(_fontSize),
                color: Color(0xffc00026),
              ),
            ),
          ),
          Expanded(child: Container()),
        ],
      ),
    );
  }

  Widget _dateSelectWidget(DateTime dt) {
    return Container(
      margin: EdgeInsets.all(SizeService.getPadding(6)),
      decoration: BoxDecoration(
        color: Color(0xffc00026),
        borderRadius: BorderRadius.circular(15),
        border: Border.all(color: Color(0xffc00026)),
        boxShadow: [
          BoxShadow(
            color: Color(0xffc00026).withOpacity(.3),
            blurRadius: 3,
          ),
        ],
      ),
      child: Column(
        children: <Widget>[
          SizedBox(height: SizeService.getPadding(topPaddingDate)),
          Expanded(
            child: Text(
              dt.day.toString(),
              style: TextStyle(
                fontSize: SizeService.getFontSize(_fontSize),
                color: Colors.white,
              ),
            ),
          ),
          Expanded(child: Container()),
        ],
      ),
    );
  }

  Widget _headerCalendar() {
    return Padding(
      key: titleWidgetKey,
      padding: EdgeInsets.only(
          left: SizeService.getPadding(40),
          right: SizeService.getPadding(40),
          bottom: SizeService.getPadding(Device.get().isTablet ? 10 : 40)),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Text(
            '${StringFormatUtil().getMonthHeaderCalendar(widget.controller.focusedDay ?? widget.selectedDate)}',
            style: TextStyle(
              fontSize:
                  SizeService.getFontSize(Device.get().isTablet ? 36 : 52),
              fontWeight: FontWeight.bold,
            ),
          ),
          GestureDetector(
            onTap: () {
              setState(() {
                if (_expandCalendar) {
                  _expandCalendar = false;
                  this
                      .widget
                      .controller
                      .setCalendarFormat(CalendarFormat.twoWeeks);
                } else {
                  _expandCalendar = true;
                  this
                      .widget
                      .controller
                      .setCalendarFormat(CalendarFormat.month);
                }

                widget.onChangeMode(_expandCalendar);
              });
            },
            child: Icon(
              FontAwesomeIcons.calendarAlt,
              size: SizeService.getFontSize(Device.get().isTablet ? 44 : 66),
            ),
          )
        ],
      ),
    );
  }
}
