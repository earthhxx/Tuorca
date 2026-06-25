import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:tuoc/service/size_service.dart';

class MyPickerDate {
  final BuildContext context;
  final DateTime initialDate;
  final Function onSelected;

  MyPickerDate(this.context, {this.initialDate, this.onSelected}) {
    showCupertinoModalPopup(
      context: this.context,
      builder: (_) => MyPickerDateView(
        initialDate: this.initialDate,
        onSelected: this.onSelected,
      ),
    );
  }
}

class MyPickerDateView extends StatefulWidget {
  final DateTime initialDate;
  final Function onSelected;

  MyPickerDateView({
    this.initialDate,
    this.onSelected,
  });

  @override
  _MyPickerDateViewState createState() => _MyPickerDateViewState();
}

class _MyPickerDateViewState extends State<MyPickerDateView> {
  final double _fontSize = 40;
  final double topPaddingDate = 28;
  CalendarController _controller = CalendarController();
  DateTime _dateSelected = DateTime.now();

  @override
  void initState() {
    super.initState();

    _dateSelected = widget.initialDate ?? _dateSelected;
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        color: Colors.black.withOpacity(0.4),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Container(
              margin:
                  EdgeInsets.symmetric(horizontal: SizeService.getPadding(44)),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(20),
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  _headerCalendar(),
                  _monthSelection(),
                  _calendar(),
                  _btnAction(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _calendar() {
    return TableCalendar(
      calendarController: _controller,
      availableGestures: AvailableGestures.verticalSwipe,
      initialSelectedDay: _dateSelected,
      daysOfWeekStyle: DaysOfWeekStyle(
        dowTextBuilder: (dt, e) {
          return '${DateFormat('EEE').format(dt).toUpperCase()}';
        },
        weekdayStyle: TextStyle(
          color: Color(0xff2E363C),
        ),
        weekendStyle: TextStyle(
          color: Color(0xff2E363C),
        ),
      ),

      // onDaySelected: (DateTime d) {
      //   setState(() {
      //     _dateSelected = d;
      //   });
      // },
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
              if (_dateSelected.day != dt.day)
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
                            height: SizeService.getPadding(topPaddingDate)),
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
                  ),
                );
              if (children.length < 3)
                children.add(
                  Positioned(
                    bottom: SizeService.getPadding(36),
                    child: Row(
                      children: le
                          .getRange(0, le.length > 2 ? 3 : le.length)
                          .map((e) {
                        return Container(
                          margin: EdgeInsets.symmetric(horizontal: 1.5),
                          decoration: BoxDecoration(
                            color: Color(0xffff8f00),
                            borderRadius: BorderRadius.circular(50),
                          ),
                          width: 10,
                          height: 6,
                        );
                      }).toList(),
                    ),
                  ),
                );
            }

            return children;
          }),
      headerVisible: false,
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
                  color: Colors.transparent,
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
                color: Color(0xff2E363C),
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
    DateFormat dt = DateFormat('EEE d MMM');

    return Padding(
      padding: EdgeInsets.only(
        left: SizeService.getPadding(44),
        right: SizeService.getPadding(44),
        bottom: SizeService.getPadding(44),
        top: SizeService.getPadding(64),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            '${(_dateSelected.year)}',
            style: TextStyle(
                fontSize: SizeService.getFontSize(45),
                fontWeight: FontWeight.w500,
                color: Color(0xff6c6c6c)),
          ),
          Text(
            '${dt.format(_dateSelected).toUpperCase()}',
            style: TextStyle(
              fontSize: SizeService.getFontSize(52),
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }

  _btnAction() {
    return Row(
      children: <Widget>[
        Expanded(
          child: MaterialButton(
            onPressed: () {
              Navigator.pop(context);
            },
            color: Colors.white,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(20),
              ),
              side: BorderSide(
                color: Color(0xff6c6c6c).withOpacity(0.5),
                width: 0.2,
              ),
            ),
            padding: EdgeInsets.symmetric(vertical: SizeService.getPadding(44)),
            child: Text(
              'Cancel',
              style: TextStyle(
                fontSize: SizeService.getFontSize(44),
                color: Theme.of(context).primaryColor,
              ),
            ),
          ),
        ),
        Expanded(
          child: MaterialButton(
            onPressed: () {
              Navigator.pop(context);
              if (widget.onSelected != null) widget.onSelected(_dateSelected);
            },
            color: Colors.white,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.only(bottomRight: Radius.circular(20)),
              side: BorderSide(
                color: Color(0xff6c6c6c).withOpacity(0.5),
                width: 0.2,
              ),
            ),
            padding: EdgeInsets.symmetric(vertical: SizeService.getPadding(44)),
            child: Text(
              'OK',
              style: TextStyle(
                fontSize: SizeService.getFontSize(44),
                color: Theme.of(context).primaryColor,
              ),
            ),
          ),
        ),
      ],
    );
  }

  _monthSelection() {
    DateFormat dt = DateFormat('MMMM yyyy');
    return Container(
      margin: EdgeInsets.symmetric(
        horizontal: SizeService.getPadding(44),
        vertical: SizeService.getPadding(34),
      ),
      padding: EdgeInsets.symmetric(
        horizontal: SizeService.getPadding(34),
        vertical: SizeService.getPadding(24),
      ),
      decoration: BoxDecoration(
        color: Color(0xffd6eaf0),
        borderRadius: BorderRadius.circular(50),
      ),
      child: Row(
        children: <Widget>[
          GestureDetector(
            onTap: () {
              var date = _controller.focusedDay ?? _dateSelected;
              var v = new DateTime(date.year, date.month - 1, date.day);
              setState(() {
                _controller.setFocusedDay(v);
              });
            },
            child: Icon(Icons.arrow_back_ios,
                color: Colors.blueGrey, size: SizeService.getFontSize(66)),
          ),
          Expanded(
            child: Container(
              alignment: Alignment.center,
              child: Text(
                '${dt.format(_controller.focusedDay ?? _dateSelected).toUpperCase()}',
                style: TextStyle(
                  fontSize: SizeService.getFontSize(46),
                ),
              ),
            ),
          ),
          GestureDetector(
            onTap: () {
              var date = _controller.focusedDay ?? _dateSelected;
              var v = new DateTime(date.year, date.month + 1, date.day);
              setState(() {
                _controller.setFocusedDay(v);
              });
            },
            child: Icon(Icons.arrow_forward_ios,
                color: Colors.blueGrey, size: SizeService.getFontSize(66)),
          ),
        ],
      ),
    );
  }
}
