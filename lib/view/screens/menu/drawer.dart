
import 'package:flutter_svg/flutter_svg.dart';
import 'package:knaw_news/mixin/auth_mixin.dart';
import 'package:knaw_news/mixin/data.dart';
import 'package:knaw_news/util/app_constants.dart';
import 'package:knaw_news/util/dimensions.dart';
import 'package:knaw_news/util/images.dart';
import 'package:knaw_news/util/styles.dart';
import 'package:knaw_news/view/base/custom_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:knaw_news/view/screens/about/about.dart';
import 'package:knaw_news/view/screens/auth/sign_in_screen.dart';
import 'package:knaw_news/view/screens/auth/social_login.dart';
import 'package:knaw_news/view/screens/contact_us/contact_us.dart';
import 'package:knaw_news/view/screens/dashboard/dashboard_screen.dart';
import 'package:knaw_news/view/screens/inbox/inbox.dart';
import 'package:knaw_news/view/screens/language/language.dart';
import 'package:knaw_news/view/screens/profile/profile_screen.dart';
import 'package:url_launcher/url_launcher.dart';

class MyDrawer extends StatefulWidget {
  @override
  _MyDrawerState createState() => _MyDrawerState();
}

class _MyDrawerState extends State<MyDrawer> {
  bool _isLoggedIn=false;


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  _launchURL(String _url) async {
    if (!await launch(_url)) throw 'Could not launch $_url';
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Container(
        child: Column(
          children: [

            Container(
              decoration: const BoxDecoration(
                color: Colors.amber,
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(10),
                ),
              ),
              child: Center(
                child: Column(
                  children: [
                    const SizedBox(height: 40),
                    Stack(
                      children: [
                        ClipOval(
                          child: AppData().userdetail!.profilePicture == null || AppData().userdetail!.profilePicture == "" ?CustomImage(
                            image: Images.placeholder,
                            height: 90,
                            width: 90,
                            fit: BoxFit.cover,
                          ):Image.network(
                            AppData().userdetail!.profilePicture!,
                            width: 90,height: 90,fit: BoxFit.cover,
                          ),
                        ),
                        AppData().userdetail!.userVerified?Positioned(
                          bottom: 4, right: 4,
                          child: SvgPicture.asset(Images.badge),
                        ):SizedBox(),
                      ],
                    ),
                    SizedBox(height: 5),
                    Text(
                      AppData().userdetail!.userName??"",
                      style: openSansBold.copyWith(color: Colors.white.withOpacity(0.8)),
                    ),
                    Text(
                      "${AppData().language!.join} "+AppData().userdetail!.dateAdded.toString(),
                      style: openSansRegular.copyWith(color: Colors.white.withOpacity(0.8)),
                    ),
                    SizedBox(height: 10,),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 10,),
            DrawerItems(icon: Images.inbox, title: AppData().language!.inbox, onTap: () => Get.to(InboxScreen())),
            DrawerItems(icon: Images.bookmark, title: AppData().language!.bookmarkPosts, onTap: () => Get.to(ProfileScreen(index: 1,))),
            DrawerItems(icon: Images.mynews, title: AppData().language!.myKnawNews, onTap: () => Get.to(ProfileScreen(index: 0,))),
            DrawerItems(icon: Images.about, title: AppData().language!.about, onTap: () => Get.to(AboutScreen())),
            DrawerItems(icon: Images.contactus, title: AppData().language!.contactUs, onTap: () => Get.to(ContactUs())),
            DrawerItems(icon: Images.language, title: AppData().language!.language, onTap: () => Get.to(LanguageScreen())),
            Expanded(
              child: ListTile(
                //leading: Image.asset(Images.language_icon,width: 25,),
                title: Text("",style: openSansBold,),
                onTap: (){
                  //Get.toNamed(RouteHelper.getLanguageRoute('menu'));
                },
              ),
            ),
            DrawerItems(icon: Images.logout, title: AppData().language!.logout,isLogout: true, onTap: () {AppData().signOut();Get.offAll(() => SocialLogin());}),
            const SizedBox(height: 20,),



          ],
        ),
      ),
    );
  }
}

class DrawerItems extends StatelessWidget {

  String icon;
  String title;
  bool isLogout;
  void Function() onTap;

  DrawerItems({required this.icon,required this.title,this.isLogout=false,required this.onTap});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Padding(
        padding: const EdgeInsets.all(10.0),
        child: SvgPicture.asset(
            icon,
            width: 20,
            color: Colors.black
        ),
      ),
      title: Text(
        title,
        style: openSansExtraBold.copyWith(fontSize:Dimensions.fontSizeDefault,color: Colors.black),
      ),
      trailing: isLogout?SizedBox():Padding(
        padding: const EdgeInsets.symmetric(vertical: 0.0),
        child: SvgPicture.asset(
            Images.arrow_farward,
            width: 7,
            color: Colors.black
        ),
      ),
      onTap: onTap,
    );
  }
}