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
import 'package:knaw_news/view/screens/forget/new_pass_screen.dart';
import 'package:pin_code_fields/pin_code_fields.dart';

class VerificationScreen extends StatefulWidget {
  String email;

  VerificationScreen({required this.email});

  @override
  _VerificationScreenState createState() => _VerificationScreenState();
}

class _VerificationScreenState extends State<VerificationScreen> {
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
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Color(0xFFF8F8FA),
        leading: GestureDetector(child: Image.asset(Images.back, width: 50,),onTap: () => Get.back(),),
        title: SvgPicture.asset(Images.logo_name,width: 100,),
        centerTitle: true,

      ),
      //backgroundColor:Get.isDarkMode ? Colors.black : Colors.white,
      body: SafeArea(child: Scrollbar(
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          padding: const EdgeInsets.all(Dimensions.PADDING_SIZE_SMALL),
          child: Center(
            child: Container(
              child: Column(
                  children: [

                    SizedBox(height: MediaQuery.of(context).size.width*0.13),


                    Container(
                      padding: EdgeInsets.only(left: MediaQuery.of(context).size.width*0.07),
                      alignment: Alignment.centerLeft,
                      child: Text('${AppData().language!.forgot} \n${AppData().language!.password}?', style: openSansExtraBold.copyWith(fontSize: 25)),
                    ),
                    SizedBox(height: 25),

                    Container(
                      padding: EdgeInsets.only(left: MediaQuery.of(context).size.width*0.07,right: MediaQuery.of(context).size.width*0.3,),
                      alignment: Alignment.centerLeft,
                      child: Text(
                        "${AppData().language!.enter4DigitCodeForwardedOn} ${widget.email}",
                        maxLines: 2,
                        style: openSansRegular.copyWith(color: textColor,fontSize: Dimensions.fontSizeDefault,),
                      ),
                    ),
                    SizedBox(height: MediaQuery.of(context).size.height*0.1,),

                    Container(
                      width: MediaQuery.of(context).size.width*0.8,
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

                    SizedBox(height: MediaQuery.of(context).size.height*0.1,),

                    Container(
                      height: 45,
                      width: MediaQuery.of(context).size.width*0.7,
                      child: TextButton(
                        onPressed: () => verifyCode(),
                        style: flatButtonStyle,
                        child: Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                          Text(AppData().language!.next, textAlign: TextAlign.center, style: openSansBold.copyWith(
                            color: textBtnColor,
                            fontSize: Dimensions.fontSizeDefault,
                          )),
                        ]),
                      ),
                    ),



                    SizedBox(height: 15),


                    SizedBox(height: 40),

                  ]),
            ),
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
        Get.to(() => NewPassScreen(email: widget.email,));
      }
      else{
        Navigator.pop(context);
        print(response['message']);
        showCustomSnackBar(response['message']);
      }
    }

  }
}
