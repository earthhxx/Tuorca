import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:tuoc/model/academic/calendar/academic_calendar.dart';
import 'package:tuoc/model/academic/detail/academic_detail.dart';
import 'package:tuoc/model/academic/list/academic_list.dart';
import 'package:tuoc/model/activity/calendar/activity_calendar.dart';
import 'package:tuoc/model/activity/detail/activity_detail.dart';
import 'package:tuoc/model/activity/list/activity_list.dart';
import 'package:tuoc/model/base_model.dart';
import 'package:tuoc/model/login/login.dart';
import 'package:tuoc/model/master_data/master_data.dart';
import 'package:tuoc/model/my_profile/my_profile.dart';
import 'package:tuoc/model/service/calendar/service_calendar.dart';
import 'package:tuoc/model/service/detail/service_detail.dart';
import 'package:tuoc/model/service/list/service_list.dart';
import 'package:tuoc/model/surgery/surgery_calendar.dart';
import 'package:tuoc/model/surgery/surgery_detail.dart';
import 'package:tuoc/model/surgery/surgery_list.dart';
import 'package:tuoc/model/surgery/surgery_room.dart';
import 'package:tuoc/util/account_util.dart';

class Api<T> {
  // final String _baseApi = "https://api.tuorca.com/api/v1/"; //prod
  final String _baseApi = "https://api2.tuorca.com/api/v1/"; //prod
//  final String _baseApi = "https://tu-api.zigmanice.xyz/api/v1/"; //dev
  Map<String, String> _headers = {
    "ZIGMANICE-API-KEY": "MtH14GiX9VPyADBFblIoBQyVuL3lAdsnXZTGnJic"
  };

  Future<Response<T>> getMasterData(Object body) async {
    var _model;
    var _fail;
    var result;

    await _httpConnection(this._baseApi + "application/master_data",
            headers: this._headers, body: body)
        .then((response) {
      print("masterData = ${response.body}");
      if (response.statusCode == 200) {
        _model = MasterDataModel.fromJson(_jsonDecode(response.body));
      } else {
        _fail = FailModel.fromJson(_jsonDecode(response.body));
      }
      result = new Response<T>(_model, _fail);
    });

    return result;
  }

  ///Account
  Future<Response<T>> login(Object body) async {
    var _model;
    var _fail;
    var result;

    await _httpConnection(this._baseApi + "login",
            headers: this._headers, body: body)
        .then((response) {
      print(this._baseApi + "login");
      print("LOGIN ${body}");
      if (response.statusCode == 200) {
        _model = LoginModel.fromJson(_jsonDecode(response.body));
      } else {
        _fail = FailModel.fromJson(_jsonDecode(response.body));
      }
      result = new Response<T>(_model, _fail);
    });

    return result;
  }

  Future<Response<T>> register(Object body) async {
    var _model;
    var _fail;
    var result;

    await _httpConnection(this._baseApi + "register",
            headers: this._headers, body: body)
        .then((response) {
      if (response.statusCode == 200 &&
          _jsonDecode(response.body)['statusCode'] == 200) {
        _model = _jsonDecode(response.body);
      } else {
        _fail = FailModel.fromJson(_jsonDecode(response.body));
      }
      result = new Response<T>(_model, _fail);
    });

    return result;
  }

  ///Surgery
  Future<Response<T>> getSurgeryRoom(Object body) async {
    var _model;
    var _fail;
    var result;

    await _httpConnection(this._baseApi + "surgery/room",
            headers: this._headers, body: body)
        .then((response) {
      if (response.statusCode == 200) {
        print("getRoom ${response.body}");
        _model = SurgeryRoomModel.fromJson(_jsonDecode(response.body));
      } else {
        _fail = FailModel.fromJson(_jsonDecode(response.body));
      }
      result = new Response<T>(_model, _fail);
    });

    return result;
  }

  Future<Response<T>> getSurgeryCalendar(Object body) async {
    var _model;
    var _fail;
    var result;

    await _httpConnection(this._baseApi + "surgery/list",
            headers: this._headers, body: body)
        .then((response) {
      if (response.statusCode == 200) {
        _model = SurgeryCalendarModel.fromJson(_jsonDecode(response.body));
      } else {
        _fail = FailModel.fromJson(_jsonDecode(response.body));
      }
      result = new Response<T>(_model, _fail);
    });

    return result;
  }

