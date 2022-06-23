import 'package:flutter/material.dart';
import 'package:knaw_news/util/dimensions.dart';
import 'package:knaw_news/util/styles.dart';

class NewsTypeItem extends StatelessWidget {
  String title;
  bool isSelected;
  bool isWhite;
  void Function() onTap;
  NewsTypeItem({required this.title,this.isSelected=false,required this.onTap,this.isWhite=false});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.all(5),
        alignment: Alignment.center,
        height: 30,
        decoration: BoxDecoration(
          color: isSelected?Colors.amber:isWhite?Colors.white:Color(0XBBF0F0F0),
          borderRadius: BorderRadius.circular(30),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(title,style: openSansSemiBold.copyWith(color: Colors.black,fontSize: Dimensions.fontSizeSmall),),
          ],
        ),
      ),
    );
  }
}
