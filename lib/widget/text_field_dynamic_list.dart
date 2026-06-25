import 'package:flutter/material.dart';
import 'package:tuoc/environment/custom_text_theme.dart';
import 'package:tuoc/service/size_service.dart';
import 'package:tuoc/widget/custom_textfield.dart';

class TextFieldDynamicList extends StatelessWidget {
  final String title;
  final Color underLineColor;
  final Stream listStream;
  final Function onAdd;
  final Function onRemove;

  TextFieldDynamicList({
    Key key,
    this.title,
    this.underLineColor,
    this.listStream,
    this.onAdd,
    this.onRemove,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          _title(context),
          _list(),
        ],
      ),
    );
  }

  Widget _title(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          this.title ?? '',
          style: CustomTextTheme.hintTextField(context).copyWith(
            fontSize: SizeService.getFontSize(40),
            height: 1,
          ),
        ),
        SizedBox(
          width: SizeService.getWidth(100),
          child: Divider(
            color: this.underLineColor,
            thickness: 5,
          ),
        ),
      ],
    );
  }

  Widget _list() {
    int itemIndex = -1;
    return StreamBuilder<List>(
      stream: this.listStream,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.active) {
          return Column(
            children: snapshot.data.map((item) {
              itemIndex++;
              return _item(
                itemIndex,
                isLast: itemIndex == snapshot.data.length - 1,
                controller: item,
              );
            }).toList(),
          );
        } else {
          return _item(0);
        }
      },
    );
  }

  Widget _item(int itemIndex,
      {bool isLast = true, TextEditingController controller}) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: SizeService.getPadding(16)),
      child: CustomTextField(
        controller: controller,
        hintText: this.title,
        borderColor: Color(0xff2E363C),
        borderSize: 0.5,
        suffixIcon: GestureDetector(
          onTap: () {
            if (isLast)
              this.onAdd();
            else
              this.onRemove(itemIndex);
          },
          child: Container(
            margin: EdgeInsets.symmetric(
                horizontal: SizeService.getPadding(52),
                vertical: SizeService.getPadding(24)),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(5),
                border: Border.all(color: Color(0xff3C95B5), width: 3)),
            child: Icon(
              isLast ? Icons.add : Icons.remove,
              color: Color(0xff3C95B5),
              size: SizeService.getFontSize(66),
            ),
          ),
        ),
      ),
    );
  }
}