  Future<Response<T>> getSurgeryList(Object body) async {
    var _model;
    var _fail;
    var result;

    await _httpConnection(this._baseApi + "surgery/list",
            headers: this._headers, body: body)
        .then((response) {
      print(this._baseApi + "surgery/list");
      print("header ${this._headers}");
      print(body);
      print(response.body);
      if (response.statusCode == 200) {
        _model = SurgeryListModel.fromJson(_jsonDecode(response.body));
      } else {
        _fail = FailModel.fromJson(_jsonDecode(response.body));
      }
      result = new Response<T>(_model, _fail);
    });

    return result;
  }

  Future<Response<T>> getSurgeryDetail(Object body) async {
    var _model;
    var _fail;
    var result;

    await _httpConnection(this._baseApi + "surgery/description",
            headers: this._headers, body: body)
        .then((response) {
      print(response.body);
      if (response.statusCode == 200) {
        _model = SurgeryDetailModel.fromJson(_jsonDecode(response.body));
      } else {
        _fail = FailModel.fromJson(_jsonDecode(response.body));
      }
      result = new Response<T>(_model, _fail);
    });

    return result;
  }

  Future<Response<T>> surgeryCreate(Object body) async {
    var _model;
    var _fail;
    var result;

    _headers['ZIGMANICE-AUTH'] = await AccountUtil.getAccessToken();

    await _httpConnection(this._baseApi + "surgery/create",
            headers: this._headers, body: body)
        .then((response) {
      print("body => ${body}");
      print(response.body);
      if (response.statusCode == 200) {
        _model = BaseModel.fromJson(_jsonDecode(response.body));
      } else {
        _fail = FailModel.fromJson(_jsonDecode(response.body));
      }
      result = new Response<T>(_model, _fail);
    });

    return result;
  }

  Future<Response<T>> surgeryEdit(Object body) async {
    var _model;
    var _fail;
    var result;

    _headers['ZIGMANICE-AUTH'] = await AccountUtil.getAccessToken();

    await _httpConnection(this._baseApi + "surgery/edit",
            headers: this._headers, body: body)
        .then((response) {
      if (response.statusCode == 200) {
        _model = BaseModel.fromJson(_jsonDecode(response.body));
      } else {
        _fail = FailModel.fromJson(_jsonDecode(response.body));
      }
      result = new Response<T>(_model, _fail);
    });

    return result;
  }

  Future<Response<T>> surgeryDelete(Object body) async {
    var _model;
    var _fail;
    var result;

    _headers['ZIGMANICE-AUTH'] = await AccountUtil.getAccessToken();

    await _httpConnection(this._baseApi + "surgery/delete",
            headers: this._headers, body: body)
        .then((response) {
      if (response.statusCode == 200) {
        _model = BaseModel.fromJson(_jsonDecode(response.body));
      } else {
        _fail = FailModel.fromJson(_jsonDecode(response.body));
      }
      result = new Response<T>(_model, _fail);
    });

    return result;
  }

  ///service
  Future<Response<T>> getServiceCalendar(Object body) async {
    var _model;
    var _fail;
    var result;

    await _httpConnection(this._baseApi + "service/list",
            headers: this._headers, body: body)
        .then((response) {
      if (response.statusCode == 200) {
        _model = ServiceCalendarModel.fromJson(_jsonDecode(response.body));
      } else {
        _fail = FailModel.fromJson(_jsonDecode(response.body));
      }
      result = new Response<T>(_model, _fail);
    });

    return result;
  }

  Future<Response<T>> getServiceList(Object body) async {
    var _model;
    var _fail;
    var result;

    await _httpConnection(this._baseApi + "service/list",
            headers: this._headers, body: body)
        .then((response) {
      if (response.statusCode == 200) {
        _model = ServiceListModel.fromJson(_jsonDecode(response.body));
      } else {
        _fail = FailModel.fromJson(_jsonDecode(response.body));
      }
      result = new Response<T>(_model, _fail);
    });

    return result;
  }

