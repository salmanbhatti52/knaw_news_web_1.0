import 'package:flutter_svg/flutter_svg.dart';
import 'package:knaw_news/util/dimensions.dart';
import 'package:knaw_news/util/styles.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/src/extension_navigation.dart';

class BottomNavItem extends StatelessWidget {
  final String iconData;
  final void Function() onTap;
  final bool isSelected;
  BottomNavItem({ required this.iconData, required this.onTap, this.isSelected = false,});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: InkWell(
        hoverColor: Colors.white,
        focusColor: Colors.white,
        highlightColor: Colors.white,
        splashColor: Colors.white,
        onTap: onTap,
        child: Container(
          height: 45,
          padding: EdgeInsets.only(top: 3),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              //SizedBox(height: 5,),
              SvgPicture.asset(iconData, color: Colors.black,height: 20,width: 20,),

              // title=='My Order'?SizedBox(height: 2.6,):SizedBox(),
              // Text(title,style: muliBold.copyWith(fontSize:Dimensions.fontSizeSmall,color: isSelected ?Colors.black87:Colors.grey),),
            ],
          ),
        ),
      ),
    );
  }
}
