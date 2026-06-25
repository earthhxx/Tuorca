import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:tuoc/environment/base_presenter.dart';
import 'package:tuoc/model/academic/detail/academic_detail.dart';
import 'package:tuoc/model/base_model.dart';
import 'package:tuoc/page/academic_schedule/academic_create/academic_create_page.dart';
import 'package:tuoc/page/academic_schedule/academic_detail/academic_detail_page.dart';
import 'package:tuoc/service/api.dart';
import 'package:tuoc/service/size_service.dart';
import 'package:tuoc/util/account_util.dart';
import 'package:tuoc/util/alert.dart';

class AcademicDetailPresenter extends BasePresenter<AcademicDetailPage> {
  Api _api;
  final refreshKey = GlobalKey<RefreshIndicatorState>();

  List<AcademicDetailDataModel> data = [];

  String myAccountId;

  AcademicDetailPresenter(State<AcademicDetailPage> state) : super(state) {
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
    _api = Api<AcademicDetailModel>();

    var res = await _api.getAcademicDetail({
      'academic_id': state.widget.academicId,
    });

    if (res.fail == null) {
      AcademicDetailModel model = res.success;
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
      _letDetail();
    });
  }

  _letDetail() async {
    data = [];
    _api = Api<BaseModel>();

    var res = await _api.academicDelete({
      'academic_id': state.widget.academicId,
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

  Future<void> gotoEdit() async {
    await Navigator.push(
      state.context,
      CupertinoPageRoute(
        builder: (_) => AcademicCreatePage(
          dataEdit: data[0],
        ),
      ),
    );

    refreshKey.currentState.show();
  }
}
