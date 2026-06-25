import 'package:flutter/material.dart';
import 'package:tuoc/environment/base_presenter.dart';
import 'package:tuoc/model/master_data/master_data.dart';
import 'package:tuoc/page/service_schedule/service_select_type/service_select_type_page.dart';

import '../../../util/app_util.dart';

class ServiceSelectTypePresenter extends BasePresenter<ServiceSelectTypePage> {
  MasterDataListModel masterData;

  ServiceSelectTypePresenter(State<ServiceSelectTypePage> state)
      : super(state) {
    Future.delayed(Duration.zero, () => _initPage());
  }

  _initPage() async {
    loading();

    masterData = await AppUtil.getMasterData();

    loaded();
  }
}
