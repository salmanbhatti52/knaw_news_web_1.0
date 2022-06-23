import 'dart:ui';
import 'dart:html' as html;
import 'package:expandable_text/expandable_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/src/extension_navigation.dart';
import 'package:knaw_news/api/auth.dart';
import 'package:knaw_news/mixin/data.dart';
import 'package:knaw_news/model/post_model.dart';
import 'package:knaw_news/services/dio_service.dart';
import 'package:knaw_news/util/app_constants.dart';
import 'package:knaw_news/util/dimensions.dart';
import 'package:knaw_news/util/images.dart';
import 'package:knaw_news/util/styles.dart';
import 'package:knaw_news/view/base/custom_image.dart';
import 'package:knaw_news/view/base/custom_snackbar.dart';
import 'package:knaw_news/view/base/loading_dialog.dart';
import 'package:knaw_news/view/screens/auth/web/web_sign_in.dart';
import 'package:knaw_news/view/screens/comment/comment.dart';
import 'package:knaw_news/view/screens/comment/web_comment.dart';
import 'package:knaw_news/view/screens/home/widget/report_dialog.dart';
import 'package:knaw_news/view/screens/home/widget/user_info.dart';
import 'package:knaw_news/view/screens/home/widget/vertical_tile.dart';
import 'package:share_plus/share_plus.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:expandable_text_widget/expandable_text_widget.dart';
import 'package:translator/translator.dart';



class FullTransition extends StatefulWidget {
  PostDetail? postDetail;
  FullTransition({Key? key, this.postDetail,}) : super(key: key);

  @override
  State<FullTransition> createState() => _FullTransitionState();
}

