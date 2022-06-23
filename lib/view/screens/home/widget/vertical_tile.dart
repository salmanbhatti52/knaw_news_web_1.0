import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:knaw_news/api/auth.dart';
import 'package:knaw_news/mixin/data.dart';
import 'package:knaw_news/util/dimensions.dart';
import 'package:knaw_news/util/styles.dart';
import 'package:knaw_news/view/screens/auth/web/web_sign_in.dart';

class VerticalTile extends StatelessWidget {
  String icon;
  String title;
  bool isBlack;
  void Function()? onTap;
  VerticalTile({required this.icon,required this.title,this.onTap,this.isBlack=false});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: AppData().isAuthenticated?onTap:(){GetPlatform.isDesktop?Get.toNamed("/WebSignIn"):Get.to(Auth());},
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 4.0),
        child: Container(
          child: Column(
            children:[
              SvgPicture.asset(icon,height: GetPlatform.isDesktop?Dimensions.fontSizeDefault:icon.contains("face")?14:12,width: GetPlatform.isDesktop?Dimensions.fontSizeDefault:icon.contains("face")?14:12,),
              Text(title,style: openSansRegular.copyWith(fontSize:Dimensions.fontSizeSmall,color: isBlack?Colors.black:Colors.grey),),
            ]
          ),
        ),
      ),
    );
  }
}
