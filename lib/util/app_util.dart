import 'package:tuoc/model/master_data/master_data.dart';
import 'package:tuoc/service/api.dart';
import 'package:tuoc/util/database_util.dart';
//
// class AppUtil {
//   static getMasterData() async {
//     DatabaseUtil dbs = await DatabaseUtil();
//
//     var success = await dbs.removeAll();
//     if (success == true) {
//       print("DB DELETE");
//     }
//     Api api = Api<MasterDataModel>();
//
//     var res = await api.getMasterData({});
//
//     if (res.fail == null) {
//       MasterDataModel model = res.success;
//       if (model.statusCode == 200) {
//         await dbs.insertData(dbName: 'master_data', data: model.data);
//
//         return model.data;
//       }
//     }
//   }
// }

class AppUtil {
  static Future<dynamic> getMasterData() async {
    Api api = Api<MasterDataModel>();
    var res = await api.getMasterData({});

    if (res.fail == null) {
      MasterDataModel model = res.success;
      if (model.statusCode == 200) {
        return model.data;
      }
    }
    return null;
  }
}
