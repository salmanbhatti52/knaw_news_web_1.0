import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:knaw_news/util/dimensions.dart';
import 'package:knaw_news/util/images.dart';
import 'package:knaw_news/util/styles.dart';

class CategoryItem extends StatelessWidget {
  String icon;
  String title;
  bool isSelected;
  bool isWhite;
  void Function()? onTap;

  CategoryItem({required this.icon,required this.title,this.onTap,this.isSelected=false,this.isWhite=false});

  @override
  Widget build(BuildContext context) {
    int length=title.length;

    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: EdgeInsets.only(bottom: 5,top: 5,left: 5),
        alignment: Alignment.center,
        height: GetPlatform.isDesktop?40:30,
        width: GetPlatform.isDesktop?60+length*8:50+length*6,
        decoration: BoxDecoration(
          color: isSelected?Colors.amber:isWhite?Colors.white:Colors.grey.withOpacity(0.1),
            borderRadius: BorderRadius.circular(30),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SvgPicture.asset(icon,width: 20,),
            SizedBox(width: 10,),
            Text(title,style: openSansSemiBold.copyWith(color: Colors.black,fontSize: Dimensions.fontSizeSmall),),
          ],
        ),
      ),
    );
  }
}
