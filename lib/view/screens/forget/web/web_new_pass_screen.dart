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
import 'package:knaw_news/view/base/web_menu_bar.dart';
import 'package:knaw_news/view/screens/auth/sign_in_screen.dart';
import 'package:knaw_news/view/screens/auth/sign_up_screen.dart';
import 'package:knaw_news/view/screens/auth/social_login.dart';
import 'package:knaw_news/view/screens/auth/web/web_sign_in.dart';
import 'package:knaw_news/view/screens/forget/verification_screen.dart';

class ResetPassword extends StatefulWidget {
  String email;

  ResetPassword({this.email=""});

  @override
  State<ResetPassword> createState() => _ResetPasswordState();
}

class _ResetPasswordState extends State<ResetPassword> {
  final TextEditingController _newPasswordController = TextEditingController();
  final TextEditingController _confirmPasswordController = TextEditingController();
  final TextEditingController _oldPasswordController = TextEditingController();
  final FocusNode _newPasswordFocus = FocusNode();
  final FocusNode _confirmPasswordFocus = FocusNode();
  final FocusNode _oldPasswordFocus = FocusNode();


  @override
  Widget build(BuildContext context) {
    Size size=MediaQuery.of(context).size;
    double mediaWidth=size.width;
    mediaWidth/=2;
    return Scaffold(
      appBar: WebMenuBar(context: context,isAuthScreen: true,isHalf: true,),
      //backgroundColor:Get.isDarkMode ? Colors.black : Colors.white,
      body: SafeArea(child: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        padding: const EdgeInsets.all(Dimensions.PADDING_SIZE_SMALL),
        child: Center(
          child: Container(
            width: mediaWidth,
            child: Column(
                children: [

                  SizedBox(height: mediaWidth*0.08),

                  Container(
                    alignment: Alignment.centerLeft,
                    child: Text('${AppData().language!.forgot} \n${AppData().language!.password}?', style: openSansBold.copyWith(fontSize: Dimensions.fontSizeDefault)),
                  ),


                  SizedBox(height: mediaWidth*0.05),

                  Align(
                    alignment: Alignment.topLeft,
                    child: Container(
                      width: 300,
                      alignment: Alignment.centerLeft,
                      child: Text(
                        AppData().language!.enterNewAndConfirmPass,
                        maxLines: 2,
                        style: openSansMedium.copyWith(color: Colors.black,fontSize: Dimensions.fontSizeDefault,),
                      ),
                    ),
                  ),
                  SizedBox(height: mediaWidth*0.03),
                  //SizedBox(height: MediaQuery.of(context).size.height*0.1,),

                  Container(
                    width: mediaWidth,
                    child: Column(children: [

                      TextField(
                        controller: _newPasswordController,
                        style: openSansRegular.copyWith(fontSize: Dimensions.fontSizeSmall,color: textColor),
                        keyboardType: TextInputType.name,
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
                          hintText: AppData().language!.password,
                          fillColor: Color(0XBBF0F0F0),
                          hintStyle: openSansRegular.copyWith(fontSize: Dimensions.fontSizeSmall),
                          filled: true,

                          prefixIcon: Padding(
                            padding: EdgeInsets.all(Dimensions.PADDING_SIZE_DEFAULT),
                            child: SvgPicture.asset(Images.lock_bold, height: 15, width: 15,color: Colors.black),
                          ),
                        ),
                      ),

                      SizedBox(height: 10,),
                      TextField(
                        controller: _confirmPasswordController,
                        style: openSansRegular.copyWith(fontSize: Dimensions.fontSizeSmall,color: textColor),
                        keyboardType: TextInputType.name,
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
                          hintText: AppData().language!.confirmPassword,
                          fillColor: Color(0XBBF0F0F0),
                          hintStyle: openSansRegular.copyWith(fontSize: Dimensions.fontSizeSmall),
                          filled: true,

                          prefixIcon: Padding(
                            padding: EdgeInsets.all(Dimensions.PADDING_SIZE_DEFAULT),
                            child: SvgPicture.asset(Images.lock_bold, height: 15, width: 15,color: Colors.black),
                          ),
                        ),
                      ),
                    ]),
                  ),
                  SizedBox(height: mediaWidth*0.2,),

                  Container(
                    height: 40,
                    width: mediaWidth*0.5,
                    child: TextButton(
                      onPressed: () => _resetPassword(),
                      style: flatButtonStyle,
                      child: Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                        Text(AppData().language!.reset, textAlign: TextAlign.center, style: openSansBold.copyWith(
                          color: textBtnColor,
                          fontSize: Dimensions.fontSizeSmall,
                        )),
                      ]),
                    ),
                  ),


                ]),
          ),
        ),
      ),),
    );
  }

  Future<void> _resetPassword() async {
    String _password = _newPasswordController.text.trim();
    String _confirmPassword = _confirmPasswordController.text.trim();
    String _oldPassword = _oldPasswordController.text.trim();
    if (_password.isEmpty) {
      showCustomSnackBar('Enter Password');
    }else if (_password.length < 6) {
      showCustomSnackBar('Password shoud be 6 digit');
    }else if(_password != _confirmPassword) {
      showCustomSnackBar('Confirm password does not matched');
    }else {
      openLoadingDialog(context, "Loading");
      var response;
      response = await DioService.post('forgot_password', {
        "requestType":"reset_password",
        "email":widget.email,
        "password":_password,
        "confirmPassword":_confirmPassword,
      });
      if(response['status']=='Success'){
        Navigator.pop(context);
        showCustomSnackBar(response['message'],isError: false);
        Get.offAll(() => WebSignIn());
      }
      else{
        Navigator.pop(context);
        print(response['message']);
        showCustomSnackBar(response['message']);
      }

    }
  }
}
