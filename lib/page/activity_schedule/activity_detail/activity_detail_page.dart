import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:tuoc/environment/base_color.dart';
import 'package:tuoc/environment/custom_text_theme.dart';
import 'package:tuoc/environment/resource_string.dart';
import 'package:tuoc/model/activity/detail/activity_detail.dart';
import 'package:tuoc/page/activity_schedule/activity_detail/activity_detail_presenter.dart';
import 'package:tuoc/service/size_service.dart';
import 'package:tuoc/widget/base_container.dart';
import 'package:tuoc/widget/data_not_found.dart';

class ActivityDetailPage extends StatefulWidget {
  final String activityId;

  ActivityDetailPage({Key key, this.activityId}) : super(key: key);

  @override
  _ActivityDetailPageState createState() => _ActivityDetailPageState();
}

class _ActivityDetailPageState extends State<ActivityDetailPage> {
  ActivityDetailPresenter _presenter;

  @override
  void initState() {
    super.initState();

    _presenter = ActivityDetailPresenter(this);
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BaseContainer(
      title: ResourceString.getString('activity_schedule'),
      child: ClipRRect(
        borderRadius: BorderRadius.vertical(top: Radius.circular(40)),
        child: Container(
          width: double.maxFinite,
          height: double.maxFinite,
          color: Colors.white,
          child: RefreshIndicator(
            key: _presenter.refreshKey,
            onRefresh: _presenter.onRefresh,
            child: ListView(
              padding: EdgeInsets.only(
                  top: SizeService.getPadding(72),
                  left: SizeService.getPadding(52),
                  right: SizeService.getPadding(52),
                  bottom: MediaQuery.of(context).padding.bottom +
                      SizeService.getPadding(52)),
              children: _presenter.data.length > 0
                  ? [
                      _titleDetail(_presenter.data[0]),
                      _dateTime(_presenter.data[0]),
                      _info(_presenter.data[0]),
                      _remark(_presenter.data[0]),
                    ]
                  : _presenter.loader ? [Container()] : [DataNotFound()],
            ),
          ),
        ),
      ),
    );
  }

  Widget _titleDetail(ActivityDetailDataModel data) {
    return Row(
      children: <Widget>[
        Expanded(
          child: Text(
            'Activity Schedule',
            style: CustomTextTheme.content(context),
          ),
        ),
        Row(
          children: <Widget>[
            InkWell(
              onTap: _presenter.gotoEdit,
              child: Icon(Icons.edit,
                  size: SizeService.getFontSize(62), color: Color(0xffcccccc)),
            ),
            SizedBox(width: SizeService.getPadding(36)),
            InkWell(
              onTap: _presenter.onDelete,
              child: ImageIcon(
                AssetImage('assets/icons/ic_bin.png'),
                size: SizeService.getFontSize(62),
                color: Color(0xffcccccc),
              ),
            ), //_presenter.myAccountId == _presenter.data[0].account_id ?
          ],
        ),
      ],
    );
  }

  Widget _dateTime(ActivityDetailDataModel data) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: SizeService.getPadding(46)),
      child: Row(
        children: <Widget>[
          Container(
            width: SizeService.getWidth(15),
            height: SizeService.getHeight(100),
            decoration: BoxDecoration(
              color: BaseColor.activityColor(),
              borderRadius: BorderRadius.circular(50),
            ),
          ),
          SizedBox(width: SizeService.getPadding(40)),
          Expanded(child: _dateItem(data))
        ],
      ),
    );
  }

  Widget _dateItem(ActivityDetailDataModel data) {
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
                '${monthFormat.format(startData).toUpperCase()}',
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

  Widget _info(ActivityDetailDataModel data) {
    List<Widget> listTitle = [
      _infoItem('Type'),
      _infoItem('Title'),
      _infoItem('Venue'),
      _infoItem('Praticipants 1'),
      _infoItem('Praticipants 2'),
      _infoItem(''),
    ];

    List<Widget> listValue = [
      _infoDetailItem('${data.activity_type_code_name ?? ''}'),
      _infoDetailItem('${data.title ?? ''}'),
      _infoDetailItem('${data.venue ?? ''}'),
      _infoDetailItem('${data.presenter_1 ?? ''}'),
      _infoDetailItem('${data.presenter_2 ?? ''}'),
      _infoDetailItem(''),
    ];

    return IntrinsicHeight(
      child: Container(
        padding: EdgeInsets.only(bottom: SizeService.getPadding(38)),
        child: Row(
          children: <Widget>[
            Expanded(
              flex: 5,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: listTitle,
              ),
            ),
            Container(
              margin: EdgeInsets.only(right: SizeService.getPadding(58)),
              color: Color(0xffF2F0F0),
              width: SizeService.getWidth(5),
            ),
            Expanded(
              flex: 8,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: listValue,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _infoItem(String title) {
    return Text(
      title,
      style: CustomTextTheme.content(context),
    );
  }

  Widget _infoDetailItem(String title) {
    return SelectableText(
      title,
      style: CustomTextTheme.content(context),
    );
  }

  Widget _remark(ActivityDetailDataModel data) {
    if (data.remark != null && data.remark.isNotEmpty) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            'Remark',
            style: CustomTextTheme.content(context),
          ),
          Container(
            width: double.maxFinite,
            margin: EdgeInsets.only(top: SizeService.getPadding(24)),
            padding: EdgeInsets.symmetric(
              vertical: SizeService.getPadding(24),
              horizontal: SizeService.getPadding(64),
            ),
            color: Color(0xffF2F0F0),
            child: SelectableText(
              '${data.remark}',
              style: CustomTextTheme.content(context),
            ),
          ),
        ],
      );
    } else {
      return Container();
    }
  }
}
