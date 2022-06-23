

import 'package:knaw_news/util/dimensions.dart';
import 'package:knaw_news/util/styles.dart';
import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  final void Function()? onPressed;
  final String buttonText;
  final bool transparent;
  final EdgeInsets margin;
  final double height;
  final double width;
  final double fontSize;
  final double radius;
  CustomButton({required this.onPressed, required this.buttonText, this.transparent = false, required this.margin, this.width=300, this.height=50,
    this.fontSize=12, this.radius = 5,});

  @override
  Widget build(BuildContext context) {
    final ButtonStyle _flatButtonStyle = TextButton.styleFrom(
      backgroundColor: onPressed == null ? Theme.of(context).disabledColor : transparent
          ? Colors.transparent : Theme.of(context).primaryColor,
      minimumSize: Size(width != null ? width : Dimensions.WEB_MAX_WIDTH, height != null ? height : 50),
      padding: EdgeInsets.zero,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(radius),
      ),
    );

    return Center(child: SizedBox(width: width != null ? width : Dimensions.WEB_MAX_WIDTH, child: Padding(
      padding: margin == null ? EdgeInsets.all(0) : margin,
      child: TextButton(
        onPressed: onPressed,
        style: _flatButtonStyle,
        child: Row(mainAxisAlignment: MainAxisAlignment.center, children: [
          Text(buttonText, textAlign: TextAlign.center, style: openSansBold.copyWith(
            color: textBtnColor,
            fontSize: fontSize,
          )),
        ]),
      ),
    ))
    );
  }
}
