import 'package:flutter/material.dart';
import 'package:get/get.dart';

class KButton extends StatelessWidget {
  final String text;
  final Widget? icon;
  final Widget? action;
  final Function()? onTap;
  const KButton({Key? key, required this.text, this.icon, this.onTap, this.action}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final item = Container(
      decoration: BoxDecoration(
          border: Border.all()
      ),
      padding: EdgeInsets.all(8.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          (icon ?? Offstage()).marginOnly(right: 8.0),
          Text(text),
          Expanded(child: Align(
            alignment: Alignment.centerRight,
            child: action ?? Offstage(),
          ))
        ],
      ),
    );
    return onTap == null ? item : GestureDetector(
      onTap: onTap,
      child: item,
    );
  }
}
