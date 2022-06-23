import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:knaw_news/util/styles.dart';

class WebStatsCard extends StatelessWidget {
  String icon;
  String title;
  String data;
  WebStatsCard({required this.icon,required this.title,required this.data});
  @override
  Widget build(BuildContext context) {
    return Container(
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
    );
  }
}
