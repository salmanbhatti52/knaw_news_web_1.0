import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:knaw_news/util/dimensions.dart';
import 'package:knaw_news/util/styles.dart';

class FilterType extends StatelessWidget {
  String title;
  bool isSelected;
  void Function()? onTap;
  FilterType({required this.title,this.onTap,this.isSelected=false});

  @override
  Widget build(BuildContext context) {
    int length=title.length;

    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.only(bottom: 2),
        height: 30,
        width: GetPlatform.isDesktop? 20+length*10: 20+length*8,
        decoration: BoxDecoration(
          border: Border.all(color: Colors.amber,width: 2),
          color: isSelected?Colors.amber:Colors.white,
          borderRadius: BorderRadius.circular(20),
        ),
        child: Center(child: Text(title,style: openSansSemiBold.copyWith(color: Colors.black,fontSize: Dimensions.fontSizeSmall),textAlign: TextAlign.justify,)),
      ),
    );
  }
}
