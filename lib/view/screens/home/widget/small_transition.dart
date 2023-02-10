import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/src/extension_navigation.dart';
import 'package:knaw_news/mixin/data.dart';
import 'package:knaw_news/model/post_model.dart';
import 'package:knaw_news/services/dio_service.dart';
import 'package:knaw_news/util/dimensions.dart';
import 'package:knaw_news/util/images.dart';
import 'package:knaw_news/util/styles.dart';
import 'package:knaw_news/view/base/custom_image.dart';
import 'package:knaw_news/view/base/custom_snackbar.dart';
import 'package:knaw_news/view/base/loading_dialog.dart';
import 'package:knaw_news/view/screens/comment/comment.dart';
import 'package:knaw_news/view/screens/home/widget/report_dialog.dart';
import 'package:knaw_news/view/screens/home/widget/user_info.dart';
import 'package:knaw_news/view/screens/home/widget/vertical_tile.dart';
import 'package:share_plus/share_plus.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:expandable_text/expandable_text.dart';
class SmallTransition extends StatefulWidget {
  bool isBookmark;
  PostDetail? postDetail;
  SmallTransition({this.isBookmark=false,this.postDetail});

  @override
  State<SmallTransition> createState() => _SmallTransitionState();
}

class _SmallTransitionState extends State<SmallTransition> {



