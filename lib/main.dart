import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:get/get.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:knaw_news/api/auth.dart';
import 'package:knaw_news/mixin/data.dart';
import 'package:knaw_news/model/signup_model.dart';
import 'package:knaw_news/theme/light_theme.dart';
import 'package:knaw_news/view/base/scroll_behavior.dart';
import 'package:knaw_news/view/screens/about/web_about.dart';
import 'package:knaw_news/view/screens/auth/auth_screen.dart';
import 'package:knaw_news/view/screens/auth/sign_in_screen.dart';
import 'package:knaw_news/view/screens/auth/web/web_sign_in.dart';
import 'package:knaw_news/view/screens/auth/web/web_sign_up.dart';
import 'package:knaw_news/view/screens/contact_us/contact_us.dart';
import 'package:knaw_news/view/screens/forget/web/web_forget_pass_screen.dart';
import 'package:knaw_news/view/screens/forget/web/web_new_pass_screen.dart';
import 'package:knaw_news/view/screens/forget/web/web_verification_screen.dart';
import 'package:knaw_news/view/screens/home/home.dart';
import 'package:knaw_news/view/screens/home/initial.dart';
import 'package:knaw_news/view/screens/inbox/web_inbox.dart';
import 'package:knaw_news/view/screens/post/create_post_on_web.dart';
import 'package:knaw_news/view/screens/profile/web/web_follow_profile.dart';
import 'package:knaw_news/view/screens/profile/web/web_profile.dart';
import 'package:knaw_news/view/screens/search/web_search.dart';
import 'package:knaw_news/view/screens/setting/web/profile_setting.dart';
import 'package:knaw_news/view/screens/splash/splash_screen.dart';
import 'package:knaw_news/view/screens/web/initial_screen.dart';
import 'package:knaw_news/view/screens/web/web_home.dart';
import 'package:url_strategy/url_strategy.dart';
void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  setPathUrlStrategy();
  FacebookAuth.instance.webInitialize(
    appId: "505079357920717",
    cookie: true,
    xfbml: true,
    version: "v13.0",
  );
  // options: const FirebaseOptions(
  //     apiKey: "AIzaSyAsuyd6kHd8tsnBTM9GGZDWCPcegx857Og",
  //     authDomain: "knawnews-6aad8.firebaseapp.com",
  //     projectId: "knawnews-6aad8",
  //     storageBucket: "knawnews-6aad8.appspot.com",
  //     messagingSenderId: "1039543621874",
  //     appId: "1:1039543621874:web:faf92914f991ce2798186b",
  //     measurementId: "G-CFPZNY24GV"
  // ),
  await Firebase.initializeApp();
  await AppData.initiate();
  AppData().userlocation=UserLocation();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      //theme: light,
      scrollBehavior: MyCustomScrollBehavior().copyWith(scrollbars: false),
      theme: light,
      routes: {
        "/" : (context) => GetPlatform.isDesktop?AppData().isAuthenticated?WebHome():InitialScreen():AppData().isAuthenticated?HomeScreen():Initial(),
        "/WebHome": (context) => WebHome(),
        "/WebProfile": (context) => WebProfile(),
        "/WebSearch": (context) => WebSearch(),
        "/WebFollowProfile": (context) => WebFollowProfile(userId: int.tryParse(Get.parameters['id']??'0'),),
        "/ProfileSetting": (context) => ProfileSetting(),
        "/WebPostScreen": (context) => WebPostScreen(),
        "/WebAbout": (context) => WebAbout(),
        "/ContactUs": (context) => ContactUs(),
        "/WebInbox": (context) => WebInbox(),
        "/ForgetPassword": (context) => ForgetPassword(),
        "/Verification": (context) => Verification(email: "you@gmail.com"),
        "/ResetPassword": (context) => ResetPassword(),
        "/WebSignIn": (context) => WebSignIn(),
        "/WebSignUp": (context) => WebSignUp(),
        "/SignInScreen": (context) => SignInScreen(),
      },
    );
  }
}

