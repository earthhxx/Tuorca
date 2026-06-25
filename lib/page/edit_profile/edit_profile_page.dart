import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:tuoc/environment/resource_string.dart';
import 'package:tuoc/page/edit_profile/edit_profile_presenter.dart';
import 'package:tuoc/service/size_service.dart';
import 'package:tuoc/util/validation.dart';
import 'package:tuoc/widget/base_container.dart';
import 'package:tuoc/widget/custom_button.dart';
import 'package:tuoc/widget/custom_textfield.dart';
import 'package:tuoc/widget/profile_image.dart';

class EditProfilePage extends StatefulWidget {
  EditProfilePage({Key key}) : super(key: key);

  @override
  _EditProfilePageState createState() => _EditProfilePageState();
}

class _EditProfilePageState extends State<EditProfilePage> {
  EditProfilePresenter _presenter;

  @override
  void initState() {
    super.initState();

    _presenter = EditProfilePresenter(this);
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BaseContainer(
      title: ResourceString.getString('edit_profile'),
      child: Container(
        height: MediaQuery.of(context).size.height,
        child: SingleChildScrollView(
          child: Stack(
            alignment: Alignment.topCenter,
            children: <Widget>[
              _form(),
              _profileImage(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _profileImage() {
    return GestureDetector(
      onTap: _presenter.selectImage,
      child: Stack(
        alignment: Alignment.center,
        children: <Widget>[
          Builder(
            builder: (context) {
              if (_presenter.imgFile != null) {
                return ProfileImage(
                    width: 480,
                    showShadow: true,
                    imageFile: _presenter.imgFile);
              } else {
                return ProfileImage(width: 480, showShadow: true);
              }
            },
          ),
          Container(
            alignment: Alignment.bottomCenter,
            width: SizeService.getWidth(480),
            height: SizeService.getWidth(480),
            decoration: BoxDecoration(
              color: Color(0xff343434).withOpacity(0.3),
              borderRadius: BorderRadius.circular(100),
            ),
            child: Padding(
              padding: EdgeInsets.only(
                bottom: SizeService.getPadding(60),
                right: SizeService.getPadding(160),
                left: SizeService.getPadding(160),
              ),
              child: ImageIcon(AssetImage('assets/icons/ic_cam.png'),
                  color: Color(0xff707070), size: SizeService.getFontSize(84)),
            ),
          ),
        ],
      ),
    );
  }

  Widget _form() {
    SizedBox space = SizedBox(height: SizeService.getPadding(20));

    return Container(
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.5),
        border: Border.all(color: Colors.white, width: 1.5),
        borderRadius: BorderRadius.circular(15),
      ),
      margin: EdgeInsets.only(
        top: SizeService.getWidth(240),
        left: SizeService.getPadding(96),
        right: SizeService.getPadding(96),
      ),
      padding: EdgeInsets.only(
        top: SizeService.getWidth(280),
      ),
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: SizeService.getPadding(46)),
        child: Form(
          key: _presenter.formKey,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              CustomTextField(
                controller: _presenter.nameCtrl,
                hintText: ResourceString.getString('first_name'),
                validator: Validation.emptyField,
              ),
              space,
              CustomTextField(
                controller: _presenter.lastNameCtrl,
                hintText: ResourceString.getString('last_name'),
                validator: Validation.emptyField,
              ),
              space,
              CustomTextField(
                controller: _presenter.positionCtrl,
                hintText: ResourceString.getString('position'),
                validator: Validation.emptyField,
              ),
              space,
              CustomTextField(
                controller: _presenter.emailCtrl,
                hintText: ResourceString.getString('email'),
                suffixIcon: _suffixIcon('assets/icons/ic_mail.png'),
                validator: Validation.emailFormat,
              ),
              space,
              CustomTextField(
                controller: _presenter.telCtrl,
                hintText: ResourceString.getString('tel'),
                suffixIcon: _suffixIcon('assets/icons/ic_phone.png'),
                keyboardType: TextInputType.phone,
                inputFormatters: [
                  LengthLimitingTextInputFormatter(10),
                  // WhitelistingTextInputFormatter.digitsOnly,
                ],
                validator: Validation.phoneFormat,
              ),
              space,
              CustomTextField(
                controller: _presenter.faxCtrl,
                hintText: ResourceString.getString('fax'),
                suffixIcon: _suffixIcon('assets/icons/ic_fax.png'),
                keyboardType: TextInputType.phone,
                inputFormatters: [
//                  LengthLimitingTextInputFormatter(10),
//                   WhitelistingTextInputFormatter.digitsOnly,
                ],
                validator: Validation.emptyField,
              ),
              SizedBox(height: SizeService.getPadding(50)),
              _saveButton(),
              SizedBox(height: SizeService.getPadding(100)),
            ],
          ),
        ),
      ),
    );
  }

  Widget _suffixIcon(String icPath) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: SizeService.getPadding(24)),
      child: Padding(
        padding: EdgeInsets.only(right: SizeService.getPadding(16)),
        child: ImageIcon(
          AssetImage(icPath),
          color: Colors.black87,
          size: SizeService.getFontSize(55),
        ),
      ),
    );
  }

  Widget _saveButton() {
    return CustomButton(
      onPressed: _presenter.onSubmit,
      buttonText: 'SAVE',
    );
  }
}
