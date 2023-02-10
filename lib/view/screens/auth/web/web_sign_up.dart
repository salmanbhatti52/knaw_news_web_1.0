import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:http/http.dart' as http;
import 'package:dio/dio.dart';

import 'package:flutter_svg/flutter_svg.dart';
import 'package:knaw_news/api/auth.dart';
import 'package:knaw_news/api/signin_with_google.dart';
import 'package:knaw_news/mixin/data.dart';
import 'package:knaw_news/model/signup_model.dart';
import 'package:knaw_news/services/dio_service.dart';
import 'package:knaw_news/util/app_constants.dart';
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
import 'package:knaw_news/view/screens/auth/social_login.dart';
import 'package:knaw_news/view/screens/auth/web/web_sign_in.dart';
import 'package:knaw_news/view/screens/dashboard/dashboard_screen.dart';
import 'package:knaw_news/view/screens/web/web_home.dart';
import 'package:onesignal_flutter/onesignal_flutter.dart';

class WebSignUp extends StatefulWidget {
  @override
  _WebSignUpState createState() => _WebSignUpState();
}

class _WebSignUpState extends State<WebSignUp> {
  final FocusNode _nameFocus = FocusNode();
  final FocusNode _emailFocus = FocusNode();
  final FocusNode _passwordFocus = FocusNode();
  final FocusNode _confirmPasswordFocus = FocusNode();

  Profile profile=Profile();

  // final TextEditingController _nameController = TextEditingController();
  // final TextEditingController _emailController = TextEditingController();
  // final TextEditingController _passwordController = TextEditingController();
  // final TextEditingController _confirmPasswordController = TextEditingController();

  @override
  void initState() {
    super.initState();
    profile.oneSignalId="oneSignalId";
  }

  @override
  Widget build(BuildContext context) {
    Size size=MediaQuery.of(context).size;
    return Scaffold(
      appBar: WebMenuBar(context: context,isAuthScreen: true,isHalf: true,),
      //backgroundColor:Get.isDarkMode ? Colors.black : Colors.white,
      body: SafeArea(child: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        padding: const EdgeInsets.all(Dimensions.PADDING_SIZE_SMALL),
        child: Center(
          child: Container(
            width: size.width>1000?size.width*0.5:size.width,
            child: Column(
                children: [



                  Container(
                    alignment: Alignment.centerLeft,
                    child: Text('${AppData().language!.hey}, \n${AppData().language!.signupNow}', style: openSansExtraBold.copyWith(fontSize: 25)),
                  ),


                  SizedBox(height: 10),

                  Container(
                    width: MediaQuery.of(context).size.width*0.8,
                    child: Column(children: [

                      TextField(
                        onChanged: (value)=> profile.userName=value,
                        style: openSansRegular.copyWith(fontSize: Dimensions.fontSizeSmall,color: textColor),
                        keyboardType: TextInputType.text,
                        focusNode: _nameFocus,
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
                          hintText: AppData().language!.userName,
                          fillColor: Color(0XBBF0F0F0),
                          hintStyle: openSansRegular.copyWith(fontSize: Dimensions.fontSizeSmall),
                          filled: true,

                          prefixIcon: Padding(
                            padding: EdgeInsets.all(Dimensions.PADDING_SIZE_SMALL),
                            child: SvgPicture.asset(Images.user_name, height: 15, width: 15,color: Colors.black),
                          ),
                        ),
                      ),

                      SizedBox(height: 10,),

                      TextField(
                        onChanged: (value)=> profile.userEmail=value,
                        style: openSansRegular.copyWith(fontSize: Dimensions.fontSizeSmall,color: textColor),
                        keyboardType: TextInputType.emailAddress,
                        focusNode: _emailFocus,
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
                            padding: EdgeInsets.all(Dimensions.PADDING_SIZE_SMALL),
                            child: SvgPicture.asset(Images.email, height: 15, width: 15,color: Colors.black),
                          ),
                        ),
                      ),

                      SizedBox(height: 10,),

                      TextField(
                        onChanged: (value)=> profile.userPassword=value,
                        style: openSansRegular.copyWith(fontSize: Dimensions.fontSizeSmall,color: textColor),
                        keyboardType: TextInputType.text,
                        cursorColor: Theme.of(context).primaryColor,
                        focusNode: _passwordFocus,
                        autofocus: false,
                        obscureText: true,
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
                            padding: EdgeInsets.all(Dimensions.PADDING_SIZE_SMALL),
                            child: SvgPicture.asset(Images.lock, height: 15, width: 25,color: Colors.black),
                          ),
                        ),
                      ),

                      SizedBox(height: 10,),

                      TextField(
                        onChanged: (value)=> profile.confirmPassword=value,
                        style: openSansRegular.copyWith(fontSize: Dimensions.fontSizeSmall,color: textColor),
                        keyboardType: TextInputType.text,
                        cursorColor: Theme.of(context).primaryColor,
                        focusNode: _confirmPasswordFocus,
                        autofocus: false,
                        obscureText: true,
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
                            padding: EdgeInsets.all(Dimensions.PADDING_SIZE_SMALL),
                            child: SvgPicture.asset(Images.lock, height: 15, width: 15,color: Colors.black),
                          ),
                        ),
                      ),



                    ]),
                  ),
                  SizedBox(height: MediaQuery.of(context).size.height*0.04),

