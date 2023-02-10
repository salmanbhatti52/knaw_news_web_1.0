import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/src/extension_navigation.dart';
import 'package:knaw_news/mixin/data.dart';
import 'package:knaw_news/model/post_model.dart';
import 'package:knaw_news/services/dio_service.dart';
import 'package:knaw_news/util/dimensions.dart';
import 'package:knaw_news/util/styles.dart';
import 'package:knaw_news/view/base/custom_snackbar.dart';
import 'package:knaw_news/view/base/loading_dialog.dart';
import 'package:knaw_news/view/base/no_data_screen.dart';
import 'package:knaw_news/view/screens/home/widget/full_transition.dart';
import 'package:knaw_news/view/screens/home/widget/small_transition.dart';

class ShowPost extends StatefulWidget {
  int? userId;
  ShowPost({this.userId});

  @override
  State<ShowPost> createState() => _ShowPostState();
}

class _ShowPostState extends State<ShowPost> {
  int selected=0;
  bool isExtend=false;
  int? extendedIndex;
  int totalPost=-1;
  bool isLoading=true;
  List<PostDetail>? postDetail;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    if (mounted) {
      WidgetsBinding.instance!.addPostFrameCallback((timeStamp) {
        widget.userId==AppData().userdetail!.usersId?loadMyPosts():loadOtherPosts();
      });
    }

  }
  @override
  Widget build(BuildContext context) {
    Size size=MediaQuery.of(context).size;
    double mediaWidth=size.width;
    mediaWidth/=2;
    return SingleChildScrollView(
      physics: const BouncingScrollPhysics(),
      padding: EdgeInsets.all(Dimensions.PADDING_SIZE_SMALL),
      child: Center(
        child: totalPost>0?Container(
          width: GetPlatform.isDesktop?mediaWidth:MediaQuery.of(context).size.width*0.9,
          child: ListView.builder(
              physics: NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              //padding: EdgeInsetsGeometry.infinity,
              itemCount: postDetail!.length,
              itemBuilder: (context,index){
                return FullTransition(postDetail: postDetail![index],);
              }
          ),
        ):Center(child:  isLoading?Center(child: CircularProgressIndicator(color: Colors.amber,),):NoDataScreen()),
      ),
    );
  }
  Future<void> loadMyPosts() async {
    print("loadMyPosts()");
    //openLoadingDialog(context, "Loading");
    var response;
    response = await DioService.post('get_my_posts', {
      "usersId" : widget.userId
    });
    if(response['status']=='success'){
      var jsonData= response['data'] as List;
      postDetail=  jsonData.map<PostDetail>((e) => PostDetail.fromJson(e)).toList();
      print(postDetail![0].isViewed);
      print(postDetail![0].userVerified);
      //Navigator.pop(context);
      isLoading=false;
      if(mounted){
        setState(() {

        });
      }
      totalPost=postDetail!.length;
      print(totalPost.toString());
    }
    else{
      //Navigator.pop(context);
      isLoading=false;
     if(mounted){
       setState(() {

       });
     }
      // showCustomSnackBar(response['message']);
      totalPost=0;
      print(totalPost.toString());

    }
  }
  Future<void> loadOtherPosts() async {
    print("loadOtherPosts()");
    //openLoadingDialog(context, "Loading");
    var response;
    response = await DioService.post('get_other_user_posts', {
      "usersId" : AppData().userdetail!.usersId,
      "otherUserId" : widget.userId
    });
    if(response['status']=='success'){
      var jsonData= response['data'] as List;
      postDetail=  jsonData.map<PostDetail>((e) => PostDetail.fromJson(e)).toList();
      print(postDetail![0].userVerified);
      //Get.back();
      isLoading=false;
      if (mounted) {
        setState(() {});
      }
      totalPost=postDetail!.length;
      print(totalPost.toString());
    }
    else{
      isLoading=false;
      setState(() {});
      // showCustomSnackBar(response['message']);
      totalPost=0;
      print(totalPost.toString());

    }
  }
  Future<void> viewPost() async {
    //openLoadingDialog(context, "Loading");
    var response;
    response = await DioService.post('view_post', {
      "usersId" : AppData().userdetail!.usersId,
      "newsPostId" : postDetail![extendedIndex!].newsPostId
    });
    if(response['status']=='success'){
      postDetail![extendedIndex!].isViewed=true;
      //Navigator.pop(context);
      setState(() {

      });
      // showCustomSnackBar(response['data']);
    }
    else{
      //Navigator.pop(context);
      setState(() {

      });
      // showCustomSnackBar(response['message']);

    }
  }
}
