import 'dart:convert';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_image_compress/flutter_image_compress.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';
import 'package:tuoc/environment/base_presenter.dart';
import 'package:tuoc/model/base_model.dart';
import 'package:tuoc/model/my_profile/my_profile.dart';
import 'package:tuoc/service/api.dart';
import 'package:tuoc/service/size_service.dart';
import 'package:tuoc/util/account_util.dart';
import 'package:tuoc/util/alert.dart';
import 'package:tuoc/util/loading.dart';

import 'edit_profile_page.dart';

const int IMAGE_SIZE = 600;

class EditProfilePresenter extends BasePresenter<EditProfilePage> {
  final formKey = GlobalKey<FormState>();

  TextEditingController nameCtrl = new TextEditingController();
  TextEditingController lastNameCtrl = new TextEditingController();
  TextEditingController positionCtrl = new TextEditingController();
  TextEditingController emailCtrl = new TextEditingController();
  TextEditingController telCtrl = new TextEditingController();
  TextEditingController faxCtrl = new TextEditingController();

  List<MyProfileDataModel> data = [];

  File imgFile;

  EditProfilePresenter(State<EditProfilePage> state) : super(state) {
    Future.delayed(Duration.zero, () => _initPage());
  }

  _initPage() async {
    Loading(state.context).show();

    data = await AccountUtil.getProfile();

    lastNameCtrl.text = data[0].lname;
    positionCtrl.text = data[0].work_position;
    emailCtrl.text = data[0].email;
    telCtrl.text = data[0].phone;
    faxCtrl.text = data[0].fax;
    nameCtrl.text = data[0].fname;

    loaded();
    Loading(state.context).hide();
  }

  onSubmit() {
    Alert(state.context,
        type: AlertType.confirm,
        message: 'Do you want save your profile?', onOk: () {
      if (formKey.currentState.validate()) {
        _letEdit();
      }
    });
  }

  Future<void> _letEdit() async {
    Loading(state.context).show();

    Api api = Api<BaseModel>();

    var res = await api.editMyProfile({
      'fname': nameCtrl.text,
      'lname': lastNameCtrl.text,
      'email': emailCtrl.text,
      'work_position': positionCtrl.text,
      'phone': telCtrl.text,
      'fax': faxCtrl.text,
      'password': '',
      'image_profile': imgFile != null ? await _getImageBase64(imgFile) : '',
    });

    Loading(state.context).hide();

    if (res.fail == null) {
      BaseModel model = res.success;
      if (model.statusCode == 200) {
        await AccountUtil.getProfile();
        Alert(
          state.context,
          message: 'Edit profile success.',
          onOk: () {
            Navigator.pop(state.context);
          },
        );
      } else {
        _editFail();
      }
    } else {
      _editFail();
    }
  }

  _editFail() {
    Alert(
      state.context,
      message: 'Edit profile fail.',
      onOk: () {
        Navigator.pop(state.context);
      },
    );
  }

  // Future<String> _getVersionCode() async {
  //   String platformVersion;
  //   try {
  //     platformVersion = await GetVersion.projectCode;
  //   } on PlatformException {
  //     platformVersion = 'Failed to get platform version.';
  //   }
  //
  //   print(platformVersion);
  //   return platformVersion;
  // }

  selectImage() {
    showCupertinoModalPopup(
      context: state.context,
      builder: (context) {
        return Container(
          alignment: Alignment.bottomCenter,
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          child: Material(
            child: Container(
              padding: EdgeInsets.only(
                  bottom: MediaQuery.of(context).padding.bottom),
              color: Colors.white,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.end,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  InkWell(
                    onTap: () => _imagePick(ImageSource.camera),
                    child: Container(
                      padding: EdgeInsets.symmetric(
                          vertical: SizeService.getPadding(30),
                          horizontal: SizeService.getPadding(60)),
                      width: MediaQuery.of(context).size.width,
                      child: Row(
                        children: <Widget>[
                          Icon(Icons.camera,
                              size: SizeService.getFontSize(100),
                              color: Theme.of(context).primaryColor),
                          SizedBox(width: SizeService.getPadding(30)),
                          Text(
                            'Camera',
                            style: TextStyle(
                              fontSize: SizeService.getFontSize(45),
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                  Divider(),
                  InkWell(
                    onTap: () => _imagePick(ImageSource.gallery),
                    child: Container(
                      padding: EdgeInsets.symmetric(
                          vertical: SizeService.getPadding(30),
                          horizontal: SizeService.getPadding(60)),
                      width: MediaQuery.of(context).size.width,
                      child: Row(
                        children: <Widget>[
                          Icon(Icons.photo,
                              size: SizeService.getFontSize(100),
                              color: Theme.of(context).primaryColor),
                          SizedBox(width: SizeService.getPadding(30)),
                          Text(
                            'Gallery',
                            style: TextStyle(
                              fontSize: SizeService.getFontSize(45),
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  _imagePick(ImageSource source) async {
    Navigator.pop(state.context);

    var file = await ImagePicker.pickImage(source: source);

    if (file != null) {
      await _cropImage(file);
    }
  }

  _cropImage(File file) async {
    File croppedFile = await ImageCropper().cropImage(
        sourcePath: file.path,
        aspectRatio: CropAspectRatio(ratioX: 1, ratioY: 1),
        androidUiSettings: AndroidUiSettings(
            toolbarTitle: 'Cropper',
            toolbarWidgetColor: Colors.white,
            toolbarColor: Color(0xff232628),
            initAspectRatio: CropAspectRatioPreset.original,
            lockAspectRatio: true),
        iosUiSettings: IOSUiSettings(
          minimumAspectRatio: 1.0,
        ));

    setState(() {
      imgFile = croppedFile;
    });
  }

  Future<String> _getImageBase64(File file) async {
    File imgResize = await resizeImage(file, IMAGE_SIZE);
    String imgStr = base64.encode(imgResize.readAsBytesSync());

    return 'data:image/png;base64,$imgStr';
  }

  Future<File> resizeImage(File imageFile, int widthSize) async {
    var o = await FlutterImageCompress.compressWithFile(
      imageFile.absolute.path,
      minWidth: widthSize,
      quality: 80,
    );

    File newFile = await _localFile
      ..writeAsBytesSync(o);

    return newFile;
  }

  Future<String> get _localPath async {
    final directory = await getApplicationDocumentsDirectory();

    return directory.path;
  }

  Future<File> get _localFile async {
    final path = await _localPath;
    return File('$path/img-profile.png');
  }
}