  Future<Response<T>> getServiceDetail(Object body) async {
    var _model;
    var _fail;
    var result;

    await _httpConnection(this._baseApi + "service/description",
            headers: this._headers, body: body)
        .then((response) {
      if (response.statusCode == 200) {
        _model = ServiceDetailModel.fromJson(_jsonDecode(response.body));
      } else {
        _fail = FailModel.fromJson(_jsonDecode(response.body));
      }
      result = new Response<T>(_model, _fail);
    });

    return result;
  }

  Future<Response<T>> serviceCreate(Object body) async {
    var _model;
    var _fail;
    var result;

    _headers['ZIGMANICE-AUTH'] = await AccountUtil.getAccessToken();

    await _httpConnection(this._baseApi + "service/create",
            headers: this._headers, body: body)
        .then((response) {
      // print("url")
      print("body => ${body}");
      if (response.statusCode == 200) {
        _model = BaseModel.fromJson(_jsonDecode(response.body));
      } else {
        _fail = FailModel.fromJson(_jsonDecode(response.body));
      }
      result = new Response<T>(_model, _fail);
    });

    return result;
  }

  Future<Response<T>> serviceEdit(Object body) async {
    var _model;
    var _fail;
    var result;

    _headers['ZIGMANICE-AUTH'] = await AccountUtil.getAccessToken();

    await _httpConnection(this._baseApi + "service/edit",
            headers: this._headers, body: body)
        .then((response) {
      if (response.statusCode == 200) {
        _model = BaseModel.fromJson(_jsonDecode(response.body));
      } else {
        _fail = FailModel.fromJson(_jsonDecode(response.body));
      }
      result = new Response<T>(_model, _fail);
    });

    return result;
  }

  Future<Response<T>> serviceDelete(Object body) async {
    var _model;
    var _fail;
    var result;

    _headers['ZIGMANICE-AUTH'] = await AccountUtil.getAccessToken();

    await _httpConnection(this._baseApi + "service/delete",
            headers: this._headers, body: body)
        .then((response) {
      if (response.statusCode == 200) {
        _model = BaseModel.fromJson(_jsonDecode(response.body));
      } else {
        _fail = FailModel.fromJson(_jsonDecode(response.body));
      }
      result = new Response<T>(_model, _fail);
    });

    return result;
  }

  ///academic
  Future<Response<T>> getAcademicCalendar(Object body) async {
    var _model;
    var _fail;
    var result;

    await _httpConnection(this._baseApi + "academic/list",
            headers: this._headers, body: body)
        .then((response) {
      if (response.statusCode == 200) {
        _model = AcademicCalendarModel.fromJson(_jsonDecode(response.body));
      } else {
        _fail = FailModel.fromJson(_jsonDecode(response.body));
      }
      result = new Response<T>(_model, _fail);
    });

    return result;
  }

  Future<Response<T>> getAcademicList(Object body) async {
    var _model;
    var _fail;
    var result;

    await _httpConnection(this._baseApi + "academic/list",
            headers: this._headers, body: body)
        .then((response) {
      print("academic/list");
      print(this._baseApi + "academic/list");
      print(this._headers);
      print(body);
      print(response.body);
      if (response.statusCode == 200) {
        _model = AcademicListModel.fromJson(_jsonDecode(response.body));
      } else {
        _fail = FailModel.fromJson(_jsonDecode(response.body));
      }
      result = new Response<T>(_model, _fail);
    });

    return result;
  }

  Future<Response<T>> getAcademicDetail(Object body) async {
    var _model;
    var _fail;
    var result;

    await _httpConnection(this._baseApi + "academic/description",
            headers: this._headers, body: body)
        .then((response) {
      if (response.statusCode == 200) {
        _model = AcademicDetailModel.fromJson(_jsonDecode(response.body));
      } else {
        _fail = FailModel.fromJson(_jsonDecode(response.body));
      }
      result = new Response<T>(_model, _fail);
    });

    return result;
  }

