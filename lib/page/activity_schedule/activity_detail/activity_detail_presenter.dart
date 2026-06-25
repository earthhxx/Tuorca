import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:tuoc/environment/base_presenter.dart';
import 'package:tuoc/model/activity/detail/activity_detail.dart';
import 'package:tuoc/model/base_model.dart';
import 'package:tuoc/page/activity_schedule/activity_create/activity_create_page.dart';
import 'package:tuoc/page/activity_schedule/activity_detail/activity_detail_page.dart';
import 'package:tuoc/service/api.dart';
import 'package:tuoc/service/size_service.dart';
import 'package:tuoc/util/account_util.dart';
import 'package:tuoc/util/alert.dart';

class ActivityDetailPresenter extends BasePresenter<ActivityDetailPage> {
  Api _api;
  final refreshKey = GlobalKey<RefreshIndicatorState>();

  List<ActivityDetailDataModel> data = [];

  String myAccountId;

  ActivityDetailPresenter(State<ActivityDetailPage> state) : super(state) {
    Future.delayed(Duration.zero, () => refreshKey.currentState.show());
  }

  Future onRefresh() async {
    loading();
    myAccountId = await AccountUtil.getAccountIdByToken();
    await _getDetail();
    loaded();
  }

  _getDetail() async {
    data = [];
    _api = Api<ActivityDetailModel>();

    var res = await _api.getActivityDetail({
      'activity_id': state.widget.activityId,
    });

    if (res.fail == null) {
      ActivityDetailModel model = res.success;
      if (model.statusCode == 200) {
        data = model.data;
      }
    }
  }

  onDelete() {
    Alert(
      state.context,
      icon: Padding(
        padding: EdgeInsets.symmetric(vertical: SizeService.getPadding(24)),
        child: ImageIcon(
          AssetImage('assets/icons/ic_bin.png'),
          size: SizeService.getFontSize(120),
          color: Color(0xffC40030),
        ),
      ),
      type: AlertType.confirm,
      message: 'Do you want delete this schedule?',
      onOk: () {
        _letDelete();
      },
    );
  }

  _letDelete() async {
    _api = Api<BaseModel>();

    var res = await _api.activityDelete({
      'activity_id': state.widget.activityId,
    });

    if (res.fail == null) {
      BaseModel model = res.success;
      if (model.statusCode == 200) {
        Alert(state.context, message: 'Delete Success', onOk: () {
          Navigator.pop(state.context);
        });
      } else {
        Alert(
          state.context,
          message: '${model.message}',
        );
      }
    }
  }

  gotoEdit() async {
    await Navigator.push(
      state.context,
      CupertinoPageRoute(
        builder: (_) => ActivityCreatePage(
          dataEdit: data[0],
        ),
      ),
    );

    refreshKey.currentState.show();
  }
}
