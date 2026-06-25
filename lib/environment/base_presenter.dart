import 'package:flutter/material.dart';
import 'package:tuoc/model/master_data/master_data.dart';
import 'package:tuoc/util/database_util.dart';
import 'package:tuoc/util/loading.dart';

class BasePresenter<T extends StatefulWidget> {
  State<T> state;

  bool loader = true;

  BasePresenter(this.state);

  setState(VoidCallback v) {
    state.setState(v);
  }

  loading() {
    state.setState(() {
      loader = true;
    });
  }

  loaded() {
    state.setState(() {
      loader = false;
    });
  }

  showLoadingView() {
    Loading(state.context).show();
  }

  hideLoadingView() {
    Loading(state.context).hide();
  }

  Future<MasterDataListModel> getMasterData() async {
    // DatabaseUtil db = await DatabaseUtil();
    // var res = await db.selectAllData(dbName: 'master_data');
    // if (res.length > 0) {
    //   return MasterDataListModel.fromJson(res[0]);
    // } else {
    //   return null;
    // }
  }
}
