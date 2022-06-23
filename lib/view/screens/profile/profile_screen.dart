import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
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
import 'package:knaw_news/view/screens/dashboard/dashboard_screen.dart';
import 'package:knaw_news/view/screens/dashboard/widget/bottom_nav_item.dart';
import 'package:knaw_news/view/screens/menu/app_bar.dart';
import 'package:knaw_news/view/screens/menu/drawer.dart';
import 'package:knaw_news/view/screens/profile/bookmarks.dart';
import 'package:knaw_news/view/screens/profile/show_post.dart';
import 'package:knaw_news/view/screens/profile/stats.dart';
import 'package:knaw_news/view/screens/setting/setting.dart';

class ProfileScreen extends StatefulWidget {
  int index;
  ProfileScreen({this.index=0});

  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> with TickerProviderStateMixin {
  UserDetail userDetail =UserDetail();
  late TabController _tabController;


  void initState() {
    super.initState();
      _tabController = TabController(length: 3, initialIndex: widget.index, vsync: this);

    print(AppData().userdetail!.toJson());
    WidgetsBinding.instance!.addPostFrameCallback((timeStamp) {
      getProfileDetail();
    });


  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: new MyDrawer(),
      appBar: new CustomAppBar(leading: Images.menu,title: AppData().language!.profile,suffix: Images.setting,isTitle: true,isSuffix: true,suffixTap: () => Get.to(() => SettingScreen()),),
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
                  BottomNavItem(iconData: Images.home,isSelected: false, onTap: () => Get.to(DashboardScreen(pageIndex: 0))),
                  BottomNavItem(iconData: Images.search, isSelected: false , onTap: () => Get.to(DashboardScreen(pageIndex: 1))),
                  BottomNavItem(iconData: Images.add,isSelected: false, onTap: () => Get.to(DashboardScreen(pageIndex: 2))),
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
                dragStartBehavior: DragStartBehavior.down,
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
                  Tab(text: AppData().language!.bookmarks),
                  Tab(text: AppData().language!.stats),
                ],
              ),
            ),
          ),

          Expanded(
            child: TabBarView(
              controller: _tabController,
              children: [
                ShowPost(userId: AppData().userdetail!.usersId),
                Bookmarks(userId: AppData().userdetail!.usersId,),
                StatsScreen(userId: AppData().userdetail!.usersId,),
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
    response = await DioService.post('get_loggedin_profile_details', {
      "usersId" : AppData().userdetail!.usersId
    });
    if(response['status']=='success'){
      var jsonData= response['data'];
      userDetail  =  UserDetail.fromJson(jsonData);
      print(userDetail.toJson());
      print(userDetail.userVerified);

      Navigator.pop(context);
      setState(() {});
      // showCustomSnackBar(response['status'],isError: false);
    }
    else{
      Navigator.pop(context);
      setState(() {

      });
      showCustomSnackBar(response['message']);

    }
  }

}