  _launchURL(String _url) async {
    if (!await launch(_url)) throw 'Could not launch $_url';
  }
  @override
  Widget build(BuildContext context) {
    return Wrap(
      children: [
        Container(

          width: MediaQuery.of(context).size.width*0.9,
          //padding: EdgeInsets.symmetric(horizontal: MediaQuery.of(context).size.width*0.03),
          margin: EdgeInsets.only(top: 5),
          decoration: BoxDecoration(
            color: widget.postDetail!.isViewed!?Colors.grey.withOpacity(0.1):Colors.white,
            borderRadius: BorderRadius.circular(10),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // User Detail
              UserInfo(postDetail: widget.postDetail,),
              // Headline
              Container(
                padding: EdgeInsets.only(left: MediaQuery.of(context).size.width*0.01,),
                width: MediaQuery.of(context).size.width*0.9,
                child: ListView(
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  children: [
                    Wrap(
                        children:[
                          Text(widget.postDetail!.title??'',maxLines:2,style: openSansSemiBold.copyWith(fontSize:Dimensions.fontSizeDefault-1,color:Colors.black),),
                          //postDetail!.description!.length<100?postDetail!.description!+"\n":
                        ]),
                  ],
                ),
              ),
              // post Date
              Padding(
                padding: const EdgeInsets.only(left: 8.0),
                child: Text(widget.postDetail!.category=='Events'?widget.postDetail!.eventNewsStartDate!+" "+widget.postDetail!.eventNewsEndDate!:widget.postDetail!.createdAt??'',style: openSansRegular.copyWith(fontSize:Dimensions.fontSizeSmall,color:Colors.grey),),
              ),

              // Doted News
              Wrap(
                  spacing: 0,
                  runSpacing: 0,
                  children:[
                    // DotNews(text: "COVID-19: Former vaccines chief."),
                    // DotNews(text: "Alec Baldwin told gun was safe before fatal shooting - BBC News"),
                    ExpandableText(
                      widget.postDetail!.description!,
                      expandText: "(Read More)",
                      maxLines: 3,
                      style: openSansRegular.copyWith(fontSize: Dimensions.fontSizeSmall,color: Colors.black),
                      linkStyle: openSansRegular.copyWith(fontSize: Dimensions.fontSizeSmall,color: Colors.amber),
                    ),
                    // RichText(
                    //   maxLines:3,
                    //   text: TextSpan(
                    //       text: widget.postDetail!.description!,
                    //       style: openSansRegular.copyWith(fontSize: Dimensions.fontSizeSmall,color: Colors.black),
                    //       children: <TextSpan>[
                    //         TextSpan(text: "(Read More)",
                    //           style: openSansRegular.copyWith(fontSize: Dimensions.fontSizeSmall,color: Colors.amber),
                    //         )
                    //       ]
                    //   ),
                    // ),
                    // Container(
                    //   alignment: Alignment.topLeft,
                    //   padding: EdgeInsets.all(5),
                    //   child: Text(widget.postDetail!.description!,maxLines: 3,
                    //     style: openSansRegular.copyWith(fontSize: Dimensions.fontSizeSmall),
                    //   ),
                    // ),
                    // if(widget.postDetail!.description!.length>200)Text("(Read More)",
                    //   style: openSansRegular.copyWith(fontSize: Dimensions.fontSizeSmall,color: Colors.amber),
                    // ),
                    // Container(
                    //   alignment: Alignment.topLeft,
                    //   padding: EdgeInsets.all(5),
                    //   child: Text(widget.postDetail!.description!,
                    //     style: openSansRegular.copyWith(fontSize: Dimensions.fontSizeSmall),
                    //   ),
                    // ),
                  ]),
              //Post Image
              Container(
                padding: EdgeInsets.all(5),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(5),
                  child: widget.postDetail!.postPicture == null || widget.postDetail!.postPicture == "" ?CustomImage(
                    image: Images.placeholder,
                    height: MediaQuery.of(context).size.height*0.25,
                    width: MediaQuery.of(context).size.width*0.9,
                    fit: BoxFit.cover,
                  ):Image.network(
                    widget.postDetail!.postPicture??'',
                    height: MediaQuery.of(context).size.height*0.25, width: MediaQuery.of(context).size.width*0.9,fit: BoxFit.cover,
                  ),
                ),
              ),
              // Action Bar
              Container(
                padding: EdgeInsets.symmetric(horizontal: 5),
                child: Row(
                  children: [
                    VerticalTile(icon: widget.postDetail!.category=="Opinion"?widget.postDetail!.isHappyReacted!?Images.like:Images.like_bold:widget.postDetail!.isHappyReacted!?Images.smile_face:Images.smile_face_bold, title: widget.postDetail!.happyReactions.toString(),isBlack: true,onTap: widget.postDetail!.category=="Opinion"?likeOpinion:happyReact,),
                    Expanded(child: Container()),
                    VerticalTile(icon: widget.postDetail!.category=="Opinion"?widget.postDetail!.isSadReacted!?Images.dislike:Images.dislike_bold:widget.postDetail!.isSadReacted!?Images.sad_face:Images.sad_face_bold, title: widget.postDetail!.sadReactions.toString(),isBlack: true,onTap: widget.postDetail!.category=="Opinion"?dislikeOpinion:sadReact,),
                    Expanded(child: Container()),
                    VerticalTile(icon: widget.postDetail!.isBookmarked=="true"?Images.bookmark_bold:Images.bookmark, title: "Bookmarks",onTap: bookmarkPost,),
                    Expanded(child: Container()),
                    VerticalTile(icon: Images.comment, title: widget.postDetail!.totalComments.toString(),isBlack: true,onTap: () => Get.bottomSheet(CommentScreen(postDetail: widget.postDetail,)),),
                    Expanded(child: Container()),
                    VerticalTile(icon: Images.link, title: "Link",onTap: () => _launchURL(widget.postDetail!.externalLink??''),),
                    Expanded(child: Container()),
                    VerticalTile(icon: Images.share, title: "Share",onTap: (){
                      Share.share(
                          "Headline: "+ widget.postDetail!.title!+"\n"+
                              "Summary: "+widget.postDetail!.description!.substring(0,100)+
                              '\nClick to read more https://play.google.com/store/apps/details?id=com.knawnews.apps&hl=en&gl=US');
                    }),
                    Expanded(child: Container()),
                    VerticalTile(icon: Images.report, title: "Report",onTap: () => Get.dialog(ReportDialog(postDetail: widget.postDetail,)),),
                  ],
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
  Future<void> bookmarkPost() async {
    openLoadingDialog(context, "Loading");
    var response;
    response = await DioService.post('bookmark_news_post', {
      "newsPostId" : widget.postDetail!.newsPostId,
      "usersId" : AppData().userdetail!.usersId
    });
    if(response['status']=='success'){
      //print(postDetail![0].toJson());
      widget.postDetail!.isBookmarked=="true"?widget.postDetail!.isBookmarked="false":widget.postDetail!.isBookmarked="true";
      Navigator.pop(context);
      setState(() {

      });
      // showCustomSnackBar(response['data'],isError: false);
    }
    else{
      Navigator.pop(context);
      setState(() {

      });
      // showCustomSnackBar(response['message']);
    }
  }
  Future<void> happyReact() async {
    openLoadingDialog(context, "Loading");
    var response;
    response = await DioService.post('react_happy', {
      "newsPostId" : widget.postDetail!.newsPostId,
      "usersId" : AppData().userdetail!.usersId
    });
    if(response['status']=='success'){
      //print(postDetail![0].toJson());
      widget.postDetail!.isHappyReacted!?widget.postDetail!.happyReactions=(widget.postDetail!.happyReactions!-1):widget.postDetail!.happyReactions=(widget.postDetail!.happyReactions!+1);
      widget.postDetail!.isHappyReacted!?widget.postDetail!.isHappyReacted=false:widget.postDetail!.isHappyReacted=true;
      Navigator.pop(context);
      setState(() {

      });
      // showCustomSnackBar(response['data'],isError: false);
    }
    else{
      Navigator.pop(context);
      setState(() {

      });
      // showCustomSnackBar(response['message']);

    }
  }
  Future<void> sadReact() async {
    openLoadingDialog(context, "Loading");
    var response;
    response = await DioService.post('react_sad', {
      "newsPostId" : widget.postDetail!.newsPostId,
      "usersId" : AppData().userdetail!.usersId
    });
    if(response['status']=='success'){
      //print(postDetail![0].toJson());
      widget.postDetail!.isSadReacted!?widget.postDetail!.sadReactions=(widget.postDetail!.sadReactions!-1):widget.postDetail!.sadReactions=(widget.postDetail!.sadReactions!+1);
      widget.postDetail!.isSadReacted!?widget.postDetail!.isSadReacted=false:widget.postDetail!.isSadReacted=true;
      Navigator.pop(context);
      setState(() {

      });
      // showCustomSnackBar(response['data'],isError: false);
    }
    else{
      Navigator.pop(context);
      setState(() {

      });
      // showCustomSnackBar(response['message']);

    }
  }
  Future<void> likeOpinion() async {
    openLoadingDialog(context, "Loading");
    var response;
    response = await DioService.post('like_opinion', {
      "newsPostId" : widget.postDetail!.newsPostId,
      "usersId" : AppData().userdetail!.usersId
    });
    if(response['status']=='success'){
      //print(postDetail![0].toJson());
      widget.postDetail!.isHappyReacted!?widget.postDetail!.happyReactions=(widget.postDetail!.happyReactions!-1):widget.postDetail!.happyReactions=(widget.postDetail!.happyReactions!+1);
      widget.postDetail!.isHappyReacted!?widget.postDetail!.isHappyReacted=false:widget.postDetail!.isHappyReacted=true;
      Navigator.pop(context);
      setState(() {

      });
      // showCustomSnackBar(response['data'],isError: false);
    }
    else{
      Navigator.pop(context);
      setState(() {

      });
      // showCustomSnackBar(response['message']);

    }
  }
  Future<void> dislikeOpinion() async {
    openLoadingDialog(context, "Loading");
    var response;
    response = await DioService.post('dislike_opinion', {
      "newsPostId" : widget.postDetail!.newsPostId,
      "usersId" : AppData().userdetail!.usersId
    });
    if(response['status']=='success'){
      //print(postDetail![0].toJson());
      widget.postDetail!.isSadReacted!?widget.postDetail!.sadReactions=(widget.postDetail!.sadReactions!-1):widget.postDetail!.sadReactions=(widget.postDetail!.sadReactions!+1);
      widget.postDetail!.isSadReacted!?widget.postDetail!.isSadReacted=false:widget.postDetail!.isSadReacted=true;
      Navigator.pop(context);
      setState(() {

      });
      // showCustomSnackBar(response['data'],isError: false);
    }
    else{
      Navigator.pop(context);
      setState(() {

      });
      // showCustomSnackBar(response['message']);

    }
  }
}
