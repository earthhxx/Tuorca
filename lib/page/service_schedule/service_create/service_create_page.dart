import 'package:flutter/material.dart';
import 'package:tuoc/environment/resource_string.dart';
import 'package:tuoc/model/service/detail/service_detail.dart';
import 'package:tuoc/page/service_schedule/service_create/service_create_presenter.dart';
import 'package:tuoc/service/size_service.dart';
import 'package:tuoc/widget/base_container.dart';

import 'service_create_er.dart';
import 'service_create_opd.dart';
import 'service_create_or.dart';

enum ServiceCreateType {
  ER,
  OPD,
  OR,
}

class ServiceCreatePage extends StatefulWidget {
  final ServiceCreateType createType;
  final DateTime initialDate;
  final String typeCode;
  final ServiceDetailDataModel dataEdit;

  ServiceCreatePage({
    Key key,
    this.createType = ServiceCreateType.ER,
    this.initialDate,
    this.typeCode,
    this.dataEdit,
  }) : super(key: key);

  @override
  _ServiceCreatePageState createState() => _ServiceCreatePageState();
}

class _ServiceCreatePageState extends State<ServiceCreatePage> {
  ServiceCreatePresenter _presenter;

  @override
  void initState() {
    super.initState();

    _presenter = ServiceCreatePresenter(this);
  }

  @override
  void dispose() {
    _presenter.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BaseContainer(
      title: ResourceString.getString('create_schedule'),
      child: ClipRRect(
        borderRadius: BorderRadius.vertical(top: Radius.circular(50)),
        child: Container(
          width: double.maxFinite,
          height: double.maxFinite,
          color: Colors.white,
          child: SingleChildScrollView(
            padding: EdgeInsets.only(
                top: SizeService.getPadding(72),
                left: SizeService.getPadding(52),
                right: SizeService.getPadding(52),
                bottom: MediaQuery.of(context).padding.bottom +
                    SizeService.getPadding(52)),
            child: StreamBuilder(
              stream: _presenter.createView,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.active) {
                  if (snapshot.data == ServiceCreateType.ER)
                    return ServiceCreateER(
                      masterData: _presenter.masterData,
                      initialDate: widget.initialDate,
                      onSubmit: _presenter.onSubmit,
                      typeCode: widget.typeCode,
                      dataEdit: widget.dataEdit,
                    );
                  else if (snapshot.data == ServiceCreateType.OPD)
                    return ServiceCreateOPD(
                      masterData: _presenter.masterData,
                      initialDate: widget.initialDate,
                      onSubmit: _presenter.onSubmit,
                      typeCode: widget.typeCode,
                      dataEdit: widget.dataEdit,
                    );
                  else
                    return ServiceCreateOR(
                      masterData: _presenter.masterData,
                      initialDate: widget.initialDate,
                      onSubmit: _presenter.onSubmit,
                      typeCode: widget.typeCode,
                      dataEdit: widget.dataEdit,
                    );
                } else {
                  return Container();
                }
              },
            ),
          ),
        ),
      ),
    );
  }
}
