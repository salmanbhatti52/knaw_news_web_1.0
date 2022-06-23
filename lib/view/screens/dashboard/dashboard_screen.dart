import 'dart:async';
import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/src/extension_navigation.dart';
import 'package:get/get_utils/src/extensions/internacionalization.dart';
import 'package:knaw_news/util/dimensions.dart';
import 'package:knaw_news/util/images.dart';
import 'package:knaw_news/util/styles.dart';
import 'package:knaw_news/view/base/custom_button.dart';
import 'package:knaw_news/view/screens/auth/social_login.dart';
import 'package:knaw_news/view/screens/dashboard/widget/bottom_nav_item.dart';
import 'package:knaw_news/view/screens/home/home.dart';
import 'package:knaw_news/view/screens/post/create_post_screen.dart';
import 'package:knaw_news/view/screens/profile/profile_screen.dart';
import 'package:knaw_news/view/screens/search/search_screen.dart';

class DashboardScreen extends StatefulWidget {
  int pageIndex;
  int tabindex;
  DashboardScreen({required this.pageIndex,this.tabindex=0});

  @override
  _DashboardScreenState createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  late PageController _pageController;
  int _pageIndex = 0;
  late List<Widget> _screens;
  GlobalKey<ScaffoldMessengerState> _scaffoldKey = GlobalKey();
  bool _canExit = false;

  @override
  void initState() {
    super.initState();

    _pageIndex = widget.pageIndex;

    _pageController = PageController(initialPage: widget.pageIndex);

    _screens = [
      HomeScreen(),
      SearchScreen(),
      PostScreen(),
      ProfileScreen(),

      // CartScreen(fromNav: true),
      // OrderScreen(),
      //Container(),
    ];

    Future.delayed(Duration(seconds: 1), () {
      setState(() {});
    });

    /*if(GetPlatform.isMobile) {
      NetworkInfo.checkConnectivity(_scaffoldKey.currentContext);
    }*/
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        if (_pageIndex != 0) {
          _setPage(0);
          return false;
        } else {
          if(_canExit) {
            return true;
          }else {
            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
              content: Text('Click again to exit', style: TextStyle(color: Colors.white)),
              behavior: SnackBarBehavior.floating,
              backgroundColor: Colors.green,
              duration: Duration(seconds: 2),
              margin: EdgeInsets.all(Dimensions.PADDING_SIZE_SMALL),
            ));
            _canExit = true;
            Timer(Duration(seconds: 2), () {
              _canExit = false;
            });
            return false;
          }
        }
      },
      child: Scaffold(
        key: _scaffoldKey,

        // bottomNavigationBar: ClipRRect(
        //   borderRadius: BorderRadius.vertical(top: Radius.circular(10)),
        //   child: BottomAppBar(
        //     //elevation: 0.0,
        //     //notchMargin: 2,
        //     //clipBehavior: Clip.antiAlias,
        //     //shape: CircularNotchedRectangle(),
        //     child: Padding(
        //       padding: EdgeInsets.all(0),
        //       child: Row(
        //           mainAxisAlignment: MainAxisAlignment.center,
        //           crossAxisAlignment: CrossAxisAlignment.center,
        //           children: [
        //             BottomNavItem(iconData: Images.home,isSelected: _pageIndex==0, onTap: () => Get.to(HomeScreen())),
        //             BottomNavItem(iconData: Images.search, isSelected: _pageIndex == 1, onTap: () => Get.to(SearchScreen())),
        //             BottomNavItem(iconData: Images.add,isSelected: _pageIndex==2, onTap: () => Get.to(PostScreen())),
        //             BottomNavItem(iconData: Images.user,isSelected: _pageIndex==3, onTap: () => Get.to(ProfileScreen())),
        //             // BottomNavItem(title:'home'.tr,iconData: Images.home, isSelected: _pageIndex == 0, onTap: () => _setPage(0)),
        //             // BottomNavItem(title:'favourite'.tr,iconData: Images.favorite, isSelected: _pageIndex == 1, onTap: () => _setPage(1)),
        //             // Expanded(child: SizedBox()),
        //             // BottomNavItem(title:'my_order'.tr,iconData: Images.bag, isSelected: _pageIndex == 3, onTap: () => _setPage(3)),
        //             // BottomNavItem(title:'notification'.tr,iconData: Images.notification, isSelected: _pageIndex == 4, onTap: () {
        //             //   Get.toNamed(RouteHelper.getNotificationRoute());
        //             // }),
        //           ]),
        //     ),
        //   ),
        // ),
        body: PageView.builder(
          controller: _pageController,
          itemCount: _screens.length,
          physics: NeverScrollableScrollPhysics(),
          itemBuilder: (context, index) {
            return _screens[index];
          },
        ),
      ),
    );
  }

  void _setPage(int pageIndex) {
    setState(() {
      _pageController.jumpToPage(pageIndex);
      _pageIndex = pageIndex;
    });
  }
}