                  Container(
                    height: 45,
                    width: size.width>750?size.width*0.3:size.width*0.5,
                    child: TextButton(
                      onPressed: () => _register(),
                      style: flatButtonStyle,
                      child: Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                        Text(AppData().language!.signup.toUpperCase(), textAlign: TextAlign.center, style: openSansBold.copyWith(
                          color: textBtnColor,
                          fontSize: Dimensions.fontSizeDefault,
                        )),
                      ]),
                    ),
                  ),

                  Container(
                    alignment: Alignment.center,
                    child: Text(
                      AppData().language!.oR,
                      style: openSansMedium.copyWith(color: textColor,fontSize: Dimensions.fontSizeDefault,),
                    ),
                  ),
                  SizedBox(height: 10),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        height: 45,
                        width: size.width>750?size.width*0.24:size.width*0.45,
                        decoration: BoxDecoration(
                          color: Colors.blueAccent,
                          borderRadius: BorderRadius.circular(5),
                        ),
                        child: TextButton(
                          onPressed: () => signinWithFacebook(),
                          child: Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                            Image.asset(Images.facebook, width: 30,),
                            SizedBox(width: 5,),
                            Text(AppData().language!.signInWithFacebook, textAlign: TextAlign.center, style: openSansBold.copyWith(
                                color: textBtnColor,
                                fontSize: size.width<1000&&size.width>750?Dimensions.fontSizeExtraSmall:Dimensions.fontSizeSmall,
                                overflow: TextOverflow.ellipsis
                            )),
                          ]),
                        ),
                      ),
                      SizedBox(height: 5),
                      Container(
                        height: 45,
                        width: size.width>750?size.width*0.24:size.width*0.45,
                        decoration: BoxDecoration(
                          color: Colors.red,
                          borderRadius: BorderRadius.circular(5),
                        ),
                        child: TextButton(
                          onPressed: () => signinWithGoogle(),
                          child: Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                            Image.asset(Images.google, width: 20,),
                            SizedBox(width: 20,),
                            Text(AppData().language!.signInWithGoogle, textAlign: TextAlign.center, style: openSansBold.copyWith(
                              color: textBtnColor,
                              fontSize: size.width<1000&&size.width>750?Dimensions.fontSizeExtraSmall:Dimensions.fontSizeSmall,
                            )),
                          ]),
                        ),
                      ),
                    ],
                  ),



                  SizedBox(height: 15),
                  TextButton(
                    style: TextButton.styleFrom(
                      minimumSize: Size(1, 40),
                    ),
                    onPressed: () {
                      Get.to(() => WebSignIn());
                    },
                    child: RichText(text: TextSpan(children: [
                      TextSpan(text: "${AppData().language!.alreadyMember}? ", style: openSansSemiBold.copyWith(color: textColor,fontSize: Dimensions.fontSizeSmall)),
                      TextSpan(text: AppData().language!.login, style: openSansBold.copyWith(color: Colors.red,fontSize: Dimensions.fontSizeSmall,decoration: TextDecoration.underline,decorationThickness: 4)),
                    ])),
                  ),

                ]),
          ),
        ),
      ),),
    );
  }

  void _register() async {



    // String _name = _nameController.text.trim();
    // String _email = _emailController.text.trim();
    // String _password = _passwordController.text.trim();
    // String _confirmPassword = _passwordController.text.trim();
    if (profile.userName.isNull) {
      showCustomSnackBar('Enter User Name');
    }
    else if (profile.userEmail.isNull) {
      showCustomSnackBar('Enter Email');
    }
    else if (profile.userPassword.isNull) {
      showCustomSnackBar('Enter Password');
    }else if (profile.userPassword!.length < 6) {
      showCustomSnackBar('Password should be 6 digit');
    }
    else if (profile.confirmPassword!=profile.userPassword) {
      showCustomSnackBar('Confirm password does not matched');
    }
    else{
      final status = await OneSignal.shared.getDeviceState();
      profile.oneSignalId=status?.userId;
      openLoadingDialog(context, "Loading");
      var response;

      // Auth auth=Auth();
      // auth.signup("https://dev.eigix.com/knawNews/api/signup", profile);
       response = await DioService.post('signup', profile.toJson());
       if(response['status']=='success'){
         var jsonData= response['data'];
         UserDetail userDetail   =  UserDetail.fromJson(jsonData);
         AppData().userdetail =userDetail;
         print(jsonData);
         print(AppData().userdetail!.toJson());
          Navigator.pop(context);
         Get.offAllNamed("/WebHome");
       }
       else{
         print("error");
         Navigator.pop(context);
         showCustomSnackBar(response['message']);

       }




      // try {
      //   var response = await Dio().post('https://dev.eigix.com/knawNews/api/signup',data: {
      //     "userName":profile.userName,
      //     "userEmail":profile.userEmail,
      //     "userPassword": profile.userPassword,
      //     "confirmPassword": profile.confirmPassword
      //   });
      //   print(response.data);
      //   if(response.data["statuss"]=="success"){
      //     //   Get.to(() => DashboardScreen(pageIndex: 0));
      //   }
      //   else{
      //     showCustomSnackBar(response.data["message"]);
      //   }
      // } catch (e) {
      //   showCustomSnackBar(e.toString());
      // }



    }

  }

  Future<void> signinWithFacebook() async{
    final LoginResult result = await FacebookAuth.instance.login(
      permissions: ['public_profile', 'email'],
    );
    if (result.status == LoginStatus.success) {
      print("Result LoginStatus.success");

      // you are logged
      final AccessToken accessToken = result.accessToken!;
      print(accessToken);
      final userData = await FacebookAuth.instance.getUserData(
        fields: "name,email,id",
      );
      print("User Data For Facebook");
      print(userData.toString());
      print("User Data For Facebook");
      openLoadingDialog(context, "Loading");
      var response;
      response = await DioService.post('signup_with_social', {
        "userName":userData['name'],
        "userEmail":userData['email'],
        "accountType":"facebook",
        "userType":"1",
        "facebookId" : userData['id'],
        "oneSignalId": profile.oneSignalId??''
      });
      print(response);
      if(response['status']=='success / Signed in with Facebook'){
        print("Facebook Login Succes");
        var jsonData= response['data'];
        UserDetail userDetail   =  UserDetail.fromJson(jsonData);
        print("Facebook Login Succes");
        AppData().userdetail =userDetail;
        print(AppData().userdetail!.toJson());
        print("After App Data Facebook Login Succes");
        Navigator.pop(context);
        showCustomSnackBar(response['status'],isError: false);
        Get.offAllNamed("/WebHome");
      }
      else{
        Navigator.pop(context);
        print("Api Response Data Error");
        print(response);
        print("Api Response Data Error");
        showCustomSnackBar(response['status']);

      }
      print(userData.toString());
    } else {
      print("Facebook Login Error");
      print(result.status);
      print(result.message);
      print("Facebook Login Error");
      showCustomSnackBar(result.message.toString());
    }
// or
// FacebookAuth.i.login(
//   permissions: ['public_profile', 'email', 'pages_show_list', 'pages_messaging', 'pages_manage_metadata'],
// )
    //Get.to(() => SignInScreen());
  }
  Future<void> signinWithGoogle() async {
    final FirebaseAuth _auth = FirebaseAuth.instance;
    final GoogleSignInAccount? googleSignInAccount = await GoogleSignInApi.login();
    final GoogleSignInAuthentication googleSignInAuthentication = await googleSignInAccount!.authentication;

    final AuthCredential credential = GoogleAuthProvider.credential(
      accessToken: googleSignInAuthentication.accessToken,
      idToken: googleSignInAuthentication.idToken,
    );

    final UserCredential userCredential = await _auth.signInWithCredential(credential);
    final User? user = userCredential.user;
    print(user);

    if(user!=null){
      print(user.toString());
      openLoadingDialog(context, "Loading");
      var response;
      response = await DioService.post('signup_with_social', {
        "userName":user.displayName,
        "userEmail":user.email,
        "accountType":"google",
        "userType":"1",
        "googleAccessToken" : user.uid,
        "oneSignalId": profile.oneSignalId??''
      });
      if(response['status']=='success / Signed in with Google'){
        var jsonData= response['data'];
        UserDetail userDetail   =  UserDetail.fromJson(jsonData);
        AppData().userdetail =userDetail;
        print(AppData().userdetail!.toJson());
        Navigator.pop(context);
        showCustomSnackBar(response['status'],isError: false);
        Get.offAllNamed("/WebHome");
      }
      else{
        Navigator.pop(context);
        print(response['status']);
        showCustomSnackBar(response['status']);
      }
    }
    else{
      showCustomSnackBar("User has canceled Login with Google");
    }
    //Get.to(() => SignInScreen());
  }
}
