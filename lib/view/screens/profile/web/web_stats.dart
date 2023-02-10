import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/src/extension_navigation.dart';
import 'package:knaw_news/mixin/data.dart';
import 'package:knaw_news/model/signup_model.dart';
import 'package:knaw_news/services/dio_service.dart';
import 'package:knaw_news/util/dimensions.dart';
import 'package:knaw_news/util/images.dart';
import 'package:knaw_news/view/base/custom_snackbar.dart';
import 'package:knaw_news/view/base/loading_dialog.dart';
import 'package:knaw_news/view/screens/follow/following.dart';
import 'package:knaw_news/view/screens/profile/web/follower_list.dart';
import 'package:knaw_news/view/screens/profile/web/following_list.dart';
import 'package:knaw_news/view/screens/profile/web/web_stats_card.dart';
class WebStats extends StatefulWidget {
  int? userId;
  WebStats({this.userId});

  @override
  State<WebStats> createState() => _WebStatsState();
}

class _WebStatsState extends State<WebStats> {
  UserDetail userDetail =UserDetail();
  bool isLoading=true;
  bool isFollower=false;
  bool isFollowing=false;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    WidgetsBinding.instance!.addPostFrameCallback((timeStamp) {
      getUserStats();
    });

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
        child: Container(
          width: mediaWidth,
          child: isLoading?Center(child: CircularProgressIndicator(color: Colors.amber,),):Column(
            children: [

              WebStatsCard(icon: Images.posts, title: AppData().language!.posts, data: userDetail.totalPostCount.toString()),
              Container(
                color: Theme.of(context).disabledColor.withOpacity(0.5),
                width: mediaWidth,
                height: 1,
              ),
              WebStatsCard(icon: Images.views, title:  AppData().language!.views, data: userDetail.totalViews.toString()),
              Container(
                color: Theme.of(context).disabledColor.withOpacity(0.5),
                width: mediaWidth,
                height: 1,
              ),
              WebStatsCard(icon: Images.comment, title:  AppData().language!.comments, data: userDetail.totalComments.toString()),
              Container(
                color: Theme.of(context).disabledColor.withOpacity(0.5),
                width: mediaWidth,
                height: 1,
              ),
              InkWell(
                onTap: (){
                  isFollower=!isFollower;
                  isFollowing=false;
                  setState(() {});
                },
                  child: WebStatsCard(icon: Images.followers, title:  AppData().language!.followers, data: userDetail.totalFollowers.toString(),)
              ),
              isFollower?FollowerList(userId: widget.userId,):SizedBox(),
              Container(
                color: Theme.of(context).disabledColor.withOpacity(0.5),
                width: mediaWidth,
                height: 1,
              ),
              InkWell(
                onTap: (){
                  isFollowing=!isFollowing;
                  isFollower=false;
                  setState(() {});
                },
                  child: Container(child: WebStatsCard(icon: Images.followers, title:  AppData().language!.following, data: userDetail.totalFollowing.toString(),))
              ),
              isFollowing?FollowingList(userId: widget.userId,):SizedBox(),
            ],
          ),
        ),
      ),
    );
  }
  Future<void> getUserStats() async {
    var response;
    //openLoadingDialog(context, "Loading");
    response = await DioService.post('get_user_stats', {
      "usersId" : widget.userId
    });
    if(response['status']=='success'){
      var jsonData= response['data'];
      userDetail  =  UserDetail.fromJson(jsonData);
      //Get.back();
      isLoading=false;
      if(mounted){
        setState(() {

        });
      }


    }
    else{
      //Get.back();
      isLoading=false;
      if(mounted){
        setState(() {

        });
      }
      // showCustomSnackBar(response['status']);

    }
  }
}
