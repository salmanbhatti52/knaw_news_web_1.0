
import 'package:flutter_svg/flutter_svg.dart';
import 'package:knaw_news/mixin/auth_mixin.dart';
import 'package:knaw_news/mixin/data.dart';
import 'package:knaw_news/util/dimensions.dart';
import 'package:knaw_news/util/images.dart';
import 'package:knaw_news/util/styles.dart';
import 'package:knaw_news/view/base/custom_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:knaw_news/view/screens/about/about.dart';
import 'package:knaw_news/view/screens/auth/sign_in_screen.dart';
import 'package:knaw_news/view/screens/auth/social_login.dart';
import 'package:knaw_news/view/screens/auth/web/web_sign_in.dart';
import 'package:knaw_news/view/screens/dashboard/dashboard_screen.dart';
import 'package:knaw_news/view/screens/inbox/inbox.dart';
import 'package:knaw_news/view/screens/inbox/web_inbox.dart';
import 'package:knaw_news/view/screens/profile/profile_screen.dart';
import 'package:knaw_news/view/screens/profile/web/web_profile.dart';
import 'package:knaw_news/view/screens/setting/web/profile_setting.dart';
import 'package:knaw_news/view/screens/web/widget/web_sidebar_item.dart';
import 'package:url_launcher/url_launcher.dart';


class WebSideBar extends StatelessWidget {

  bool isLogin;

  WebSideBar({this.isLogin=false,});

  @override
  Widget build(BuildContext context) {
    bool isLanguage=AppData().isLanguage;
    double width=MediaQuery.of(context).size.width;

    return Scrollbar(
      interactive: true,
      child: Column(
        children: [
          WebSideBarItem(icon: Images.home, title: isLanguage?AppData().language!.home:"Home", onTap: (){}),
          WebSideBarItem(icon: Images.user, title: isLanguage?AppData().language!.profile:"Profile", onTap: () =>isLogin?Get.toNamed("/WebProfile"):Get.toNamed("/WebSignIn")),
          WebSideBarItem(icon: Images.inbox, title: isLanguage?AppData().language!.inbox:"Inbox", onTap: () =>isLogin?Get.toNamed("/WebInbox"):Get.toNamed("/WebSignIn")),
          WebSideBarItem(icon: Images.setting, title: isLanguage?AppData().language!.setting:"Setting", onTap: () =>isLogin?Get.toNamed("/ProfileSetting"):Get.toNamed("/WebSignIn")),
          if(isLogin)WebSideBarItem(icon: Images.bookmark, title: isLanguage?AppData().language!.bookmarkPosts:"Bookmark Posts", onTap: () => Get.toNamed("/WebProfile",arguments: 1.toString())),
          if(isLogin)WebSideBarItem(icon: Images.mynews, title: isLanguage?AppData().language!.myKnawNews:"My KnawNews", onTap: () => Get.toNamed("/WebProfile")),
        ],
      ),
    );
  }
}

