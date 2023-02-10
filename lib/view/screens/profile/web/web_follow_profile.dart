import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/src/extension_navigation.dart';
import 'package:knaw_news/mixin/data.dart';
import 'package:knaw_news/model/signup_model.dart';
import 'package:knaw_news/services/dio_service.dart';
import 'package:knaw_news/util/app_constants.dart';
import 'package:knaw_news/util/dimensions.dart';
import 'package:knaw_news/util/images.dart';
import 'package:knaw_news/util/styles.dart';
import 'package:knaw_news/view/base/custom_image.dart';
import 'package:knaw_news/view/base/custom_snackbar.dart';
import 'package:knaw_news/view/base/loading_dialog.dart';
import 'package:knaw_news/view/base/web_menu_bar.dart';
import 'package:knaw_news/view/screens/dashboard/widget/bottom_nav_item.dart';
import 'package:knaw_news/view/screens/home/home.dart';
import 'package:knaw_news/view/screens/menu/app_bar.dart';
import 'package:knaw_news/view/screens/menu/drawer.dart';
import 'package:knaw_news/view/screens/post/create_post_screen.dart';
import 'package:knaw_news/view/screens/profile/profile_screen.dart';
import 'package:knaw_news/view/screens/profile/show_post.dart';
import 'package:knaw_news/view/screens/profile/stats.dart';
import 'package:knaw_news/view/screens/profile/web/web_profile.dart';
import 'package:knaw_news/view/screens/profile/web/web_stats.dart';
import 'package:knaw_news/view/screens/search/search_screen.dart';
import 'package:knaw_news/view/screens/setting/setting.dart';

class WebFollowProfile extends StatefulWidget {
  int? userId;
  WebFollowProfile({Key? key,this.userId}) : super(key: key);

  @override
  _WebFollowProfileState createState() => _WebFollowProfileState();
}

