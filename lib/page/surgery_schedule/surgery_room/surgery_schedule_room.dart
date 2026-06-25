import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:tuoc/environment/custom_text_theme.dart';
import 'package:tuoc/model/surgery/surgery_room.dart';
import 'package:tuoc/page/surgery_schedule/surgery_list/surgery_schedule_list_page.dart';
import 'package:tuoc/page/surgery_schedule/surgery_room/surgery_room_presenter.dart';
import 'package:tuoc/service/size_service.dart';
import 'package:tuoc/widget/base_container.dart';
import 'package:tuoc/widget/data_not_found.dart';

class SurgeryScheduleRoom extends StatefulWidget {
  final String roomId;
  final String isEdit;

  SurgeryScheduleRoom({
    Key key,
    this.isEdit,
    this.roomId,
  }) : super(key: key);

  @override
  _SurgeryScheduleRoomState createState() => _SurgeryScheduleRoomState();
}

class _SurgeryScheduleRoomState extends State<SurgeryScheduleRoom> {
  SurgeryScheduleRoomPresenter _presenter;

  @override
  void initState() {
    super.initState();

    _presenter = SurgeryScheduleRoomPresenter(this);
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BaseContainer(
      title: 'Surgery Schedule',
      child: _listRoom(),
    );
  }

  Widget _listRoom() {
    return RefreshIndicator(
      key: _presenter.refreshKey,
      onRefresh: _presenter.onRefresh,
      child: ListView.builder(
        padding: EdgeInsets.symmetric(
          horizontal: SizeService.getPadding(64),
          vertical: SizeService.getPadding(80),
        ),
        itemCount:
            _presenter.listData.length > 0 ? _presenter.listData.length : 1,
        itemBuilder: (context, index) {
          if (_presenter.listData.length > 0) {
            return _roomItem(_presenter.listData[index]);
          } else {
            return _presenter.loader ? Container() : DataNotFound();
          }
        },
      ),
    );
  }

  Widget _roomItem(SurgeryRoomDataModel data) {
    return Padding(
      padding: EdgeInsets.only(bottom: SizeService.getPadding(56)),
      child: MaterialButton(
        padding: EdgeInsets.all(SizeService.getPadding(96)),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15),
        ),
        color: Colors.white,
        onPressed: () {
          Navigator.push(
            context,
            CupertinoPageRoute(
              builder: (_) => SurgeryScheduleListPage(
                roomId: data.roomId,
                roomName: data.roomName,
              ),
            ),
          );
        },
        child: IntrinsicHeight(
          child: Row(
            children: <Widget>[
              ImageIcon(
                AssetImage('assets/icons/ic_room.png'),
                color: Color(0xff60A8C3),
                size: SizeService.getFontSize(236),
              ),
              SizedBox(width: SizeService.getPadding(52)),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Text(
                          'Surgery',
                          style: CustomTextTheme.title(context),
                        ),
                        Icon(Icons.arrow_forward_ios,
                            color: Color(0xff60A8C3),
                            size: SizeService.getFontSize(56))
                      ],
                    ),
                    Text(
                      'room',
                      style: CustomTextTheme.title(context).copyWith(
                        height: 1,
                      ),
                    ),
                    Container(
                      width: SizeService.getWidth(30),
                      height: SizeService.getWidth(15),
                      decoration: BoxDecoration(
                          color: Color(0xffFF9900),
                          borderRadius: BorderRadius.circular(5)),
                    ),
                    Expanded(
                      child: Text(
                        '${data.roomName}',
                        style: CustomTextTheme.title(context)
                            .copyWith(fontSize: SizeService.getFontSize(98)),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