class _FullTransitionState extends State<FullTransition> {
  bool isComment=false;
  bool isReadMore=false;
  _launchURL(String _url) async {
    html.window.open(_url, '_blank');
    //if (!await launch(_url,universalLinksOnly: true,forceWebView: true,enableJavaScript: true)) throw 'Could not launch $_url';
  }
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    WidgetsBinding.instance!.addPostFrameCallback((timeStamp) {
      translate();
    });
  }
  @override
  Widget build(BuildContext context) {
    return Wrap(
      children: [
        Container(
          width: MediaQuery.of(context).size.width*0.9,
          //padding: EdgeInsets.symmetric(horizontal: MediaQuery.of(context).size.width*0.03),
          margin: EdgeInsets.only(top: 10),
          decoration: BoxDecoration(
            color: Colors.white,
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
                          Text(widget.postDetail!.title??'',maxLines:2,style: openSansSemiBold.copyWith(fontSize:Dimensions.fontSizeDefault,color:Colors.black),),
                          //postDetail!.description!.length<100?postDetail!.description!+"\n":
                        ]),
                  ],
                ),
              ),
              // post Date
              Padding(
                padding: EdgeInsets.only(left: GetPlatform.isDesktop? MediaQuery.of(context).size.width*0.01: 8.0),
                child: Text(widget.postDetail!.category=='Events'&&widget.postDetail!.eventNewsStartDate!=null&&widget.postDetail!.eventNewsEndDate!=null?widget.postDetail!.eventNewsStartDate!+" "+widget.postDetail!.eventNewsEndDate!:widget.postDetail!.createdAt??'',style: openSansRegular.copyWith(fontSize:Dimensions.fontSizeSmall,color:Colors.grey),),
              ),

              // News Description
              Padding(
                padding: EdgeInsets.symmetric(horizontal: GetPlatform.isDesktop? MediaQuery.of(context).size.width*0.01: 5.0),
                child: Stack(
                  children: [
                    Text(
                      widget.postDetail!.description!,
                      maxLines: isReadMore?100:3,
                      style: openSansRegular.copyWith(fontSize: Dimensions.fontSizeSmall,color: Colors.black,overflow: TextOverflow.fade),
                    ),
                    isReadMore?SizedBox():
                    Positioned(
                      bottom: 0,right: 0,
                        child: Container(
                          width: GetPlatform.isDesktop?110: 100,
                          color: Colors.white,
                          child: InkWell(
                              onTap: (){
                                if(AppData().isAuthenticated){
                                  widget.postDetail!.isViewed!?null:viewPost();
                                  isReadMore=true;
                                  setState(() {
                                  });
                                }
                                else{
                                  GetPlatform.isDesktop?Get.to(WebSignIn()):Get.to(Auth());
                                }

                              },
                              child: Text(".....(${AppData().isLanguage?AppData().language!.readMore:"Read More"})",style: openSansBold.copyWith(fontSize: GetPlatform.isDesktop?Dimensions.fontSizeExtraSmall:Dimensions.fontSizeSmall,color: Colors.amber))
                          ),
                        )
                    ),
                    // Container(
                    //   child: ClipRect(
                    //     child:  BackdropFilter(
                    //       filter:  ImageFilter.blur(sigmaX:1, sigmaY:1.2),
                    //       child:  Container(
                    //         width: 80,
                    //         height:  15,
                    //         decoration:  BoxDecoration(color: Colors.grey.shade100.withOpacity(0.5)),
                    //         alignment: Alignment.centerRight,
                    //         child: InkWell(
                    //             onTap: (){
                    //               isReadMore=true;
                    //               setState(() {
                    //               });
                    //             },
                    //             child: Text("(Read More)",style: openSansRegular.copyWith(fontSize: Dimensions.fontSizeSmall,color: Colors.amber))
                    //         ),
                    //       ),
                    //     ),
                    //   ),
                    // )
                  ],
                ),
              ),

              // Padding(
              //   padding: const EdgeInsets.symmetric(horizontal: 5.0),
              //   child: ExpandableText(
              //     widget.postDetail!.description!,
              //     linkEllipsis: false,
              //     expandText: "(Read More)",
              //     maxLines: 3,
              //     prefixText: "Prefix",
              //     collapseText: "Collasp",
              //     semanticsLabel: "Label",
              //     style: openSansRegular.copyWith(fontSize: Dimensions.fontSizeSmall,color: Colors.black,overflow: TextOverflow.fade),
              //     linkStyle: openSansRegular.copyWith(fontSize: Dimensions.fontSizeSmall,color: Colors.amber),
              //     hashtagStyle: openSansRegular.copyWith(fontSize: Dimensions.fontSizeSmall,color: Colors.red),
              //     mentionStyle: openSansRegular.copyWith(fontSize: Dimensions.fontSizeSmall,color: Colors.green),
              //     prefixStyle: openSansRegular.copyWith(fontSize: Dimensions.fontSizeSmall,color: Colors.blue),
              //     urlStyle: openSansRegular.copyWith(fontSize: Dimensions.fontSizeSmall,color: Colors.orangeAccent),
              //
              //     onExpandedChanged: (val){
              //       widget.postDetail!.isViewed!?null:viewPost();
              //       print("tap expand");
              //     },
              //   ),
              // ),
              // ExpandableTextWidget(
              //   title: Text(
              //     widget.postDetail!.description!,
              //     style: openSansRegular.copyWith(fontSize: Dimensions.fontSizeSmall,color: Colors.black),
              //   ),
              //   text: "test",
              //   textStyle: openSansRegular.copyWith(fontSize: Dimensions.fontSizeSmall,color: Colors.black),
              //   downIcon: Text("(Read More)",style: openSansRegular.copyWith(fontSize: Dimensions.fontSizeSmall,color: Colors.amber),),
              //
              // ),
              //Post Image
              Container(
                padding: EdgeInsets.symmetric(vertical: 5),
                child: ClipRRect(
                  child: widget.postDetail!.postPicture == null || widget.postDetail!.postPicture == "" ?
                  SizedBox():
                  Image.network(
                    //"https://cros-anywhere.herokuapp.com/"+widget.postDetail!.postPicture??'',
                    AppConstants.proxyUrl+widget.postDetail!.postPicture!,
                    height: GetPlatform.isDesktop?MediaQuery.of(context).size.width*0.2: MediaQuery.of(context).size.height*0.25, width: MediaQuery.of(context).size.width*0.9,fit: BoxFit.cover,
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
                    VerticalTile(icon: widget.postDetail!.isBookmarked=="true"?Images.bookmark_bold:Images.bookmark, title: AppData().isLanguage?AppData().language!.bookmarks:"Bookmarks",onTap: bookmarkPost,),
                    Expanded(child: Container()),
                    VerticalTile(icon: Images.comment, title: widget.postDetail!.totalComments.toString(),isBlack: true,onTap: (){
                      //Get.bottomSheet(CommentScreen(postDetail: widget.postDetail,));
                      isComment=!isComment;
                      setState(() {

                      });
                    }),
                    Expanded(child: Container()),
                    widget.postDetail!.externalLink!.isURL?VerticalTile(icon: Images.link, title: AppData().isLanguage?AppData().language!.source:"Source",onTap: () => _launchURL(widget.postDetail!.externalLink!.contains("http")?widget.postDetail!.externalLink!:"http://${widget.postDetail!.externalLink!}"),):SizedBox(),
                    widget.postDetail!.externalLink!.isURL?Expanded(child: Container()):SizedBox(),
                    VerticalTile(icon: Images.share, title: AppData().isLanguage?AppData().language!.share:"Share",onTap: (){
                      Share.share(
                          "Headline: "+ widget.postDetail!.title!+"\n"+
                              "Summary: "+widget.postDetail!.description!.substring(0,100)+
                              '\nClick to read more https://play.google.com/store/apps/details?id=com.knawnews.apps&hl=en&gl=US');
                    }),
                    Expanded(child: Container()),
                    PopupMenuButton(
                        child: Center(
                            child:  Icon(Icons.more_vert,size:GetPlatform.isDesktop?30: 20,color: Colors.grey.withOpacity(0.5),)
                        ),
                        onSelected: (value){

                        },
                        itemBuilder: (context) => [
                          PopupMenuItem(

                            padding:const EdgeInsets.symmetric(vertical: 0,horizontal: 8),
                            height:20,
                            child: InkWell(
                              onTap: () => AppData().isAuthenticated?Get.dialog(ReportDialog(postDetail: widget.postDetail)):GetPlatform.isDesktop?Get.toNamed("/WebSignIn"):Get.to(Auth()),
                              child: Text(AppData().isLanguage?AppData().language!.reportThread:'Report Thread',
                                style: openSansRegular.copyWith(fontSize: Dimensions.fontSizeSmall),),
                            ),


                          ),
                        ]
                    ),
                    //VerticalTile(icon: Images.report, title: "Report",onTap: () => Get.dialog(ReportDialog(postDetail: widget.postDetail,)),),
                  ],
                ),
              ),
            ],
          ),
        ),
        isComment?Container(child: GetPlatform.isDesktop?WebComment(postDetail: widget.postDetail,):CommentScreen(postDetail: widget.postDetail,)):SizedBox()
        //SizedBox(height: 20,),

        //Related News
        // SingleChildScrollView(
        //   scrollDirection: Axis.horizontal,
        //   child: Container(
        //     //padding: EdgeInsets.only(left: MediaQuery.of(context).size.width*0.03),
        //
        //     margin: EdgeInsets.only(bottom: 5),
        //     child: Row(
        //       children: [
        //         widget.postDetail!.relatedPosts != null?
        //         Container(
        //           height: 50,
        //           child: ListView.builder(
        //             scrollDirection: Axis.horizontal,
        //               physics: NeverScrollableScrollPhysics(),
        //               shrinkWrap: true,
        //               //padding: EdgeInsetsGeometry.infinity,
        //               itemCount: widget.postDetail!.relatedPosts!.length,
        //               itemBuilder: (context,index){
        //                 return InkWell(
        //                   onTap: (){
        //                     print("Related news tap");
        //                     widget.relatedDetail!(widget.postDetail!.relatedPosts![index].newsPostId!);
        //                     print("After Related news tap");
        //                 },
        //                     child: RelatedNews(
        //                       newsheadlines: widget.postDetail!.relatedPosts![index].title??'',
        //                       name: widget.postDetail!.relatedPosts![index].postUserName??'',
        //                       time: widget.postDetail!.relatedPosts![index].timeAgo??'',
        //                       isViewed: widget.postDetail!.relatedPosts![index].isViewed??false,
        //                     )
        //
        //                 );
        //
        //               }
        //           ),
        //         ):SizedBox(),
        //       ],
        //     ),
        //   ),
        // ),
      ],
    );
  }

  void translate() async {
    var translation=await widget.postDetail!.title!.translate(to: AppData().language!.languageCode);
    var translator=await widget.postDetail!.description!.translate(to: AppData().language!.languageCode);
    if(mounted){
      widget.postDetail!.title=translation.text;
      widget.postDetail!.description=translator.text;
      setState(() {});
    }
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
      showCustomSnackBar(response['data'],isError: false);
    }
    else{
      Navigator.pop(context);
      setState(() {

      });
      showCustomSnackBar(response['message']);

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
      showCustomSnackBar(response['data'],isError: false);
    }
    else{
      Navigator.pop(context);
      setState(() {

      });
      showCustomSnackBar(response['message']);

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
      showCustomSnackBar(response['data'],isError: false);
    }
    else{
      Navigator.pop(context);
      setState(() {

      });
      showCustomSnackBar(response['message']);

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
      showCustomSnackBar(response['data'],isError: false);
    }
    else{
      Navigator.pop(context);
      setState(() {

      });
      showCustomSnackBar(response['message']);

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
      showCustomSnackBar(response['data'],isError: false);
    }
    else{
      Navigator.pop(context);
      setState(() {

      });
      showCustomSnackBar(response['message']);

    }
  }
  Future<void> viewPost() async {
    //openLoadingDialog(context, "Loading");
    var response;

    response = await DioService.post('view_post', {
      "usersId" : AppData().userdetail!.usersId,
      "newsPostId" : widget.postDetail!.newsPostId
    });
    if(response['status']=='success'){
      //Navigator.pop(context);
      setState(() {

      });
      showCustomSnackBar(response['data'],isError: false);
    }
    else{
      //Navigator.pop(context);
      setState(() {

      });
      showCustomSnackBar(response['message']);

    }
  }
}