  Future<Response<T>> academicCreate(Object body) async {
    var _model;
    var _fail;
    var result;

    _headers['ZIGMANICE-AUTH'] = await AccountUtil.getAccessToken();

    await _httpConnection(this._baseApi + "academic/create",
            headers: this._headers, body: body)
        .then((response) {
      print(this._baseApi + "academic/create");
      print("body => ${body}");
      if (response.statusCode == 200) {
        _model = BaseModel.fromJson(_jsonDecode(response.body));
      } else {
        _fail = FailModel.fromJson(_jsonDecode(response.body));
      }
      result = new Response<T>(_model, _fail);
    });

    return result;
  }

  Future<Response<T>> academicEdit(Object body) async {
    var _model;
    var _fail;
    var result;

    _headers['ZIGMANICE-AUTH'] = await AccountUtil.getAccessToken();

    await _httpConnection(this._baseApi + "academic/edit",
            headers: this._headers, body: body)
        .then((response) {
      if (response.statusCode == 200) {
        _model = BaseModel.fromJson(_jsonDecode(response.body));
      } else {
        _fail = FailModel.fromJson(_jsonDecode(response.body));
      }
      result = new Response<T>(_model, _fail);
    });

    return result;
  }

  Future<Response<T>> academicDelete(Object body) async {
    var _model;
    var _fail;
    var result;

    _headers['ZIGMANICE-AUTH'] = await AccountUtil.getAccessToken();

    await _httpConnection(this._baseApi + "academic/delete",
            headers: this._headers, body: body)
        .then((response) {
      if (response.statusCode == 200) {
        _model = BaseModel.fromJson(_jsonDecode(response.body));
      } else {
        _fail = FailModel.fromJson(_jsonDecode(response.body));
      }
      result = new Response<T>(_model, _fail);
    });

    return result;
  }

  ///activity
  Future<Response<T>> getActivityCalendar(Object body) async {
    var _model;
    var _fail;
    var result;

    await _httpConnection(this._baseApi + "activity/list",
            headers: this._headers, body: body)
        .then((response) {
      if (response.statusCode == 200) {
        _model = ActivityCalendarModel.fromJson(_jsonDecode(response.body));
      } else {
        _fail = FailModel.fromJson(_jsonDecode(response.body));
      }
      result = new Response<T>(_model, _fail);
    });

    return result;
  }

  Future<Response<T>> getActivityList(Object body) async {
    var _model;
    var _fail;
    var result;

    await _httpConnection(this._baseApi + "activity/list",
            headers: this._headers, body: body)
        .then((response) {
      if (response.statusCode == 200) {
        _model = ActivityListModel.fromJson(_jsonDecode(response.body));
      } else {
        _fail = FailModel.fromJson(_jsonDecode(response.body));
      }
      result = new Response<T>(_model, _fail);
    });

    return result;
  }

  Future<Response<T>> getActivityDetail(Object body) async {
    var _model;
    var _fail;
    var result;

    await _httpConnection(this._baseApi + "activity/description",
            headers: this._headers, body: body)
        .then((response) {
      if (response.statusCode == 200) {
        _model = ActivityDetailModel.fromJson(_jsonDecode(response.body));
      } else {
        _fail = FailModel.fromJson(_jsonDecode(response.body));
      }
      result = new Response<T>(_model, _fail);
    });

    return result;
  }

  Future<Response<T>> activityCreate(Object body) async {
    var _model;
    var _fail;
    var result;

    _headers['ZIGMANICE-AUTH'] = await AccountUtil.getAccessToken();

    await _httpConnection(this._baseApi + "activity/create",
            headers: this._headers, body: body)
        .then((response) {
      print(this._baseApi + "activity/create");
      print("body = ${body}");
      if (response.statusCode == 200) {
        _model = BaseModel.fromJson(_jsonDecode(response.body));
      } else {
        _fail = FailModel.fromJson(_jsonDecode(response.body));
      }
      result = new Response<T>(_model, _fail);
    });

    return result;
  }

