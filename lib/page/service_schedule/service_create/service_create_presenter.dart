import 'dart:async';

import 'package:flutter/material.dart';
import 'package:tuoc/environment/base_presenter.dart';
import 'package:tuoc/environment/resource_string.dart';
import 'package:tuoc/model/base_model.dart';
import 'package:tuoc/model/master_data/master_data.dart';
import 'package:tuoc/model/service/create/service_or_create.dart';
import 'package:tuoc/model/service/edit/service_edit.dart';
import 'package:tuoc/service/api.dart';
import 'package:tuoc/util/alert.dart';
import 'package:tuoc/util/loading.dart';

import '../../../util/app_util.dart';
import 'service_create_page.dart';

class ServiceCreatePresenter extends BasePresenter<ServiceCreatePage> {
  var _getCreateView = StreamController<ServiceCreateType>();

  Stream get createView => _getCreateView.stream;
  MasterDataListModel masterData;

  ServiceCreatePresenter(State<ServiceCreatePage> state) : super(state) {
    Future.delayed(Duration.zero, () => _initPage());
  }

  _initPage() async {
    loading();
    masterData = await AppUtil.getMasterData();
    _getCreateView.add(state.widget.createType);

    loaded();
  }

  onSubmit(data) {
    var start = DateTime.parse(
        "${data.schedule_start_date} ${data.schedule_start_time}");
    var end =
        DateTime.parse("${data.schedule_end_date} ${data.schedule_end_time}");
    if (start.isAtSameMomentAs(end)) {
      Alert(
        state.context,
        message: ResourceString.getString('time_cannot_same'),
      );
      return;
    }
    if (state.widget.dataEdit == null) {
      _letCreate(data);
    } else {
      _letEdit(data);
    }
  }

  _letCreate(ServiceCreateModel data) async {
    Loading(state.context).show();
    Api api = Api<BaseModel>();

    var res = await api.serviceCreate(data.toJson());

    Loading(state.context).hide();

    if (res.fail == null) {
      BaseModel model = res.success;
      if (model.statusCode == 200) {
        Alert(
          state.context,
          title: '',
          message: 'Create Success',
          onOk: () {
            Navigator.pop(state.context);
            Navigator.pop(state.context);
          },
        );
      } else {
        Alert(
          state.context,
          message: model.message,
        );
      }
    }
  }

  _letEdit(ServiceEditModel data) async {
    Loading(state.context).show();
    Api api = Api<BaseModel>();

    var res = await api.serviceEdit(data.toJson());

    Loading(state.context).hide();

    if (res.fail == null) {
      BaseModel model = res.success;
      if (model.statusCode == 200) {
        Alert(state.context, message: 'Edit Success', onOk: () {
          Navigator.pop(state.context);
        });
      } else {
        Alert(
          state.context,
          message: model.message,
        );
      }
    }
  }

  dispose() {
    _getCreateView.close();
  }
}
