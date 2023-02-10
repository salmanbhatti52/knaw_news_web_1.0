import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:knaw_news/mixin/data.dart';
import 'package:knaw_news/util/app_constants.dart';
import 'package:knaw_news/util/images.dart';
import 'package:knaw_news/util/styles.dart';
import 'package:knaw_news/view/base/custom_image.dart';

class FollowCard extends StatelessWidget {
  String icon;
  String title;
  bool isFollower;
  bool isPic;
  bool? isVerified;
  void Function()? onTap;
  void Function()? onTapFollow;
  FollowCard({required this.icon,required this.title,required this.isFollower,this.onTapFollow,this.onTap,this.isPic=false,this.isVerified});

  @override
  Widget build(BuildContext context) {
    return GetPlatform.isDesktop?Container(
      child: InkWell(
        onTap: onTap,
        child: ListTile(
          leading: Stack(
            children: [
              ClipOval(
                child: icon == "" ?CustomImage(
                  image: Images.placeholder,
                  height: 45,
                  width: 45,
                  fit: BoxFit.cover,
                ):Image.network(
                  icon,
                  width: 45,height: 45,fit: BoxFit.cover,
                ),
              ),
              isVerified!?Positioned(
                bottom: 0, right: 0,
                child: SvgPicture.asset(Images.badge,height: 15,width: 15,),
              ):SizedBox(),
            ],
          ),
          title: Text(title,style: openSansBold.copyWith(color: Colors.black,),),
          trailing: GestureDetector(
            onTap: onTapFollow,
            child: Container(
              height: 28,
              width: GetPlatform.isDesktop?110: 90,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(5),
                  color: isFollower?Colors.amber:Colors.black
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                Padding(
                  padding: const EdgeInsets.only(top: 6.0,right: 3,bottom: 6.0),
                  child: SvgPicture.asset(Images.user,color: Colors.white,),
                ),
                Text(isFollower? AppData().language!.unfollow: AppData().language!.follow,style: openSansRegular.copyWith(color:Colors.white),)
              ],),
            ),
          ),
        ),
      ),
    ):Container(
      height: 60,
      width: MediaQuery.of(context).size.width*0.9,
      child: GestureDetector(
        onTap: onTap,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Stack(
              children: [
                ClipOval(
                  child: icon == "" ?CustomImage(
                    image: Images.placeholder,
                    height: 45,
                    width: 45,
                    fit: BoxFit.cover,
                  ):Image.network(
                    icon,
                    width: 45,height: 45,fit: BoxFit.cover,
                  ),
                ),
                isVerified!?Positioned(
                  bottom: 0, right: 0,
                  child: SvgPicture.asset(Images.badge,height: 15,width: 15,),
                ):SizedBox(),
              ],
            ),
            Text(title,style: openSansBold.copyWith(color: Colors.black,),),
            GestureDetector(
              onTap: onTapFollow,
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 5),
                height: 28,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5),
                    color: isFollower?Colors.amber:Colors.black
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(top: 6.0,right: 3,bottom: 6.0),
                      child: SvgPicture.asset(Images.user,color: Colors.white,),
                    ),
                    Text(isFollower?AppData().language!.unfollow:AppData().language!.follow,style: openSansRegular.copyWith(color:Colors.white),)
                  ],),
              ),
            ),

          ],
        ),
      ),
    );
  }
}
