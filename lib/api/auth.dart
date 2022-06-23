import 'package:dio/dio.dart';
import 'package:knaw_news/model/signup_model.dart';
import 'package:knaw_news/util/app_constants.dart';
import 'package:knaw_news/view/base/custom_snackbar.dart';

class Auth{

  Future<void> signup(String action,Profile profile) async {
    try {
      var response = await Dio().post(action,data: {
        "userName":profile.userName,
        "userEmail":profile.userEmail,
        "userPassword": profile.userPassword,
        "confirmPassword": profile.confirmPassword
      });
      print("------------"+response.data);
      if(response.data["statuss"]=="success"){
        //   Get.to(() => DashboardScreen(pageIndex: 0));
      }
      else{
        showCustomSnackBar(response.data["message"]);
      }
    } catch (e) {
      print("---------------------");
      print(e.toString());
     // showCustomSnackBar(e.toString());
    }
  }
}

