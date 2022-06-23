import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:flutter_svg/flutter_svg.dart';
import 'package:knaw_news/mixin/data.dart';
import 'package:knaw_news/services/dio_service.dart';
import 'package:knaw_news/util/dimensions.dart';
import 'package:knaw_news/util/images.dart';
import 'package:knaw_news/util/styles.dart';
import 'package:knaw_news/view/base/custom_button.dart';
import 'package:knaw_news/view/base/custom_image.dart';
import 'package:knaw_news/view/base/custom_snackbar.dart';
import 'package:knaw_news/view/base/custom_text_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:knaw_news/view/base/loading_dialog.dart';
import 'package:knaw_news/view/screens/auth/sign_up_screen.dart';
import 'package:knaw_news/view/screens/auth/social_login.dart';
import 'package:knaw_news/view/screens/forget/verification_screen.dart';

class ForgetPassScreen extends StatefulWidget {
  @override
  State<ForgetPassScreen> createState() => _ForgetPassScreenState();
}

class _ForgetPassScreenState extends State<ForgetPassScreen> {
  final TextEditingController _emailController = TextEditingController();

//   String _countryDialCode;


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Color(0xFFF8F8FA),
        leading: GestureDetector(child: Image.asset(Images.back, width: 50,),onTap: () => Get.back(),),
        title: SvgPicture.asset(Images.logo_name,width: 100,),
        centerTitle: true,

      ),
      //backgroundColor:Get.isDarkMode ? Colors.black : Colors.white,
      body: SafeArea(child: Center(
        child: Scrollbar(
          child: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            padding: const EdgeInsets.all(Dimensions.PADDING_SIZE_SMALL),
            child: Center(
              child: Container(
                child: Column(
                    children: [

                      const SizedBox(height: Dimensions.PADDING_SIZE_EXTRA_LARGE),

                      Container(
                        padding: EdgeInsets.only(left: MediaQuery.of(context).size.width*0.07),
                        alignment: Alignment.centerLeft,
                        child: Text('${AppData().language!.forgot} \n${AppData().language!.password}?', style: openSansExtraBold.copyWith(fontSize: 25)),
                      ),


                      SizedBox(height: 25),

                      Container(
                        padding: EdgeInsets.only(left: MediaQuery.of(context).size.width*0.07,right: MediaQuery.of(context).size.width*0.3),
                        alignment: Alignment.centerLeft,
                        child: Text(
                          AppData().language!.enterEmailToResetPass,
                          maxLines: 2,
                          style: openSansRegular.copyWith(color: textColor,fontSize: Dimensions.fontSizeDefault,),
                        ),
                      ),
                      SizedBox(height: MediaQuery.of(context).size.height*0.1,),

                      Container(
                        width: MediaQuery.of(context).size.width*0.8,
                        child: Column(children: [

                          TextField(
                            controller: _emailController,
                            style: openSansRegular.copyWith(fontSize: Dimensions.fontSizeSmall,color: textColor),
                            keyboardType: TextInputType.emailAddress,
                            cursorColor: Theme.of(context).primaryColor,
                            autofocus: false,
                            decoration: InputDecoration(
                              focusColor: const Color(0XF7F7F7),
                              hoverColor: const Color(0XF7F7F7),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(Dimensions.RADIUS_SMALL),
                                borderSide: const BorderSide(style: BorderStyle.none, width: 0),
                              ),
                              isDense: true,
                              hintText: AppData().language!.email,
                              fillColor: Color(0XBBF0F0F0),
                              hintStyle: openSansRegular.copyWith(fontSize: Dimensions.fontSizeSmall),
                              filled: true,

                              prefixIcon: Padding(
                                padding: EdgeInsets.all(Dimensions.PADDING_SIZE_DEFAULT),
                                child: SvgPicture.asset(Images.email, height: 5, width: 5,color: Colors.black),
                              ),
                            ),
                          ),
                        ]),
                      ),
                      SizedBox(height: MediaQuery.of(context).size.height*0.13,),

                      Container(
                        height: 45,
                        width: MediaQuery.of(context).size.width*0.7,
                        child: TextButton(
                          onPressed: () => _forgetPass(),
                          style: flatButtonStyle,
                          child: Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                            Text(AppData().language!.send, textAlign: TextAlign.center, style: openSansBold.copyWith(
                              color: textBtnColor,
                              fontSize: Dimensions.fontSizeDefault,
                            )),
                          ]),
                        ),
                      ),


                      SizedBox(height: MediaQuery.of(context).size.height*0.2,)

                    ]),
              ),
            ),
          ),
        ),
      ),),
    );
  }

  void _forgetPass() async {

    String _email = _emailController.text.trim();
    if (_email.isEmpty) {
      showCustomSnackBar('Enter Email');
    }
    else {
      openLoadingDialog(context, "Loading");
      var response;
      response = await DioService.post('forgot_password', {
          "requestType":"forgot_password",
          "email":_email,
      });
      if(response['status']=='Success'){
        Navigator.pop(context);
        showCustomSnackBar(response['message'],isError: false);
        Get.to(() => VerificationScreen(email: _email,));
      }
      else{
        Navigator.pop(context);
        print(response['message']);
        showCustomSnackBar(response['message']);

      }

    }


  }
}
