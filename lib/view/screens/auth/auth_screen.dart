import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/src/extension_navigation.dart';
import 'package:get/get_utils/src/extensions/internacionalization.dart';
import 'package:knaw_news/mixin/data.dart';
import 'package:knaw_news/util/dimensions.dart';
import 'package:knaw_news/util/images.dart';
import 'package:knaw_news/util/styles.dart';
import 'package:knaw_news/view/base/custom_button.dart';
import 'package:knaw_news/view/screens/auth/sign_up_screen.dart';
import 'package:knaw_news/view/screens/auth/social_login.dart';
import 'package:flutter_svg/flutter_svg.dart';

class AuthScreen extends StatelessWidget {
  const AuthScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(child: Center(
        child: Scrollbar(
          child: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            padding: EdgeInsets.all(Dimensions.PADDING_SIZE_SMALL),
            child: Center(
              child: Container(

                child: Column(children: [

                  SizedBox(height: 20),
                  Image.asset(Images.logo_with_name, width: 150,),
                  //const SizedBox(height: Dimensions.PADDING_SIZE_EXTRA_LARGE),
                  // Text('Knaw News', style: openSansExtraBold.copyWith(fontSize: 25)),
                  SizedBox(height: 80),
                  const SizedBox(height: Dimensions.PADDING_SIZE_EXTRA_LARGE),


                  SizedBox(height: Dimensions.PADDING_SIZE_LARGE),


                  Container(
                    height: 45,
                      width: MediaQuery.of(context).size.width*0.75,
                      child: TextButton(
                        onPressed: () {if(AppData().isLanguage)Get.to(() => SocialLogin());},
                        style: flatButtonStyle,
                        child: Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                          Text(AppData().language!.signIn.toUpperCase(), textAlign: TextAlign.center, style: openSansBold.copyWith(
                            color: textBtnColor,
                            fontSize: Dimensions.fontSizeDefault,
                          )),
                        ]),
                      ),
                  ),
                  SizedBox(height: 25),
                  TextButton(
                    clipBehavior: Clip.none,
                    style: TextButton.styleFrom(
                      elevation: 0,
                      shadowColor: null,
                      shape: RoundedRectangleBorder(
                        side: BorderSide(width: 2, color: Theme.of(context).primaryColor),
                        borderRadius: BorderRadius.circular(5),
                      ),
                      minimumSize: Size(MediaQuery.of(context).size.width*0.75, 45),
                      maximumSize: Size(MediaQuery.of(context).size.width*0.75, 45),
                      padding: EdgeInsets.zero,
                    ),
                    onPressed: () {
                      if(AppData().isLanguage)Get.to(() => SignUpScreen());

                    },
                    child: Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                      Text(AppData().language!.signUp.toUpperCase(), textAlign: TextAlign.center, style: openSansBold.copyWith(
                        color: Theme.of(context).primaryColor,
                        fontSize: Dimensions.fontSizeDefault,
                      )),
                    ]),
                  ),
                  SizedBox(height: 15),



                ]),
              ),
            ),
          ),
        ),
      ),),
    );
  }
}
