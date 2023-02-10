import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:knaw_news/mixin/data.dart';
import 'package:knaw_news/model/notification_model.dart';
import 'package:knaw_news/services/dio_service.dart';
import 'package:knaw_news/util/app_constants.dart';
import 'package:knaw_news/util/dimensions.dart';
import 'package:knaw_news/util/images.dart';
import 'package:knaw_news/util/styles.dart';
import 'package:knaw_news/view/base/custom_image.dart';
import 'package:knaw_news/view/base/custom_snackbar.dart';
import 'package:knaw_news/view/base/loading_dialog.dart';
import 'package:knaw_news/view/screens/profile/follow_profile.dart';
import 'package:knaw_news/view/screens/profile/web/web_follow_profile.dart';

class WebFriendCard extends StatefulWidget {
  NotificationDetail? notificationDetail;
  WebFriendCard({Key? key, this.notificationDetail,}) : super(key: key);

  @override
  State<WebFriendCard> createState() => _WebFriendCardState();
}

class _WebFriendCardState extends State<WebFriendCard> {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => Get.to(() => WebFollowProfile(userId: widget.notificationDetail!.senderUsersId)),
      child: Container(
        child: ListTile(
          leading: Stack(
            children: [
              ClipOval(
                child: widget.notificationDetail!.senderUserProfilePicture == null || widget.notificationDetail!.senderUserProfilePicture == "" ?
                CustomImage(
                  image: Images.placeholder,
                  height: 40,
                  width: 40,
                  fit: BoxFit.cover,
                ):
                Image.network(
                 widget.notificationDetail!.senderUserProfilePicture!,
                  width: 40,height: 40,fit: BoxFit.cover,
                ),
              ),
              Positioned(
                bottom: 0, right: 0,
                child: SvgPicture.asset(Images.badge,height: 12,width: 12,),
              ),
            ],
          ),
          title: Text(widget.notificationDetail!.senderUsername??'',style: openSansBold.copyWith(color: Colors.black,fontSize: Dimensions.fontSizeSmall),),
          subtitle: Text(widget.notificationDetail!.message!+"."+widget.notificationDetail!.daysAgo!,style: openSansRegular.copyWith(fontSize:Dimensions.fontSizeExtraSmall,color: textColor,),),
          trailing: widget.notificationDetail!.notificationType!="Following"?
          Container(
            height: 70,
            width: 50,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(5),
              child: widget.notificationDetail!.newsPostPicture == null || widget.notificationDetail!.newsPostPicture == "" ?
              CustomImage(
                image: Images.placeholder,
                height: 60,
                width: 40,
                fit: BoxFit.cover,
              ):
              Image.network(
                widget.notificationDetail!.newsPostPicture!,
                width: 40,height: 60,fit: BoxFit.cover,
              ),
            ),
          ):
          InkWell(
            onTap: followUser,
            child: Container(
              height: 28,
              width: 90,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(5),
                  color: widget.notificationDetail!.isFollowingBack!?Colors.amber:Colors.black
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 6.0,right: 3,bottom: 6.0),
                    child: SvgPicture.asset(Images.user,color: Colors.white,),
                  ),
                  Text(widget.notificationDetail!.isFollowingBack!?"Unfollow":"Follow",style: openSansRegular.copyWith(color:Colors.white,fontSize: Dimensions.fontSizeExtraSmall),)
                ],),
            ),
          ),
        ),
      ),
    );
  }
  Future<void> followUser() async {
    openLoadingDialog(context, "Loading");
    var response;
    response = await DioService.post('follow_user', {
      "followingToUser" : widget.notificationDetail!.senderUsersId,
      "followedByUser" : AppData().userdetail!.usersId
    });
    if(response['status']=='success'){
      widget.notificationDetail!.isFollowingBack=!widget.notificationDetail!.isFollowingBack!;
      //print(postDetail![0].toJson());
      Navigator.pop(context);
      setState(() {

      });
      showCustomSnackBar(response['data'],isError: false);
      //print(followDetail[2].toJson());
    }
    else{
      Navigator.pop(context);
      showCustomSnackBar(response['message']);

    }
  }
}
