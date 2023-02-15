import 'dart:async';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:knaw_news/api/signin_with_google.dart';
import 'package:knaw_news/mixin/data.dart';
import 'package:knaw_news/model/signup_model.dart';
import 'package:knaw_news/services/dio_service.dart';
import 'package:knaw_news/util/dimensions.dart';
import 'package:knaw_news/util/images.dart';
import 'package:knaw_news/util/styles.dart';
import 'package:knaw_news/view/base/custom_snackbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:knaw_news/view/base/loading_dialog.dart';
import 'package:knaw_news/view/base/web_menu_bar.dart';
import 'package:knaw_news/view/screens/auth/web/web_sign_up.dart';
import 'package:knaw_news/view/screens/web/initial_screen.dart';

class WebSignIn extends StatefulWidget {
  const WebSignIn({Key? key}) : super(key: key);


  @override
  _WebSignInState createState() => _WebSignInState();
}

class _WebSignInState extends State<WebSignIn> {
  final FocusNode _emailFocus = FocusNode();
  final FocusNode _passwordFocus = FocusNode();
  Profile profile=Profile();
  bool isChecked=false;
  bool isLanguage=AppData().isLanguage;

  @override
  void initState() {
    super.initState();
    profile.oneSignalId="oneSignalId";
  }

  @override
  Widget build(BuildContext context) {
    isLanguage=AppData().isLanguage;
    Size size=MediaQuery.of(context).size;
    double width=size.width;
    width=width>1000?width*0.5:width;
    return WillPopScope(
      onWillPop: () async {
        return true;

      },
      child: Scaffold(
        appBar: WebMenuBar(context: context,isAuthScreen: true,isHalf: true,),
        //backgroundColor:Get.isDarkMode ? Colors.black : Colors.white,
        body: SafeArea(child: Center(
          child: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            padding: const EdgeInsets.all(Dimensions.PADDING_SIZE_SMALL),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 30),
                  child: IconButton(onPressed: (){
                    Navigator.push(context, MaterialPageRoute(builder: (context)=>InitialScreen()));
                  }, icon: Icon(Icons.arrow_back,size: 35,)),
                ),
                Center(
                  child: Container(
                    width: size.width>750?size.width*0.5:size.width,
                    child: Column(
                        children: [



                          Container(
                            alignment: Alignment.centerLeft,
                            child: Text(isLanguage?"${AppData().language!.hey}, \n${AppData().language!.loginNow}":'Hey, \nLogin Now', style: openSansBold.copyWith(fontSize: 25)),
                          ),

                          Align(
                            alignment: Alignment.topLeft,
                            child: Container(
                              width: 300,
                              alignment: Alignment.centerLeft,
                              child: Text(
                                isLanguage?AppData().language!.enterNameAndPass:"Enter your username and password to log in",
                                style: openSansMedium.copyWith(color: textColor,fontSize: Dimensions.fontSizeDefault,),
                              ),
                            ),
                          ),
                          SizedBox(height: 10),

                          Container(
                            width: MediaQuery.of(context).size.width*0.8,
                            child: Column(children: [

                              TextField(
                                onChanged: (value)=> profile.userName=value,
                                style: openSansRegular.copyWith(fontSize: Dimensions.fontSizeSmall,color: textColor),
                                keyboardType: TextInputType.text,
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
                                  hintText: isLanguage?AppData().language!.userName:"User name",
                                  fillColor: Color(0XBBF0F0F0),
                                  hintStyle: openSansRegular.copyWith(fontSize: Dimensions.fontSizeSmall),
                                  filled: true,

                                  prefixIcon: Padding(
                                    padding: EdgeInsets.all(Dimensions.PADDING_SIZE_SMALL),
                                    child: SvgPicture.asset(Images.user_name, height: 15, width: 15,color: Colors.black),
                                  ),
                                ),
                              ),

                              SizedBox(height: 5,),

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
                                  hintText: isLanguage?AppData().language!.password:"Password",
                                  fillColor: Color(0XBBF0F0F0),
                                  hintStyle: openSansRegular.copyWith(fontSize: Dimensions.fontSizeSmall),
                                  filled: true,

                                  prefixIcon: Padding(
                                    padding: EdgeInsets.all(Dimensions.PADDING_SIZE_SMALL),
                                    child: SvgPicture.asset(Images.lock, height: 15, width: 15,color: Colors.black),
                                  ),
                                ),
                              ),
                              Row(
                                  children: [
                                    Expanded(
                                      child: ListTile(
                                        minLeadingWidth: 0,
                                        hoverColor: null,
                                        focusColor: null,
                                        selectedTileColor: null,
                                        tileColor: null,
                                        leading: Checkbox(
                                          side: BorderSide(color: Colors.red,width: 2),
                                          shape: RoundedRectangleBorder(
                                              borderRadius: BorderRadius.circular(5)
                                          ),
                                          checkColor: Colors.white,
                                          activeColor: Colors.red,
                                          value: isChecked,
                                          onChanged: (val) => setState(() {
                                            isChecked=val!;
                                          }),
                                        ),
                                        title: Text(isLanguage?AppData().language!.rememberMe:'Remember me',style: openSansRegular.copyWith(fontSize:Dimensions.fontSizeDefault,color: textColor),),
                                        contentPadding: EdgeInsets.zero,
                                        dense: true,
                                        horizontalTitleGap: 0,
                                      ),
                                    ),
                                    TextButton(
                                      onPressed: () {
                                        //Get.to(() => ForgetPassword());
                                        if(isLanguage)Get.toNamed("/ForgetPassword");
                                      },
                                      child: Text(isLanguage?AppData().language!.forgotPassword:'Forgot Password?',
                                        style: openSansMedium.copyWith(fontSize: Dimensions.fontSizeDefault,color: Colors.red),
                                      ),
                                    ),
                                  ]),
                            ]),
                          ),
                          SizedBox(height: 5),

                          SizedBox(height: Dimensions.PADDING_SIZE_LARGE),

                          Container(
                            height: 45,
                            width: size.width>750?size.width*0.3:size.width*0.5,
                            child: TextButton(
                              onPressed: () => isLanguage?_login():null,
                              style: flatButtonStyle,
                              child: Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                                Text(isLanguage?AppData().language!.loginNow:"Login Now", textAlign: TextAlign.center, style: openSansBold.copyWith(
                                  color: textBtnColor,
                                  fontSize: Dimensions.fontSizeDefault,
                                )),
                              ]),
                            ),
                          ),
                          SizedBox(height: 10),
                          Container(
                            alignment: Alignment.center,
                            child: Text(
                              isLanguage?AppData().language!.oR:"OR",
                              style: openSansMedium.copyWith(color: textColor,fontSize: Dimensions.fontSizeDefault,),
                            ),
                          ),
                          SizedBox(height: 10),
                          // Row(
                          //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          //   children: [
                          //     Container(
                          //       height: 45,
                          //       width: size.width>750?size.width*0.24:size.width*0.45,
                          //       decoration: BoxDecoration(
                          //         color: Colors.blueAccent,
                          //         borderRadius: BorderRadius.circular(5),
                          //       ),
                          //       child: TextButton(
                          //         onPressed: () => isLanguage?signinWithFacebook():null,
                          //         child: Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                          //           Image.asset(Images.facebook, width: 30,),
                          //           SizedBox(width: 5,),
                          //           Text("SIGN IN WITH FACEBOOK", textAlign: TextAlign.center, style: openSansBold.copyWith(
                          //             color: textBtnColor,
                          //               fontSize: size.width<1000&&size.width>750?Dimensions.fontSizeExtraSmall:Dimensions.fontSizeSmall,
                          //             overflow: TextOverflow.ellipsis
                          //           )),
                          //         ]),
                          //       ),
                          //     ),
                          //     SizedBox(height: 5),
                          //     Container(
                          //       height: 45,
                          //       width: size.width>750?size.width*0.24:size.width*0.45,
                          //       decoration: BoxDecoration(
                          //         color: Colors.red,
                          //         borderRadius: BorderRadius.circular(5),
                          //       ),
                          //       child: TextButton(
                          //         onPressed: () => isLanguage?signinWithGoogle():null,
                          //         child: Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                          //           Image.asset(Images.google, width: 20,),
                          //           SizedBox(width: 20,),
                          //           Text("SIGN IN WITH GOOGLE", textAlign: TextAlign.center, style: openSansBold.copyWith(
                          //             color: textBtnColor,
                          //             fontSize: size.width<1000&&size.width>750?Dimensions.fontSizeExtraSmall:Dimensions.fontSizeSmall,
                          //           )),
                          //         ]),
                          //       ),
                          //     ),
                          //   ],
                          // ),
                          SizedBox(height: 20),
                          TextButton(
                            style: TextButton.styleFrom(
                              minimumSize: Size(1, 40),
                            ),
                            onPressed: () {

                              if(isLanguage)Get.toNamed("/WebSignUp");
                            },
                            child: RichText(text: TextSpan(children: [
                              TextSpan(text: isLanguage?AppData().language!.iAmNewUser:"I'm a new user ", style: openSansSemiBold.copyWith(color: textColor,fontSize: Dimensions.fontSizeSmall)),
                              TextSpan(text: isLanguage?AppData().language!.signUp:'Sign Up', style: openSansBold.copyWith(color: Colors.red,fontSize: Dimensions.fontSizeSmall,decoration: TextDecoration.underline,decorationThickness: 4)),
                            ])),
                          ),

                        ]),
                  ),
                ),
              ],
            ),
          ),
        ),),
      ),
    );
  }

  void _login() async {
    print(profile.toJson());
    if (profile.userName.isNull) {
      showCustomSnackBar('Enter User Name');
    }
    else if (profile.userPassword.isNull) {
      showCustomSnackBar('Enter Password');
    }else if (profile.userPassword!.length < 6) {
      showCustomSnackBar('Password should be 6 digit');
    }
    else {

      openLoadingDialog(context, "Loading");
      var response;
      response = await DioService.post('login', profile.toJson());
      if(response['status']=='success'){
        var jsonData= response['data'];
        UserDetail userDetail   =  UserDetail.fromJson(jsonData);
        AppData().userdetail =userDetail;
        print(AppData().userdetail!.toJson());
        Navigator.pop(context);
        //Get.to(() => WebHome());
        Get.toNamed("/");

      }
      else{
        Navigator.pop(context);
        print(response['message']);
        showCustomSnackBar(response['message']);

      }

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

  void toggleCheckbox(){
    setState(() {
      isChecked!=isChecked;
    });
  }
}
