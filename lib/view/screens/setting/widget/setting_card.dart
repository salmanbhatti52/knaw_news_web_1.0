import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:knaw_news/util/dimensions.dart';
import 'package:knaw_news/util/styles.dart';

class SettingCard extends StatelessWidget {
  String icon;
  String title;
  void Function()? onTap;
  SettingCard({required this.icon,required this.title,this.onTap});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      focusColor: Color(0X00FFFFFF),
      hoverColor: Color(0X00FFFFFF),
      highlightColor: Color(0X00FFFFFF),
      splashColor: Color(0X00FFFFFF),

      onTap: onTap,
      child: Container(
        child: Row(
          children: [
            SizedBox(width: 30,),
            SvgPicture.asset(icon,width: 18,height: 18,),
            SizedBox(width: 10,),
            Text(title,style: openSansBold.copyWith(color: Colors.black,fontSize: GetPlatform.isDesktop?Dimensions.fontSizeSmall:Dimensions.fontSizeDefault),),
          ],
        ),
      ),
    );
  }
}
