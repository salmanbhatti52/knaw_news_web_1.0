
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
import 'package:knaw_news/view/screens/about/web_about.dart';
import 'package:knaw_news/view/screens/auth/sign_in_screen.dart';
import 'package:knaw_news/view/screens/auth/social_login.dart';
import 'package:knaw_news/view/screens/contact_us/contact_us.dart';
import 'package:knaw_news/view/screens/dashboard/dashboard_screen.dart';
import 'package:knaw_news/view/screens/inbox/inbox.dart';
import 'package:knaw_news/view/screens/profile/profile_screen.dart';
import 'package:knaw_news/view/screens/web/widget/web_sidebar_item.dart';
import 'package:url_launcher/url_launcher.dart';


class Help extends StatelessWidget {

  bool isLogout;
  bool isLanguage=AppData().isLanguage;

  Help({this.isLogout=false,});

  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: 10,
      children: [
        //Get.to(WebAbout()),
        HelpItem(text: isLanguage?AppData().language!.about:"About",onTap: () => Get.toNamed("/WebAbout"),),
        //Get.to(ContactUs()),
        HelpItem(text: isLanguage?AppData().language!.contactUs:"Contact us",onTap: () => Get.toNamed("/ContactUs"),),
        HelpItem(text: isLanguage?AppData().language!.copyright:"Copyright",onTap: (){},),
        HelpItem(text: isLanguage?AppData().language!.privacyPolicy:"Privacy Policy",onTap: (){},),
        HelpItem(text: isLanguage?AppData().language!.termsConditions:"Terms & Conditions",onTap: (){},),
        HelpItem(text: isLanguage?AppData().language!.howKnawNewsWorks:"How Knawnews Works",onTap: (){},),
      ],
    );
  }
}
class HelpItem extends StatelessWidget {
  String text;
  void Function()? onTap;
  HelpItem({Key? key,this.text="",this.onTap}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return  InkWell(
      onTap: onTap,
        child: Text(text,style: openSansSemiBold.copyWith(color: textColor,fontSize: Dimensions.fontSizeSmall),)
    );
  }
}


