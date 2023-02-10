import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/src/extension_navigation.dart';
import 'package:knaw_news/mixin/data.dart';
import 'package:knaw_news/model/comment_model.dart';
import 'package:knaw_news/model/post_model.dart';
import 'package:knaw_news/services/dio_service.dart';
import 'package:knaw_news/util/app_constants.dart';
import 'package:knaw_news/util/dimensions.dart';
import 'package:knaw_news/util/images.dart';
import 'package:knaw_news/util/styles.dart';
import 'package:knaw_news/view/base/custom_image.dart';
import 'package:knaw_news/view/base/custom_snackbar.dart';
import 'package:knaw_news/view/base/loading_dialog.dart';
import 'package:knaw_news/view/base/no_data_screen.dart';
import 'package:knaw_news/view/screens/comment/widget/comment_body.dart';
import 'package:knaw_news/view/screens/comment/widget/reply_body.dart';
import 'package:knaw_news/view/screens/comment/widget/web_commenter_detail.dart';
import 'package:knaw_news/view/screens/comment/widget/web_reply_detail.dart';

class WebComment extends StatefulWidget {
  PostDetail? postDetail;
  WebComment({this.postDetail});

  @override
  State<WebComment> createState() => _WebCommentState();
}

class _WebCommentState extends State<WebComment> {
  ScrollController scrollController=ScrollController();
  TextEditingController commentController=TextEditingController();
  List <CommentDetail>? commentDetail;
  List <ReplyDetail>? replyDetail;
  String toReply="";
  int replyIndex=0;
  int totalComments=0;
  int totalReplies=0;
  String? comment;
  bool isReply=false;
  bool viewReply=false;
  String offset="0";

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    scrollController.addListener(_handleScroll);
    WidgetsBinding.instance!.addPostFrameCallback((timeStamp) {
      getAllComments();
    });
  }
  void _handleScroll() {
    print(scrollController.offset);
    print(scrollController.position.extentBefore);
    print(scrollController.position.extentAfter);
    print(scrollController.position.extentInside);
    print(scrollController.position.viewportDimension);
    print(scrollController.position.pixels);



    if(scrollController.position.pixels >= scrollController.position.maxScrollExtent){
      print("max scroll");
      if(totalComments>int.parse(offset)+5) {
        offset = (int.parse(offset) +5).toString();
        print("load more");
        getAllComments();
      }
      else{
        print("post not avilable");
      }

    }
    else{
      print("no max scroll");
    }
  }
  @override
  Widget build(BuildContext context) {
    Size size=MediaQuery.of(context).size;
    double mediaWidth=size.width;
    mediaWidth*=0.4;
    return Container(
      height: GetPlatform.isDesktop?mediaWidth*0.5:commentDetail== null ? 80 : commentDetail!.length==1?200:MediaQuery.of(context).size.height*0.4,
      color: Colors.white,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            width: mediaWidth,
            child: Padding(
              padding: EdgeInsets.only(bottom: 10,top: 5),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  isReply?Container(
                    padding: EdgeInsets.only(left: mediaWidth*0.05),
                    child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        //crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          //SizedBox(width: 5,),
                          Text('Replying to',style: openSansRegular.copyWith(fontSize: Dimensions.fontSizeSmall,color: Colors.black87),),
                          SizedBox(width: 5,),
                          Text(toReply,style: openSansExtraBold.copyWith(fontSize: Dimensions.fontSizeSmall,color: Colors.black87),),
                          SizedBox(width: 5,),
                          InkWell(
                            onTap: (){
                              isReply=!isReply;setState(() {

                              });},
                            child: Container(
                              child: Text('Cancel',style: openSansMedium.copyWith(fontSize: Dimensions.fontSizeSmall,color: Colors.black87),),
                            ),
                          ),
                        ]),
                  ):SizedBox(),
                  Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      //crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Stack(
                          children: [
                            ClipOval(
                              child: AppData().userdetail!.profilePicture == null || AppData().userdetail!.profilePicture == "" ?CustomImage(
                                image: Images.placeholder,
                                height: 45,
                                width: 45,
                                fit: BoxFit.cover,
                              ):Image.network(
                                AppData().userdetail!.profilePicture!,
                                width: 45,height: 45,fit: BoxFit.cover,
                              ),
                            ),
                            AppData().userdetail!.userVerified?Positioned(
                              bottom: 2, right: 2,
                              child: SvgPicture.asset(Images.badge,height: 12,width: 12,),
                            ):SizedBox(),
                          ],
                        ),
                        SizedBox(width: 5,),
                        SizedBox(
                          width: mediaWidth*0.9,
                          height: 50,
                          child: Row(
                            children: [
                              Container(
                                width: mediaWidth*0.83,
                                height: 50,
                                child: TextField(
                                  controller: commentController,
                                  onChanged: (value)=> comment=value,
                                  style: openSansRegular.copyWith(fontSize: Dimensions.fontSizeSmall,color: textColor),
                                  keyboardType: TextInputType.text,
                                  cursorColor: Theme.of(context).primaryColor,
                                  autofocus: false,
                                  obscureText: false,
                                  decoration: InputDecoration(
                                    focusColor: const Color(0XF7F7F7),
                                    hoverColor: const Color(0XF7F7F7),
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(Dimensions.RADIUS_SMALL),
                                      borderSide: const BorderSide(style: BorderStyle.none, width: 0),
                                    ),
                                    isDense: true,
                                    hintText: isReply?"Add Reply":"Add Comment",
                                    fillColor: Color(0XBBF0F0F0),
                                    hintStyle: openSansRegular.copyWith(fontSize: Dimensions.fontSizeSmall),
                                    filled: true,
                                  ),
                                  onSubmitted: (val){

                                  },
                                  onEditingComplete: (){
                                    if(comment==null||comment==""){
                                      // showCustomSnackBar(isReply?"Please add Reply":"Please add comment");
                                    }
                                    else{
                                      isReply?addReply():addComment();
                                    }
                                    print("This is on Edit Complete");
                                  },
                                ),
                              ),
                              InkWell(
                                onTap: (){
                                  if(comment==null||comment==""){
                                    // showCustomSnackBar(isReply?"Please add Reply":"Please add comment");
                                  }
                                  else{
                                    isReply?addReply():addComment();
                                  }
                                },
                                child: Container(
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(vertical: 8.0),
                                    child: SvgPicture.asset(Images.send),
                                  ),
                                ),
                              )
                            ],
                          ),
                        ),
                      ]),
                ],
              ),
            ),
          ),
          Expanded(
            child: SingleChildScrollView(
              physics: BouncingScrollPhysics(),
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    totalComments>0?Container(
                      width: mediaWidth,
                      margin: EdgeInsets.only(bottom: 10),
                      padding: EdgeInsets.only(left: 5),
                      child: ListView.builder(
                        controller: scrollController,
                          physics: NeverScrollableScrollPhysics(),
                          shrinkWrap: true,
                          //padding: EdgeInsetsGeometry.infinity,
                          itemCount: commentDetail!.length,
                          itemBuilder: (context,index){
                            return Column(
                              children: [
                                SizedBox(height: 5,),
                                Container(
                                  width: mediaWidth*0.9,
                                  child: WebCommenterDetail(
                                    commentDetail: commentDetail![index],
                                    replyTap: (){getAllReplies(index);},
                                    onTapLike: () => likeComment(index),
                                    isReplyTap: (){
                                      print("OK good");
                                      toReply=commentDetail![index].commentUserName!;
                                      replyIndex=index;
                                      isReply=true;
                                      setState(() {});
                                      },
                                  ),
                                ),
                                viewReply&&totalReplies>0?Container(
                                  width: mediaWidth*0.9,
                                  child: ListView.builder(
                                      physics: NeverScrollableScrollPhysics(),
                                      shrinkWrap: true,
                                      //padding: EdgeInsetsGeometry.infinity,
                                      itemCount: replyDetail!.length,
                                      itemBuilder: (context,ind){
                                        return commentDetail![index].commentId==replyDetail![ind].commentId?Column(
                                          children: [
                                            SizedBox(height: 5,),

                                            Container(
                                              padding: EdgeInsets.only(left: mediaWidth*0.10,),
                                              //width: MediaQuery.of(context).size.width*0.9,
                                              child: WebReplierDetail(replyDetail: replyDetail![ind],onTapLike: () => likeReply(ind, index)),
                                            ),
                                          ],
                                        ):SizedBox();
                                      }
                                  ),
                                ):
                                commentDetail![index].totalReplies!>0?Container(
                                  width: mediaWidth*0.9,
                                  child: ListView.builder(
                                      physics: NeverScrollableScrollPhysics(),
                                      shrinkWrap: true,
                                      //padding: EdgeInsetsGeometry.infinity,
                                      itemCount: 1,
                                      itemBuilder: (context,ind){
                                        return Column(
                                          children: [
                                            SizedBox(height: 5,),
                                            Container(
                                              padding: EdgeInsets.only(left: mediaWidth*0.10,),
                                              //width: MediaQuery.of(context).size.width*0.9,
                                              child: WebReplierDetail(replyDetail: commentDetail![index].replyDetail,onTapLike: () => likeReply(-1, index)),
                                            ),
                                          ],
                                        );
                                      }
                                  ),
                                ):
                                SizedBox(),
                              ],
                            );
                          }
                      ),
                    ):Center(child: NoDataScreen(text: "No Comment on post",)),


                  ],
                ),
              ),
            ),
          ),


        ],
      ),
    );
  }
  Future<void> getAllComments() async {
    openLoadingDialog(context, "Loading");
    var response;
    response = await DioService.post('get_all_comments', {
      "newsPostId" : widget.postDetail!.newsPostId,
      "usersId" : AppData().userdetail!.usersId,
      "offset" : offset
    });
    if(response['status']=='success'){
      var jsonData= response['data'] as List;
      commentDetail=  jsonData.map<CommentDetail>((e) => CommentDetail.fromJson(e)).toList();
      //print(commentDetail![0].toJson());
      Navigator.pop(context);
      totalComments=response['total_comments'];
      setState(() {

      });
      //print(followDetail[2].toJson());
    }
    else{
      totalComments=0;
      Navigator.pop(context);
      //showCustomSnackBar(response['message']);

    }
  }
  Future<void> addComment() async {
    openLoadingDialog(context, "Loading");
    var response;
    response = await DioService.post('comment_on_post', {
      "newsPostId" : widget.postDetail!.newsPostId,
      "usersId" : AppData().userdetail!.usersId,
      "comment" : comment
    });
    if(response['status']=='success'){
      //print(postDetail![0].toJson());
      Navigator.pop(context);
      getAllComments();
      comment="";
      commentController.clear();
      //print(followDetail[2].toJson());
    }
    else{
      Navigator.pop(context);
      // showCustomSnackBar(response['message']);

    }
  }
  Future<void> likeComment(int index) async {
    print(commentDetail![index].isCommentLiked);
    openLoadingDialog(context, "Loading");
    var response;
    response = await DioService.post('like_comment', {
      "commentId" : commentDetail![index].commentId,
      "usersId" : AppData().userdetail!.usersId
    });
    if(response['status']=='success'){
      //print(postDetail![0].toJson());
      Navigator.pop(context);
      getAllComments();
      // showCustomSnackBar(response['data'],isError: false);
      //print(followDetail[2].toJson());
    }
    else{
      Navigator.pop(context);
      // showCustomSnackBar(response['message']);

    }
  }
  Future<void> getAllReplies(int index) async {
    openLoadingDialog(context, "Loading");
    var response;
    response = await DioService.post('get_all_replies', {
      "commentId" : commentDetail![index].commentId,
      "usersId" : AppData().userdetail!.usersId
    });
    if(response['status']=='success'){
      var jsonData= response['data'] as List;
      replyDetail=  jsonData.map<ReplyDetail>((e) => ReplyDetail.fromJson(e)).toList();
      print(replyDetail!.length);
      totalReplies=replyDetail!.length;
      viewReply=true;
      Navigator.pop(context);
      setState(() {

      });
      //print(followDetail[2].toJson());
    }
    else{
      totalReplies=0;
      isReply=true;
      setState(() {

      });
      Navigator.pop(context);
      // showCustomSnackBar(response['message']);

    }
  }
  Future<void> addReply() async {
    openLoadingDialog(context, "Loading");
    var response;
    response = await DioService.post('reply_on_comment', {
      "commentId" : commentDetail![replyIndex].commentId,
      "usersId" : AppData().userdetail!.usersId,
      "reply" : comment
    });
    if(response['status']=='success'){
      //print(postDetail![0].toJson());
      Navigator.pop(context);
      getAllReplies(replyIndex);
      comment="";
      commentController.clear();
      //print(followDetail[2].toJson());
    }
    else{
      Navigator.pop(context);
      // showCustomSnackBar(response['message']);

    }
  }
  Future<void> likeReply(int index,int commentIndex) async {
    openLoadingDialog(context, "Loading");
    var response;
    if(index==-1){
      response = await DioService.post('like_reply', {
        "replyId" : commentDetail![commentIndex].replyDetail!.replyId,
        "usersId" : AppData().userdetail!.usersId
      });
    }
    else{
      response = await DioService.post('like_reply', {
        "replyId" : replyDetail![index].replyId,
        "usersId" : AppData().userdetail!.usersId
      });
    }
    if(response['status']=='success'){
      //print(postDetail![0].toJson());
      Navigator.pop(context);
      index==-1?getAllComments():getAllReplies(commentIndex);
      // showCustomSnackBar(response['data'],isError: false);
      //print(followDetail[2].toJson());
    }
    else{
      Navigator.pop(context);
      // showCustomSnackBar(response['message']);
    }
  }
}
