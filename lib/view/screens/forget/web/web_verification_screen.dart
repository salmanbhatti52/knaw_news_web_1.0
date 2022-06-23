import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:flutter_svg/flutter_svg.dart';
import 'package:knaw_news/mixin/data.dart';
import 'package:knaw_news/services/dio_service.dart';
import 'package:knaw_news/util/dimensions.dart';
import 'package:knaw_news/util/images.dart';
import 'package:knaw_news/util/styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:knaw_news/view/base/custom_snackbar.dart';
import 'package:knaw_news/view/base/loading_dialog.dart';
import 'package:knaw_news/view/base/web_menu_bar.dart';
import 'package:knaw_news/view/screens/forget/new_pass_screen.dart';
import 'package:knaw_news/view/screens/forget/web/web_new_pass_screen.dart';
import 'package:pin_code_fields/pin_code_fields.dart';

class Verification extends StatefulWidget {
  String email;

  Verification({required this.email});

  @override
  _VerificationState createState() => _VerificationState();
}

class _VerificationState extends State<Verification> {
  String _number="";
  late Timer _timer;
  int _seconds = 0;

  @override
  void initState() {
    super.initState();

    //_startTimer();
  }

  // void _startTimer() {
  //   _seconds = 60;
  //   _timer = Timer.periodic(Duration(seconds: 1), (timer) {
  //     _seconds = _seconds - 1;
  //     if(_seconds == 0) {
  //       timer?.cancel();
  //       _timer?.cancel();
  //     }
  //     setState(() {});
  //   });
  // }

  // @override
  // void dispose() {
  //   super.dispose();
  //
  //   _timer?.cancel();
  // }

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
                  SizedBox(height: 30,),
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
                        "${AppData().language!.enter4DigitCodeForwardedOn} ${widget.email}",
                        maxLines: 2,
                        style: openSansMedium.copyWith(color: Colors.black,fontSize: Dimensions.fontSizeSmall,),
                      ),
                    ),
                  ),
                  SizedBox(height: 50,),

                  Container(
                    width: mediaWidth,
                    child: PinCodeTextField(
                      length: 4,
                      appContext: context,
                      hintCharacter: "0",
                      hintStyle: openSansMedium.copyWith(color: Color(0XFFC1C1C1)),
                      keyboardType: TextInputType.number,
                      animationType: AnimationType.fade,
                      pinTheme: PinTheme(
                        shape: PinCodeFieldShape.box,
                        fieldHeight: 45,
                        fieldWidth: 60,
                        borderWidth: 1,
                        borderRadius: BorderRadius.circular(Dimensions.RADIUS_SMALL),
                        selectedColor: Color(0XBBF0F0F0),
                        selectedFillColor: Colors.white,
                        inactiveFillColor: Color(0XBBF0F0F0),
                        inactiveColor: Color(0XBBF0F0F0),
                        activeColor: Color(0XBBF0F0F0),
                        activeFillColor: Color(0XBBF0F0F0),
                      ),
                      animationDuration: Duration(milliseconds: 300),
                      backgroundColor: Colors.transparent,
                      enableActiveFill: true,
                      onChanged: updateCode,
                      beforeTextPaste: (text) => true,
                    ),
                  ),

                  SizedBox(height: 70,),

                  Container(
                    height: 40,
                    width: mediaWidth*0.5,
                    child: TextButton(
                      onPressed: () => verifyCode(),
                      style: flatButtonStyle,
                      child: Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                        Text(AppData().language!.next, textAlign: TextAlign.center, style: openSansBold.copyWith(
                          color: textBtnColor,
                          fontSize: Dimensions.fontSizeSmall,
                        )),
                      ]),
                    ),
                  ),




                  SizedBox(height: 40),

                ]),
          ),
        ),
      ),),
    );
  }
  void updateCode(String num){

    _number=num;
  }
  Future<void> verifyCode() async {
    if(_number.length<4){
      showCustomSnackBar('Enter 4 digit code');
    }
    else{
      openLoadingDialog(context, "Loading");
      var response;
      response = await DioService.post('forgot_password', {
        "requestType":"match_code",
        "email":widget.email,
        "code":_number
      });
      if(response['status']=='Success'){
        Navigator.pop(context);
        showCustomSnackBar(response['message'],isError: false);
        Get.to(() => ResetPassword(email: widget.email,));
      }
      else{
        Navigator.pop(context);
        print(response['message']);
        showCustomSnackBar(response['message']);
      }
    }

  }
}
