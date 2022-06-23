import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:knaw_news/util/styles.dart';

class ReportCard extends StatelessWidget {
  String title;
  bool isSeclected;
  void Function()? onTap;
  ReportCard({required this.title,this.isSeclected=false,this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child:Container(
        width: GetPlatform.isDesktop?200: 150,
        child: Row(
          children: [
            Icon(Icons.check_circle,color: isSeclected?Colors.amber:Colors.grey,),
            SizedBox(width: 5,),
            Text(title,style: openSansSemiBold.copyWith(color: Colors.black),),


          ],
        ),
      )
    );
  }
}
