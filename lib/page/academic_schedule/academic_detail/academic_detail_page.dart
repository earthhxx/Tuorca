import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:tuoc/environment/base_color.dart';
import 'package:tuoc/environment/custom_text_theme.dart';
import 'package:tuoc/environment/resource_string.dart';
import 'package:tuoc/model/academic/detail/academic_detail.dart';
import 'package:tuoc/page/academic_schedule/academic_detail/academic_detail_presenter.dart';
import 'package:tuoc/service/size_service.dart';
import 'package:tuoc/widget/base_container.dart';
import 'package:tuoc/widget/data_not_found.dart';

class AcademicDetailPage extends StatefulWidget {
  final String academicId;
  AcademicDetailPage({Key key, this.academicId}) : super(key: key);

  @override
  _AcademicDetailPageState createState() => _AcademicDetailPageState();
}

class _AcademicDetailPageState extends State<AcademicDetailPage> {
  AcademicDetailPresenter _presenter;

  @override
  void initState() {
    super.initState();

    _presenter = AcademicDetailPresenter(this);
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BaseContainer(
      title: ResourceString.getString('academic_schedule'),
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

  Widget _titleDetail(AcademicDetailDataModel data) {
    return Row(
      children: <Widget>[
        Expanded(
          child: Text(
            ResourceString.getString('academic_schedule'),
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
            ),
          ],
        ),
      ],
    );
  }

  Widget _dateTime(AcademicDetailDataModel data) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: SizeService.getPadding(46)),
      child: Row(
        children: <Widget>[
          Container(
            width: SizeService.getWidth(15),
            height: SizeService.getHeight(100),
            decoration: BoxDecoration(
              color: BaseColor.academicColor(),
              borderRadius: BorderRadius.circular(50),
            ),
          ),
          SizedBox(width: SizeService.getPadding(40)),
          Expanded(child: _dateItem(data))
        ],
      ),
    );
  }

  Widget _dateItem(AcademicDetailDataModel data) {
    var monthFormat = DateFormat('MMM');
    var timeFormat = DateFormat('HH.mm');
    var startDate = DateTime.parse(data.schedule_start_datetime);
    var endDate = DateTime.parse(data.schedule_end_datetime);

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
          )
        ],
      ),
    );
  }

  Widget _info(AcademicDetailDataModel data) {
    List<Widget> items = [
      _infoRowItem(_infoItem('Type'),
          _infoDetailItem('${data.academic_type_name ?? ''}')),
      _infoRowItem(_infoItem('Title'), _infoDetailItem('${data.title ?? ''}')),
      _infoRowItem(
          _infoItem('Advisor'), _infoDetailItem('${data.advisor_name ?? ''}')),
      _infoRowItem(
          _infoItem('Praticipants 1'), _infoDetailItem('${data.presenter_1}')),
      _infoRowItem(
          _infoItem('Praticipants 2'), _infoDetailItem('${data.presenter_2}')),
      _infoRowItem(_infoItem(''), _infoDetailItem('')),
      _infoRowItem(_infoItem(''), _infoDetailItem('')),
    ];

    return IntrinsicHeight(
      child: Container(
        padding: EdgeInsets.only(bottom: SizeService.getPadding(38)),
        child: Column(
          children: items,
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

  Widget _remark(AcademicDetailDataModel data) {
    if (data.remark != null && data.remark.isNotEmpty) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            'Remark',
            style: CustomTextTheme.content(context),
          ),
          Container(
            width: double.infinity,
            margin: EdgeInsets.only(top: SizeService.getPadding(24)),
            padding: EdgeInsets.symmetric(
              vertical: SizeService.getPadding(24),
              horizontal: SizeService.getPadding(64),
            ),
            color: Color(0xffF2F0F0),
            child: SelectableText(
              '${data.remark ?? ''}',
              style: CustomTextTheme.content(context),
            ),
          ),
        ],
      );
    } else {
      return Container();
    }
  }

  Widget _infoRowItem(Widget title, Widget value) {
    return IntrinsicHeight(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Expanded(
            flex: 5,
            child: title,
          ),
          Container(
            margin: EdgeInsets.only(right: SizeService.getPadding(58)),
            color: Color(0xffF2F0F0),
            width: SizeService.getWidth(5),
          ),
          Expanded(
            flex: 8,
            child: value,
          ),
        ],
      ),
    );
  }
}
