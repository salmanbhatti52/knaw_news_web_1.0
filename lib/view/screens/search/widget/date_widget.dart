import 'package:flutter/material.dart';
import 'package:knaw_news/util/styles.dart';

class DateItem extends StatelessWidget {
  String date;
  bool isActive;
  void Function()? onTap;
  DateItem({required this.date,this.isActive=false,this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: EdgeInsets.all(5),
        padding: EdgeInsets.all(5),
        alignment: Alignment.center,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: isActive?Colors.amber:Theme.of(context).disabledColor,
        ),
        child: Text(date,style: openSansBold.copyWith(color: Colors.black),),
      ),
    );
  }
}
