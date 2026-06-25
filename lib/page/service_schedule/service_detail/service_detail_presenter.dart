import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:tuoc/environment/base_presenter.dart';
import 'package:tuoc/model/base_model.dart';
import 'package:tuoc/model/service/detail/service_detail.dart';
import 'package:tuoc/page/service_schedule/service_create/service_create_page.dart';
import 'package:tuoc/service/api.dart';
import 'package:tuoc/service/size_service.dart';
import 'package:tuoc/util/account_util.dart';
import 'package:tuoc/util/alert.dart';
import 'package:tuoc/util/loading.dart';

import 'service_detail_page.dart';

class ServiceDetailPresenter extends BasePresenter<ServiceDetailPage> {
  Api _api;
  final refreshKey = GlobalKey<RefreshIndicatorState>();

  List<ServiceDetailDataModel> data = [];

  String myAccountId;

  ServiceDetailPresenter(State<ServiceDetailPage> state) : super(state) {
    Future.delayed(Duration.zero, () => refreshKey.currentState.show());
  }

  Future onRefresh() async {
    loading();
    myAccountId = await AccountUtil.getAccountIdByToken();
    await _getDetail();
    loaded();
  }

  _getDetail() async {
    _api = Api<ServiceDetailModel>();

    var res = await _api.getServiceDetail({
      'service_id': state.widget.serviceId,
    });

    if (res.fail == null) {
      ServiceDetailModel model = res.success;
      if (model.statusCode == 200) {
        data = model.data;
      }
    }
  }

  onDelete() {
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
        message: 'Do you want delete this schedule?', onOk: () {
      _letDelete();
    });
  }

  _letDelete() async {
    Loading(state.context).show();
    _api = Api<BaseModel>();

    var res = await _api.serviceDelete({
      'service_id': state.widget.serviceId,
    });

    Loading(state.context).hide();

    if (res.fail == null) {
      BaseModel model = res.success;
      if (model.statusCode == 200) {
        Alert(
          state.context,
          message: 'Delete schedule success.',
          onOk: () {
            Navigator.pop(state.context);
          },
        );
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
    var type = ServiceCreateType.ER;

    switch (data[0].service_type_code.toUpperCase()) {
      case 'SVT-002':
        type = ServiceCreateType.ER;
        break;
      case 'SVT-001':
        type = ServiceCreateType.OPD;
        break;
      case 'SVT-003':
        type = ServiceCreateType.OR;
        break;
    }

    await Navigator.push(
      state.context,
      CupertinoPageRoute(
        builder: (_) => ServiceCreatePage(
          createType: type,
          typeCode: data[0].service_type_code,
          dataEdit: data[0],
        ),
      ),
    );

    refreshKey.currentState.show();
  }
}
