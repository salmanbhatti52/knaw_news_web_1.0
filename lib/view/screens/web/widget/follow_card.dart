import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:knaw_news/util/app_constants.dart';
import 'package:knaw_news/util/dimensions.dart';
import 'package:knaw_news/util/images.dart';
import 'package:knaw_news/util/styles.dart';
import 'package:knaw_news/view/base/custom_image.dart';

class FollowCard extends StatelessWidget {
  String icon;
  String title;
  bool? isVerified;
  void Function()? onTap;
  void Function()? onTapFollow;
  double width;
  FollowCard({required this.icon,required this.title,this.onTapFollow,this.onTap,this.isVerified,this.width=0.0});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: SizedBox(
        width: width,
        child: ListTile(
          leading: Stack(
            children: [
              ClipOval(
                child: icon == "" ?CustomImage(
                  image: Images.placeholder,
                  height: 35,
                  width: 35,
                  fit: BoxFit.cover,
                ):Image.network(
                  AppConstants.proxyUrl+icon,
                  width: 35,height: 35,fit: BoxFit.cover,
                ),
              ),
              isVerified!?Positioned(
                bottom: 0, right: 0,
                child: SvgPicture.asset(Images.badge,height: 10,width: 10,),
              ):SizedBox(),
            ],
          ),
          title: Text(title,style: openSansSemiBold.copyWith(color: Colors.black,fontSize: Dimensions.fontSizeExtraSmall),),
        ),
      ),
    );
  }
}
