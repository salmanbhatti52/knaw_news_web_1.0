import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:knaw_news/model/comment_model.dart';
import 'package:knaw_news/util/app_constants.dart';
import 'package:knaw_news/util/dimensions.dart';
import 'package:knaw_news/util/images.dart';
import 'package:knaw_news/util/styles.dart';
import 'package:knaw_news/view/base/custom_image.dart';

class ReplierDetail extends StatelessWidget {
  ReplyDetail? replyDetail;
  void Function()? onTapLike;
  ReplierDetail({this.replyDetail,this.onTapLike});


  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Stack(
          children: [
            ClipOval(
              child: replyDetail!.replyProfilePicture == null || replyDetail!.replyProfilePicture == "" ?CustomImage(
                image: Images.placeholder,
                height: 30,
                width: 30,
                fit: BoxFit.cover,
              ):Image.network(
                AppConstants.proxyUrl+replyDetail!.replyProfilePicture!,
                width: 30,height: 30,fit: BoxFit.cover,
              ),
            ),
            replyDetail!.userVerified??false?Positioned(
              bottom: 0, right: 0,
              child: SvgPicture.asset(Images.badge,height: 10,width: 10,),
            ):SizedBox(),
          ],
        ),
        SizedBox(width: 10),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(replyDetail!.replyUserName??'',style: openSansBold.copyWith(color: Colors.black),),
            Text(replyDetail!.replyTimeAgo??'',style: openSansRegular.copyWith(fontSize: Dimensions.fontSizeExtraSmall,color: Colors.black.withOpacity(0.5)),),
            Container(
                width: MediaQuery.of(context).size.width*0.65,
              child: Text(replyDetail!.reply??'',style: openSansMedium.copyWith(fontSize: Dimensions.fontSizeSmall,color: Colors.black87),),
            ),
            GestureDetector(
              onTap: onTapLike,
              child: Row(
                children: [
                  SvgPicture.asset(Images.heart,height: 11,width: 11,color: replyDetail!.isReplyLiked=="true"?Colors.red:Colors.grey,),
                  SizedBox(width: 10,),
                  //Icon(Icons.favorite,color: Colors.red,size: 15,),
                  Text(replyDetail!.replyLikes.toString(),style: openSansRegular.copyWith(fontSize: Dimensions.fontSizeExtraSmall,color: replyDetail!.isReplyLiked=="true"?Colors.black:Colors.grey),),
                ],
              ),
            ),
          ],
        ),
      ],
    );
  }
}

