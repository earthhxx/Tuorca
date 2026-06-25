import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:tuoc/environment/base_presenter.dart';
import 'package:tuoc/model/base_model.dart';
import 'package:tuoc/model/surgery/surgery_detail.dart';
import 'package:tuoc/page/surgery_schedule/surgery_create/surgery_create_page.dart';
import 'package:tuoc/page/surgery_schedule/surgery_detail/surgery_detail_page.dart';
import 'package:tuoc/service/api.dart';
import 'package:tuoc/service/size_service.dart';
import 'package:tuoc/util/account_util.dart';
import 'package:tuoc/util/alert.dart';
import 'package:tuoc/util/loading.dart';

class SurgeryDetailPresenter extends BasePresenter<SurgeryDetailPage> {
  Api _api;
  final refreshKey = GlobalKey<RefreshIndicatorState>();

  List<SurgeryDetailDataModel> data = [];

  String myAccountId;

  SurgeryDetailPresenter(State<SurgeryDetailPage> state) : super(state) {
    Future.delayed(Duration.zero, () => refreshKey.currentState.show());
  }

  Future onRefresh() async {
    loading();

    myAccountId = await AccountUtil.getAccountIdByToken();
    await _getDetail();
    loaded();
  }

  _getDetail() async {
    _api = Api<SurgeryDetailModel>();

    var res = await _api.getSurgeryDetail({
      'room_id': state.widget.roomId,
      'surgery_id': state.widget.surgeryId,
    });

    if (res.fail == null) {
      SurgeryDetailModel model = res.success;
      print("res > ${model.data}");
      if (model.statusCode == 200) {
        data = model.data;
        // print("kmsaodkasdo ${data[0].room_id}");
        // print("kmsaodkasdo ${data[0].room_name}");
        // print("kmsaodkasdo ${data[0].operative_room_code}");
        // print("kmsaodkasdo ${data[0].operative_room_name}");
        // print("kmsaodkasdo ${data[0].vip_code}");
        // print("kmsaodkasdo ${data[0].vip_name}");
      }
    }
  }

  deleteSchedule() {
    Alert(state.context,
        icon: Padding(
          padding: EdgeInsets.symmetric(vertical: SizeService.getPadding(24)),
          child: ImageIcon(
            AssetImage('assets/icons/ic_bin.png'),
            size: SizeService.getFontSize(120),
            color: Color(0xffC40030),
          ),
        ),
        type: AlertType.confirm,
        message: 'Do you want delete this schedule?', onOk: () async {
      await _letDelete();
    });
  }

  _letDelete() async {
    Loading(state.context).show();
    _api = Api<BaseModel>();

    var res = await _api.surgeryDelete({
      'room_id': state.widget.roomId,
      'surgery_id': state.widget.surgeryId,
    });

    Loading(state.context).hide();

    if (res.fail == null) {
      BaseModel model = res.success;
      if (model.statusCode == 200) {
        Alert(state.context, message: 'Delete schedule success.', onOk: () {
          Navigator.pop(state.context);
        });
      } else {
        _deleteFail();
      }
    } else {
      _deleteFail();
    }
  }

  _deleteFail() {
    Alert(
      state.context,
      message: 'Delete schedule fail.',
    );
  }

  Future<void> gotoEdit() async {
    Alert(state.context,
        type: AlertType.confirm,
        message: 'Do you want edit schedule?', onOk: () async {
      await Navigator.push(
        state.context,
        CupertinoPageRoute(
          builder: (_) => SurgeryCreatePage(
            dataEdit: data[0],
            roomName: data[0].room_name,
            roomId: state.widget.roomId,
          ),
        ),
      );
      refreshKey.currentState.show();
    });
  }
}
