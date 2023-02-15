import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/src/extension_navigation.dart';
import 'package:knaw_news/mixin/data.dart';
import 'package:knaw_news/model/post_model.dart';
import 'package:knaw_news/util/app_constants.dart';
import 'package:knaw_news/util/dimensions.dart';
import 'package:knaw_news/util/images.dart';
import 'package:knaw_news/util/styles.dart';
import 'package:knaw_news/view/base/custom_image.dart';
import 'package:knaw_news/view/screens/auth/web/web_sign_in.dart';
import 'package:knaw_news/view/screens/profile/follow_profile.dart';
import 'package:knaw_news/view/screens/profile/profile_screen.dart';
import 'package:knaw_news/view/screens/profile/web/web_follow_profile.dart';
import 'package:knaw_news/view/screens/profile/web/web_profile.dart';

class UserInfo extends StatelessWidget {
  PostDetail? postDetail;
  UserInfo({this.postDetail});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(top: MediaQuery.of(context).size.height*0.005),
      child: InkWell(
        onTap: (){
          if(GetPlatform.isDesktop){
            if(AppData().isAuthenticated){
              AppData().userdetail!.usersId==postDetail!.usersId?Get.toNamed("/WebProfile"):Get.to(() => WebFollowProfile(userId: postDetail!.usersId,));
            }
            else{
              Get.toNamed("/WebSignIn");
            }
          }
          if(GetPlatform.isMobile){
            if(AppData().isAuthenticated){
              AppData().userdetail!.usersId==postDetail!.usersId?Get.toNamed("/ProfileScreen"):Get.to(() => FollowProfile(userId: postDetail!.usersId,));
            }
            else{
              Get.toNamed("/SignInScreen");
            }
          }
          else{
            Get.to(() => AppData().userdetail!.usersId==postDetail!.usersId?ProfileScreen():FollowProfile(userId: postDetail!.usersId,));
          }
        },
        child: Row(
          children: [
            Container(
              height: GetPlatform.isDesktop?55:45,
              width: GetPlatform.isDesktop?55:45,
              margin: EdgeInsets.only(top: GetPlatform.isDesktop? 10:0),
              child: Stack(
                children: [
                  Container(
                    margin: EdgeInsets.only(left: MediaQuery.of(context).size.width*0.01),
                    decoration: BoxDecoration(
                        border: Border.all(
                          color: Colors.amber,
                          width: 2,
                        ),
                        shape: BoxShape.circle
                    ),

                    child: ClipOval(
                      child: postDetail!.postUserProfilePicture == null || postDetail!.postUserProfilePicture == "" ?CustomImage(
                        image: Images.placeholder,
                        height: 35,
                        width: 35,
                        fit: BoxFit.cover,
                      ):Image.network(
                        postDetail!.postUserProfilePicture!,
                        width: 35,height: 35,fit: BoxFit.cover,
                      ),
                    ),

                  ),
                  postDetail!.userVerified?Positioned(
                    bottom: GetPlatform.isDesktop?12: 3, right: GetPlatform.isDesktop?5: 3,
                    child: SvgPicture.asset(Images.badge,height: 15,width: 15,),
                  ):SizedBox(),
                ],
              ),
            ),
            Container(
              padding: EdgeInsets.only(left: GetPlatform.isDesktop? 20: MediaQuery.of(context).size.width*0.04),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [

                  // Row(
                  //   children: [
                  //     Padding(
                  //       padding: const EdgeInsets.all( 0.0),
                  //       child: SvgPicture.asset(Images.user,width:12,height:12,color: Colors.grey,),
                  //     ),
                  //     SizedBox(width: 5,),
                  //   ],
                  // ),
                  Text(postDetail!.postUserName??'',style: openSansBold.copyWith(fontSize:Dimensions.fontSizeSmall,color:Colors.black),),

                  Row(
                    children: [
                      SvgPicture.asset(Images.clock,width:12,height:12,color: Colors.grey,),
                      SizedBox(width: 5,),
                      Text(postDetail!.timeAgo??'',style: openSansRegular.copyWith(fontSize:Dimensions.fontSizeSmall,color:Colors.black),),
                    ],
                  ),

                ],
              ),
            ),

          ],
        ),
      ),
    );
  }
}
