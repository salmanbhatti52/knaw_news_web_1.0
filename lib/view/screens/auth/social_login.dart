import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/src/extension_navigation.dart';
import 'package:get/get_utils/src/extensions/internacionalization.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:knaw_news/api/signin_with_google.dart';
import 'package:knaw_news/mixin/data.dart';
import 'package:knaw_news/model/signup_model.dart';
import 'package:knaw_news/services/dio_service.dart';
import 'package:knaw_news/util/dimensions.dart';
import 'package:knaw_news/util/images.dart';
import 'package:knaw_news/util/styles.dart';
import 'package:knaw_news/view/base/custom_button.dart';
import 'package:knaw_news/view/base/custom_snackbar.dart';
import 'package:knaw_news/view/base/loading_dialog.dart';
import 'package:knaw_news/view/screens/auth/auth_screen.dart';
import 'package:knaw_news/view/screens/auth/sign_in_screen.dart';
import 'package:knaw_news/view/screens/dashboard/dashboard_screen.dart';
import 'package:knaw_news/view/screens/menu/appbar_with_back.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';


class SocialLogin extends StatefulWidget {
  const SocialLogin({Key? key}) : super(key: key);

  @override
  State<SocialLogin> createState() => _SocialLoginState();
}

class _SocialLoginState extends State<SocialLogin> {
  Profile profile=Profile();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        leading: GestureDetector(child: Image.asset(Images.back, width: 50,),onTap: () => Get.back(),),
      ),
      body: SafeArea(child: Scrollbar(
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Center(
            child: Container(

              child: Column(children: [
                Image.asset(Images.logo_with_name, width: 150,),
                //const SizedBox(height: Dimensions.PADDING_SIZE_EXTRA_LARGE),
                //Text('Knaw News', style: openSansExtraBold.copyWith(fontSize: 25)),
                SizedBox(height: 20),
                SvgPicture.asset(Images.mobile, width: 180,),
                SizedBox(height: 40),


                //SizedBox(height: Dimensions.PADDING_SIZE_LARGE),


                Container(
                  height: 45,
                  width: MediaQuery.of(context).size.width*0.75,
                  child: TextButton(
                    onPressed: () => Get.to(() => SignInScreen()),
                    style: flatButtonStyle,
                    child: Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                      Text(AppData().language!.signInWithEmail, textAlign: TextAlign.center, style: openSansBold.copyWith(
                        color: textBtnColor,
                        fontSize: Dimensions.fontSizeDefault,
                      )),
                    ]),
                  ),
                ),
                SizedBox(height: 15),
                Container(
                  decoration: BoxDecoration(
                    color: Colors.blueAccent,
                    borderRadius: BorderRadius.circular(5),
                  ),
                  height: 45,
                  width: MediaQuery.of(context).size.width*0.75,
                  child: TextButton(
                    onPressed: () => signinWithFacebook(),
                    child: Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                      Image.asset(Images.facebook, width: 40,),
                      SizedBox(width: 5,),
                      Text(AppData().language!.signInWithFacebook, textAlign: TextAlign.center, style: openSansBold.copyWith(
                        color: textBtnColor,
                        fontSize: Dimensions.fontSizeDefault,
                      )),
                    ]),
                  ),
                ),
                SizedBox(height: 15),
                Container(
                  decoration: BoxDecoration(
                    color: Colors.red,
                    borderRadius: BorderRadius.circular(5),
                  ),
                  height: 45,
                  width: MediaQuery.of(context).size.width*0.75,
                  child: TextButton(
                    onPressed: () => signinWithGoogle(),
                    child: Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                      Image.asset(Images.google, width: 20,),
                      SizedBox(width: 20,),
                      Text(AppData().language!.signInWithGoogle, textAlign: TextAlign.center, style: openSansBold.copyWith(
                        color: textBtnColor,
                        fontSize: Dimensions.fontSizeDefault,
                      )),
                    ]),
                  ),
                ),
              ]),
            ),
          ),
        ),
      ),),
    );

  }

  // Future facebookLogin() async {
  //   openLoadingDialog(context, "Signing In");
  //   try {
  //     final loginResult = await FacebookAuth.instance.login();
  //     print(loginResult.status);
  //     // final userData = await FacebookAuth.instance.getUserData();
  //     switch (loginResult.status) {
  //       case LoginStatus.success :
  //         final facebookAuthCredential = FacebookAuthProvider.credential(
  //             loginResult.accessToken!.token);
  //         print(facebookAuthCredential.accessToken);
  //         final graphResponse = await dio.get('https://graph.facebook.com/v2.12/me?fields=name,first_name,last_name,email & access_token=${facebookAuthCredential
  //             .accessToken}');
  //         final profile = json.decode(graphResponse.data);
  //         print(profile);
  //         print(profile['id']);
  //         var token = await dio.get("${apiUrl}token", options: Options(
  //           followRedirects: false,
  //           validateStatus: (status) {
  //             return status! < 600;
  //           },
  //         ));
  //         AppData().accessToken = token.data['token'];
  //
  //         try {
  //           var response = await DioService.post('signup_with_acc', {
  //             if(profile['name'] != null) "userName": profile['name'],
  //             if(profile['first_name'] !=
  //                 null) "firstName": profile['first_name'],
  //             if(profile['last_name'] != null) "lastName": profile['last_name'],
  //             if(profile['email'] != null) "userEmail": profile['email'],
  //             "accountType": 'facebook',
  //             "facebookId": profile['id'],
  //             "userType": '1'
  //           });
  //           print(response);
  //           Profile profiles = Profile.fromJson(response);
  //           var userData = response['data']['user'] as List;
  //           AppData().profile = profiles;
  //           print(AppData().profile!.hint_flag);
  //           List<UserDetail> userDetail = userData.map<UserDetail>((e) => UserDetail.fromJson(e)).toList();
  //           print(userDetail.first.toJson());
  //           AppData().userdetail = userDetail.first;
  //           showSuccessToast(
  //               "You are signed In as  ${AppData().userdetail!.user_name}");
  //           CustomNavigator.pushReplacement(context, SelectCategoriesPage());
  //         }
  //         catch (e) {
  //           Navigator.of(context).pop();
  //           print(e.toString());
  //         }
  //         break;
  //       case LoginStatus.cancelled:
  //         Navigator.of(context).pop();
  //         break;
  //       default:
  //         return null;
  //     //}
  //     }
  //   }catch(e){
  //     Navigator.of(context).pop();
  //     showErrorToast("Something happened");
  //   }
  //
  // }
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
        Get.to(() => DashboardScreen(pageIndex: 0));
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
        Get.to(() => DashboardScreen(pageIndex: 0));
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
  }

}
