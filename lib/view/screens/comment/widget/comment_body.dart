import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:knaw_news/model/comment_model.dart';
import 'package:knaw_news/util/dimensions.dart';
import 'package:knaw_news/util/images.dart';
import 'package:knaw_news/util/styles.dart';

class CommentBody extends StatelessWidget {
  CommentDetail? commentDetail;
  void Function()? replyTap;
  void Function()? onTapLike;
  CommentBody({this.commentDetail,this.replyTap,this.onTapLike});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        //Icon(Icons.favorite,color: Colors.red,size: 15,),
        Text(commentDetail!.comment??'',style: openSansMedium.copyWith(fontSize: Dimensions.fontSizeSmall,color: Colors.black87),),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            GestureDetector(
              onTap: onTapLike,
              child: Row(
                children: [
                  SvgPicture.asset(Images.heart,height: 11,width: 11,color: commentDetail!.isCommentLiked=="true"?Colors.red:Colors.grey,),
                  SizedBox(width: 10,),
                  //Icon(Icons.favorite,color: Colors.red,size: 15,),
                  Text(commentDetail!.commentLikes.toString(),style: openSansRegular.copyWith(fontSize: Dimensions.fontSizeExtraSmall,color: commentDetail!.isCommentLiked=="true"?Colors.black:Colors.grey),),
                ],
              ),
            ),
            InkWell(
              onTap: replyTap,
              child: Text(commentDetail!.totalReplies==0?"Reply":"Views replies ("+commentDetail!.totalReplies.toString()+")",style: openSansRegular.copyWith(fontSize: Dimensions.fontSizeExtraSmall,color: Colors.black.withOpacity(0.5)),),
            ),

          ],
        ),

      ],
    );
  }
}
