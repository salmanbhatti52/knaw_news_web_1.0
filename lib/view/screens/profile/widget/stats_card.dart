import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:knaw_news/util/styles.dart';

class StatsCard extends StatelessWidget {
  String icon;
  String title;
  String data;
  void Function()? onTap;
  StatsCard({required this.icon,required this.title,required this.data,this.onTap});
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        child: ListTile(
          leading: Padding(
            padding: const EdgeInsets.all(10.0),
            child: SvgPicture.asset(
                icon,
                width: 20,
                color: Colors.black87
            ),
          ),
          title: Text(title,style: openSansBold.copyWith(color: textColor,),),
          trailing: Text(data,style: openSansSemiBold.copyWith(color: textColor),),
        ),
      ),
    );
  }
}
