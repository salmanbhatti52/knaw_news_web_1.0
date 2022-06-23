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
import 'package:knaw_news/view/screens/dashboard/widget/bottom_nav_item.dart';
import 'package:knaw_news/view/screens/home/home.dart';
import 'package:knaw_news/view/screens/menu/app_bar.dart';
import 'package:knaw_news/view/screens/menu/drawer.dart';
import 'package:knaw_news/view/screens/post/create_post_screen.dart';
import 'package:knaw_news/view/screens/profile/profile_screen.dart';
import 'package:knaw_news/view/screens/profile/show_post.dart';
import 'package:knaw_news/view/screens/profile/stats.dart';
import 'package:knaw_news/view/screens/search/search_screen.dart';
import 'package:knaw_news/view/screens/setting/setting.dart';

class FollowProfile extends StatefulWidget {
  int? userId;
  FollowProfile({Key? key,this.userId}) : super(key: key);

  @override
  _FollowProfileState createState() => _FollowProfileState();
}

class _FollowProfileState extends State<FollowProfile> with TickerProviderStateMixin {
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
    return Scaffold(
      drawer: new MyDrawer(),
      appBar: AppBar(
        systemOverlayStyle: SystemUiOverlayStyle(
            statusBarBrightness: Brightness.dark,
            statusBarColor: Colors.white
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(
            bottom: Radius.circular(10.0),
          ),
        ),
        elevation: 0,
        leading: GestureDetector(
          onTap: (){
            Scaffold.of(context).openDrawer();
          },
          child: Builder(
            builder: (context) => IconButton(
              icon: Padding(
                padding: const EdgeInsets.all(5.0),
                child: SvgPicture.asset(Images.menu, width: 20,color: Colors.black,),
              ),
              onPressed: () => Scaffold.of(context).openDrawer(),
            ),
          ),
        ),
        title: Text(AppData().language!.profile,style: openSansExtraBold.copyWith(color: Colors.black),),
        centerTitle: true,
        backgroundColor: Colors.white,
        actions: [
          //Image.asset(Images.filter, width: 20,),
          GestureDetector(
            onTap: userDetail.isMuted?unMuteMember:muteMember,
            child: Container(
              width: 70,
              margin: EdgeInsets.only(top: 15,bottom: 15,right: 15),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(5),
                  color: Colors.red
              ),
              child: Center(child: Text(userDetail.isMuted?AppData().language!.unmute:AppData().language!.mute,style: openSansSemiBold.copyWith(color: Colors.white,fontSize: Dimensions.fontSizeSmall),textAlign: TextAlign.center,)),
            ),
          ),
        ],
        // flexibleSpace: Container(
        //   alignment: Alignment.centerRight,
        //   height: 100,
        //   decoration: BoxDecoration(
        //     color: Colors.red,
        //     borderRadius: BorderRadius.only(bottomLeft: Radius.circular(10),bottomRight: Radius.circular(10)),
        //   ),
        //   child: Row(
        //     mainAxisAlignment: MainAxisAlignment.end,
        //     children: [
        //       Image.asset(Images.filter, width: 20,),
        //     ],
        //   ),
        // ),
      ),
      bottomNavigationBar: ClipRRect(
        borderRadius: BorderRadius.vertical(top: Radius.circular(10)),
        child: BottomAppBar(
          //elevation: 0.0,
          //notchMargin: 2,
          //clipBehavior: Clip.antiAlias,
          //shape: CircularNotchedRectangle(),
          child: Padding(
            padding: EdgeInsets.all(0),
            child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  BottomNavItem(iconData: Images.home,isSelected: false, onTap: () => Get.to(HomeScreen())),
                  BottomNavItem(iconData: Images.search, isSelected: false , onTap: () => Get.to(SearchScreen())),
                  BottomNavItem(iconData: Images.add,isSelected: false, onTap: () => Get.to(PostScreen())),
                  BottomNavItem(iconData: Images.user,isSelected: false, onTap: () => Get.to(ProfileScreen())),
                  // BottomNavItem(title:'home'.tr,iconData: Images.home, isSelected: _pageIndex == 0, onTap: () => _setPage(0)),
                  // BottomNavItem(title:'favourite'.tr,iconData: Images.favorite, isSelected: _pageIndex == 1, onTap: () => _setPage(1)),
                  // Expanded(child: SizedBox()),
                  // BottomNavItem(title:'my_order'.tr,iconData: Images.bag, isSelected: _pageIndex == 3, onTap: () => _setPage(3)),
                  // BottomNavItem(title:'notification'.tr,iconData: Images.notification, isSelected: _pageIndex == 4, onTap: () {
                  //   Get.toNamed(RouteHelper.getNotificationRoute());
                  // }),
                ]),
          ),
        ),
      ),
      body: Container(child: Column(
        children: [
          Container(
            //height: 220,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(bottomLeft: Radius.circular(10),bottomRight: Radius.circular(10)),
            ),
            alignment: Alignment.topCenter,
            child: Column(
              children: [
                Row(
                  children: [
                    Container(
                      margin: EdgeInsets.only(left: MediaQuery.of(context).size.width*0.05),
                      decoration: BoxDecoration(
                          border: Border.all(
                            color: Colors.amber,
                            width: 4,
                          ),
                          shape: BoxShape.circle
                      ),

                      child: Stack(
                        children: [
                          ClipOval(
                            child: userDetail.profilePicture == null || userDetail.profilePicture == "" ?CustomImage(
                              image: Images.placeholder,
                              height: 90,
                              width: 90,
                              fit: BoxFit.cover,
                            ):Image.network(
                              AppConstants.proxyUrl+userDetail.profilePicture!,
                              width: 90,height: 90,fit: BoxFit.cover,
                            ),
                          ),
                          userDetail.userVerified==null?SizedBox():userDetail.userVerified?Positioned(
                            bottom: 2, right: 2,
                            child: SvgPicture.asset(Images.badge,),
                          ):SizedBox(),
                        ],
                      ),

                    ),
                    Container(
                      padding: EdgeInsets.only(left: MediaQuery.of(context).size.width*0.05),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(userDetail.userName??"Name",style: openSansExtraBold.copyWith(color:Colors.black),),

                          Text("${AppData().language!.joined} "+userDetail.joinedSince.toString(),style: openSansRegular.copyWith(color:textColor),),

                          Row(
                            children: [
                              Padding(
                                padding: const EdgeInsets.symmetric(vertical: 10.0),
                                child: SvgPicture.asset(Images.followers,color: Colors.black,),
                              ),
                              SizedBox(width: 5,),
                              Text(AppData().language!.followers,style: openSansRegular.copyWith(color:Colors.black),),
                              SizedBox(width: 5,),
                              Text(userDetail.totalFollowers.toString(),style: openSansRegular.copyWith(color:Colors.black),),
                            ],
                          ),
                          GestureDetector(
                            onTap: followUser,
                            child: Container(
                              height: 30,
                              width: 90,
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
                                Text(userDetail.isFollowed?AppData().language!.unfollow:AppData().language!.follow,style: openSansRegular.copyWith(color:Colors.white),)

                              ],),
                            ),
                          ),

                        ],
                      ),
                    ),

                  ],
                ),
                Container(
                  alignment: Alignment.topLeft,
                    padding: EdgeInsets.symmetric(horizontal: MediaQuery.of(context).size.width*0.05,vertical: 10),
                    child: Text(userDetail.description??'',style: openSansRegular.copyWith(color:Colors.black),)),

              ],
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
              width: MediaQuery.of(context).size.width*0.7,
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
                StatsScreen(userId: widget.userId,),
              ],
            ),
          ),
        ],
      ),),
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
          Get.to(() => ProfileScreen());
          return;
        }
        setState(() {});
        // showCustomSnackBar(response['status'],isError: false);
      }
      else{
        Get.back();
        if(widget.userId==AppData().userdetail!.usersId){
          Get.to(() => ProfileScreen());
          return;
        }
        setState(() {

        });
        showCustomSnackBar(response['status']);
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
      showCustomSnackBar(response['data'],isError: false);
      //print(followDetail[2].toJson());
    }
    else{
      Navigator.pop(context);
      showCustomSnackBar(response['message']);

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
      showCustomSnackBar(response['data'],isError: false);
    }
    else{
      setState(() {

      });
      Navigator.pop(context);
      showCustomSnackBar(response['message']);
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
      showCustomSnackBar(response['data'],isError: false);
    }
    else{
      setState(() {

      });
      Navigator.pop(context);
      showCustomSnackBar(response['message']);
    }

  }

}