  Future<Response<T>> activityEdit(Object body) async {
    var _model;
    var _fail;
    var result;

    _headers['ZIGMANICE-AUTH'] = await AccountUtil.getAccessToken();

    await _httpConnection(this._baseApi + "activity/edit",
            headers: this._headers, body: body)
        .then((response) {
      if (response.statusCode == 200) {
        _model = BaseModel.fromJson(_jsonDecode(response.body));
      } else {
        _fail = FailModel.fromJson(_jsonDecode(response.body));
      }
      result = new Response<T>(_model, _fail);
    });

    return result;
  }

  Future<Response<T>> activityDelete(Object body) async {
    var _model;
    var _fail;
    var result;

    _headers['ZIGMANICE-AUTH'] = await AccountUtil.getAccessToken();

    await _httpConnection(this._baseApi + "activity/delete",
            headers: this._headers, body: body)
        .then((response) {
      if (response.statusCode == 200) {
        _model = BaseModel.fromJson(_jsonDecode(response.body));
      } else {
        _fail = FailModel.fromJson(_jsonDecode(response.body));
      }
      result = new Response<T>(_model, _fail);
    });

    return result;
  }

  ///mind
  Future<Response<T>> getMyProfile(Object body) async {
    var _model;
    var _fail;
    var result;

    _headers['ZIGMANICE-AUTH'] = await AccountUtil.getAccessToken();

    await _httpConnection(this._baseApi + "profile",
            headers: this._headers, body: body)
        .then((response) {
      print("GetProfile =${body}");
      print("GetProfile =${_headers}");
      if (response.statusCode == 200) {
        _model = MyProfileModel.fromJson(_jsonDecode(response.body));
      } else {
        _fail = FailModel.fromJson(_jsonDecode(response.body));
      }
      result = new Response<T>(_model, _fail);
    });

    return result;
  }

  Future<Response<T>> editMyProfile(Object body) async {
    var _model;
    var _fail;
    var result;

    _headers['ZIGMANICE-AUTH'] = await AccountUtil.getAccessToken();

    await _httpConnection(this._baseApi + "profile/edit",
            headers: this._headers, body: body)
        .then((response) {
      print(response.body);
      if (response.statusCode == 200) {
        _model = BaseModel.fromJson(_jsonDecode(response.body));
      } else {
        _fail = FailModel.fromJson(_jsonDecode(response.body));
      }
      result = new Response<T>(_model, _fail);
    });

    return result;
  }

  Future<Response<T>> getMyScheduleCalendar(Object body) async {
    var _model;
    var _fail;
    var result;

    _headers['ZIGMANICE-AUTH'] = await AccountUtil.getAccessToken();

    await _httpConnection(this._baseApi + "my_schedule",
            headers: this._headers, body: body)
        .then((response) {
      if (response.statusCode == 200) {
        _model = SurgeryCalendarModel.fromJson(_jsonDecode(response.body));
      } else {
        _fail = FailModel.fromJson(_jsonDecode(response.body));
      }
      result = new Response<T>(_model, _fail);
    });

    return result;
  }

  Future<Response<T>> getMyScheduleList(Object body) async {
    var _model;
    var _fail;
    var result;

    _headers['ZIGMANICE-AUTH'] = await AccountUtil.getAccessToken();

    await _httpConnection(this._baseApi + "my_schedule",
            headers: this._headers, body: body)
        .then((response) {
      if (response.statusCode == 200) {
        _model = SurgeryListModel.fromJson(_jsonDecode(response.body));
      } else {
        _fail = FailModel.fromJson(_jsonDecode(response.body));
      }
      result = new Response<T>(_model, _fail);
    });

    return result;
  }

  Future<http.Response> _httpConnection(String url,
      {Map<String, String> headers, Object body}) {
    if (body != null) {
      final response = headers != null
          ? http.post(Uri.encodeFull(url), headers: headers, body: body)
          : http.post(Uri.encodeFull(url), body: body);
      return response;
    } else {
      final response = headers != null
          ? http.get(Uri.encodeFull(url), headers: headers)
          : http.get(Uri.encodeFull(url));
      return response;
    }
  }

  Map<String, dynamic> _jsonDecode(String myJson) {
    var resJson = json.decode(myJson);
    return resJson;
  }
}

class Response<T> {
  T success;
  FailModel fail;

  Response(this.success, this.fail);
}
