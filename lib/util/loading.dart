import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Loading {
  BuildContext context;

  Loading(this.context);

  show() {
    showCupertinoModalPopup(
      context: context,
      builder: (context) {
        return Container(
          alignment: Alignment.center,
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          color: Colors.black87.withOpacity(0.3),
          child: CircularProgressIndicator(),
        );
      },
    );
  }

  hide() {
    Navigator.pop(context);
  }
}