class _WebFollowProfileState extends State<WebFollowProfile> with TickerProviderStateMixin {
  UserDetail userDetail =UserDetail();
  late TabController _tabController;
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, initialIndex: 0, vsync: this);

    WidgetsBinding.instance!.addPostFrameCallback((timeStamp) {
      getProfileDetail();
    });
  }
  @override
  Widget build(BuildContext context) {
    Size size=MediaQuery.of(context).size;
    double mediaWidth=size.width;
    mediaWidth/=2;
    return Scaffold(
      appBar: WebMenuBar(context: context,isSearch: false,isAuthenticated: true,isHalf: true,),
      body: SingleChildScrollView(
        physics: BouncingScrollPhysics(),
        child: Container(
          height: MediaQuery.of(context).size.height*1.2,
          child: Column(
            children: [
              Container(
                width: mediaWidth,
                color: Colors.white,
                alignment: Alignment.topCenter,
                child: Container(
                  width: mediaWidth*0.7,
                  margin: EdgeInsets.only(top: 20),
                  child: Column(
                    children: [
                      Row(
                        children: [
                          Container(
                            decoration: BoxDecoration(
                                border: Border.all(
                                  color: Colors.amber,
                                  width: 2,
                                ),
                                shape: BoxShape.circle
                            ),

                            child: Stack(
                              children: [
                                ClipOval(
                                  child: userDetail.profilePicture == null || userDetail.profilePicture == "" ?CustomImage(
                                    image: Images.placeholder,
                                    height: 120,
                                    width: 120,
                                    fit: BoxFit.cover,
                                  ):Image.network(
                                    userDetail.profilePicture!,
                                    width: 120,height: 120,fit: BoxFit.cover,
                                  ),
                                ),
                                userDetail.userVerified==null?SizedBox():userDetail.userVerified?Positioned(
                                  bottom: 5, right: 5,
                                  child: SvgPicture.asset(Images.badge,),
                                ):SizedBox(),
                              ],
                            ),

                          ),
                          SizedBox(width: 20,),
                          Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(userDetail.userName??"Name",style: openSansBold.copyWith(color:Colors.black,fontSize: Dimensions.fontSizeSmall),),

                              Text("${AppData().language!.joined} "+userDetail.joinedSince.toString(),style: openSansRegular.copyWith(color:textColor,fontSize: Dimensions.fontSizeExtraSmall),),

                              Row(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.symmetric(vertical: 15.0),
                                    child: SvgPicture.asset(Images.followers,color: Colors.black,),
                                  ),
                                  SizedBox(width: 5,),
                                  Text(AppData().language!.followers,style: openSansRegular.copyWith(color:Colors.black,fontSize: Dimensions.fontSizeExtraSmall),),
                                  SizedBox(width: 5,),
                                  Text(userDetail.totalFollowers.toString(),style: openSansRegular.copyWith(color:Colors.black,fontSize: Dimensions.fontSizeExtraSmall),),
                                ],
                              ),
                              Row(
                                children: [
                                  InkWell(
                                    onTap: followUser,
                                    child: Container(
                                      height: 30,
                                      width: 100,
                                      decoration: BoxDecoration(
                                          borderRadius: BorderRadius.circular(5),
                                          color: userDetail.isFollowed?Colors.amber:Colors.black
                                      ),
                                      child: Row(
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        children: [
                                          Padding(
                                            padding: const EdgeInsets.symmetric(vertical: 8.0),
                                            child: SvgPicture.asset(Images.user,color: Colors.white,),
                                          ),
                                          Text(userDetail.isFollowed?AppData().language!.unfollow:AppData().language!.follow,style: openSansRegular.copyWith(color:Colors.white,fontSize: Dimensions.fontSizeSmall),)

                                        ],),
                                    ),
                                  ),
                                  SizedBox(width: 20,),
                                  InkWell(
                                    onTap: userDetail.isMuted?unMuteMember:muteMember,
                                    child: Container(
                                      height: 30,
                                      width: 80,
                                      decoration: BoxDecoration(
                                          borderRadius: BorderRadius.circular(5),
                                          color: Colors.red
                                      ),
                                      child: Center(child: Text(userDetail.isMuted?AppData().language!.unmute:AppData().language!.mute,style: openSansRegular.copyWith(color:Colors.white,fontSize: Dimensions.fontSizeSmall),))

                                    ),
                                  ),
                                ],
                              ),

                            ],
                          ),

                        ],
                      ),
                      Container(
                          alignment: Alignment.topLeft,
                          padding: EdgeInsets.symmetric(vertical: 10),
                          child: Text(userDetail.description??'',style: openSansRegular.copyWith(color:Colors.black,fontSize: Dimensions.fontSizeExtraSmall),)
                      ),
                    ],
                  ),
                ),
              ),
              // Container(
              //
              //   child: Text("Profile",style: openSansExtraBold.copyWith(fontSize: 30),),
              // ),

              Container(
                //padding: EdgeInsets.all(2),
                margin: EdgeInsets.only(top: 10),

                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  color: Colors.white,
                ),
                child: Container(
                  height: 35,
                  padding: EdgeInsets.all(3),
                  width: mediaWidth<500?mediaWidth:mediaWidth*0.7,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: Colors.white,
                  ),
                  child: TabBar(
                    labelPadding: EdgeInsets.all(2),
                    controller: _tabController,
                    indicator: BoxDecoration(
                      color: Theme.of(context).primaryColor,
                      borderRadius: BorderRadiusDirectional.circular(20),
                    ),
                    indicatorColor:Theme.of(context).primaryColor,
                    indicatorWeight: 3,
                    labelColor:Colors.black,
                    unselectedLabelColor:Colors.black,
                    unselectedLabelStyle: openSansBold.copyWith(color: Theme.of(context).disabledColor, fontSize: Dimensions.fontSizeSmall),
                    labelStyle: openSansBold.copyWith(fontSize: Dimensions.fontSizeSmall, color: Theme.of(context).primaryColor),
                    tabs: [
                      Tab(text: AppData().language!.posts),
                      Tab(text: AppData().language!.stats),
                    ],
                  ),
                ),
              ),

              widget.userId==AppData().userdetail!.usersId?const SizedBox():
              Expanded(
                child: TabBarView(
                  controller: _tabController,
                  children: [
                    ShowPost(userId: widget.userId,),
                    WebStats(userId: widget.userId),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
  Future<void> getProfileDetail() async {
      var response;
      openLoadingDialog(context, "Loading");
      response = await DioService.post('get_other_profile_details', {
        "usersId" : AppData().userdetail!.usersId,
        "otherUserId" : widget.userId
      });
      if(response['status']=='success'){
        var jsonData= response['data'];
        userDetail  =  UserDetail.fromJson(jsonData);
        print(userDetail.toJson());
        Get.back();
        if(widget.userId==AppData().userdetail!.usersId){
          Get.to(() => WebProfile());
          return;
        }
        setState(() {});
        // showCustomSnackBar(response['status'],isError: false);
      }
      else{
        Get.back();
        if(widget.userId==AppData().userdetail!.usersId){
          Get.to(() => WebProfile());
          return;
        }
        setState(() {

        });
        // showCustomSnackBar(response['status']);
      }
    }
  Future<void> followUser() async {
    openLoadingDialog(context, "Loading");
    var response;
    response = await DioService.post('follow_user', {
      "followingToUser" : userDetail.usersId,
      "followedByUser" : AppData().userdetail!.usersId
    });
    if(response['status']=='success'){
      //print(postDetail![0].toJson());
      Navigator.pop(context);
      userDetail.isFollowed=!userDetail.isFollowed;
      setState(() {

      });
      // showCustomSnackBar(response['data'],isError: false);
      //print(followDetail[2].toJson());
    }
    else{
      Navigator.pop(context);
      // showCustomSnackBar(response['message']);

    }
  }
  void muteMember() async{
    openLoadingDialog(context, "Loading");
    var response;
    response = await DioService.post('mute_member', {
      "muteUsersId": userDetail.usersId,
      "usersId": AppData().userdetail!.usersId
    });
    if(response['status']=='success'){
      userDetail.isMuted=true;
      setState(() {

      });
      Navigator.pop(context);
      // showCustomSnackBar(response['data'],isError: false);
    }
    else{
      setState(() {

      });
      Navigator.pop(context);
      // showCustomSnackBar(response['message']);
    }

  }
  void unMuteMember() async{
    openLoadingDialog(context, "Loading");
    var response;
    response = await DioService.post('unmute_member', {
      "muteUsersId": userDetail.usersId,
      "usersId": AppData().userdetail!.usersId
    });
    if(response['status']=='success'){
      userDetail.isMuted=false;
      setState(() {

      });
      Navigator.pop(context);
      // showCustomSnackBar(response['data'],isError: false);
    }
    else{
      setState(() {

      });
      Navigator.pop(context);
      // showCustomSnackBar(response['message']);
    }

  }

}
