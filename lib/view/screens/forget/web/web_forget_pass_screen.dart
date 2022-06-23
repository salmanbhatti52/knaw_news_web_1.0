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

class ForgetPassword extends StatefulWidget {
  @override
  State<ForgetPassword> createState() => _ForgetPasswordState();
}

class _ForgetPasswordState extends State<ForgetPassword> {
  final TextEditingController _emailController = TextEditingController();

//   String _countryDialCode;


  @override
  Widget build(BuildContext context) {
    Size size=MediaQuery.of(context).size;
    double mediaWidth=size.width;
    mediaWidth/=2;
    return Scaffold(
      appBar: WebMenuBar(context: context,isAuthScreen: true,isHalf: true,),
      body: SafeArea(child: Center(
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          padding: const EdgeInsets.symmetric(vertical:Dimensions.PADDING_SIZE_SMALL),
          child: Center(
            child: Container(
              width: mediaWidth,
              child: Column(
                  children: [

                    Container(
                      alignment: Alignment.centerLeft,
                      child: Text('${AppData().language!.forgot} \n${AppData().language!.password}?', style: openSansBold.copyWith(fontSize: Dimensions.fontSizeDefault)),
                    ),


                    SizedBox(height: 25),

                    Align(
                      alignment: Alignment.topLeft,
                      child: Container(
                        width: 300,
                        alignment: Alignment.centerLeft,
                        child: Text(
                          AppData().language!.enterEmailToResetPass,
                          maxLines: 2,
                          style: openSansMedium.copyWith(color: Colors.black,fontSize: Dimensions.fontSizeSmall,),
                        ),
                      ),
                    ),
                    SizedBox(height: 30,),

                    Container(
                      width: mediaWidth,
                      child: TextField(
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
                            child: SvgPicture.asset(Images.email_bold, height: 15, width: 15,color: Colors.black),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: 70),

                    Container(
                      height: 40,
                      width: mediaWidth*0.5,
                      child: TextButton(
                        onPressed: () => _forgetPass(),
                        style: flatButtonStyle,
                        child: Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                          Text(AppData().language!.send, textAlign: TextAlign.center, style: openSansBold.copyWith(
                            color: textBtnColor,
                            fontSize: Dimensions.fontSizeSmall,
                          )),
                        ]),
                      ),
                    ),


                    SizedBox(height: 40)

                  ]),
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
        //Get.to(() => Verification(email: _email,));

        Get.toNamed("/Verification",arguments: {_email});
      }
      else{
        Navigator.pop(context);
        print(response['message']);
        showCustomSnackBar(response['message']);

      }

    }


  }
}
