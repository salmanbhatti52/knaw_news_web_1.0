import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:knaw_news/mixin/data.dart';
import 'package:knaw_news/model/signup_model.dart';
import 'package:knaw_news/services/dio_service.dart';
import 'package:knaw_news/util/app_constants.dart';
import 'package:knaw_news/util/dimensions.dart';
import 'package:knaw_news/util/images.dart';
import 'package:knaw_news/util/styles.dart';
import 'package:knaw_news/view/base/custom_image.dart';
import 'package:knaw_news/view/base/custom_snackbar.dart';
import 'package:knaw_news/view/base/loading_dialog.dart';
import 'package:knaw_news/view/screens/auth/social_login.dart';
import 'package:knaw_news/view/screens/menu/app_bar.dart';
import 'package:knaw_news/view/screens/menu/appbar_with_back.dart';
import 'package:knaw_news/view/screens/menu/drawer.dart';
import 'package:knaw_news/view/screens/profile/profile_screen.dart';
import 'package:knaw_news/view/screens/setting/account_setting.dart';
import 'package:knaw_news/view/screens/setting/change_email.dart';
import 'package:knaw_news/view/screens/setting/change_password.dart';
import 'package:knaw_news/view/screens/setting/muted_member.dart';
import 'package:knaw_news/view/screens/setting/widget/setting_card.dart';
import 'package:image_picker/image_picker.dart';

class SettingScreen extends StatefulWidget {
  String description;
  SettingScreen({Key? key,this.description=""}) : super(key: key);

  @override
  State<SettingScreen> createState() => _SettingScreenState();
}

class _SettingScreenState extends State<SettingScreen> {
  PickedFile _pickedFile=PickedFile("");
  UserDetail user=UserDetail();
  final TextEditingController _descriptionController = TextEditingController();
  String desciption="";
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    user=AppData().userdetail!;
    _descriptionController.text=AppData().userdetail!.description ?? "";
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarWithBack(title: AppData().language!.setting,isTitle: true,isSuffix: true,suffix: Images.check_circle,suffixTap: (){
        updateDescription();
      },),
      body: SafeArea(child: Scrollbar(
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Center(
            child: Column(
              children: [
                Container(
                  height: 120,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(bottomLeft: Radius.circular(10),bottomRight: Radius.circular(10)),
                  ),
                  alignment: Alignment.topCenter,
                  child: Container(
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: Colors.amber,
                        width: 4,
                      ),
                      shape: BoxShape.circle
                    ),

                    child: Stack(
                      children: [
                        ClipOval(
                          child: user.profilePicture == null || user.profilePicture == "" ?CustomImage(
                            image: Images.placeholder,
                            height: 90,
                            width: 90,
                            fit: BoxFit.cover,
                          ):Image.network(
                            user.profilePicture!,
                            width: 90,height: 90,fit: BoxFit.cover,
                          ),
                        ),
                        Positioned(
                          bottom: 0, right: 0,
                          child: InkWell(
                            onTap: () async {
                              _pickedFile = (await ImagePicker().getImage(source: ImageSource.gallery))!;
                              final   file = _pickedFile.readAsBytes();
                                user.profilePicture = base64Encode(await file);
                                updateProfilePicture();
                                SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
                                  statusBarIconBrightness: Brightness.dark,
                                  statusBarColor: Color(0XFFF6F6F8), // status bar color
                                ));
                            },
                            child: Container(
                              height: 30,
                              width: 30,
                              decoration: const BoxDecoration(
                                //borderRadius: BorderRadiusDirectional.circular(20),
                                color: Colors.white,
                                shape: BoxShape.circle,
                                //border: Border.all(width: 1, color: Theme.of(context).primaryColor),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.all(5.0),
                                child: SvgPicture.asset(Images.camera, color: Colors.black),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),

                  ),
                ),
                SizedBox(height: 10,),
                SizedBox(
                  width: MediaQuery.of(context).size.width*0.9,
                  child: TextField(
                    minLines: 4,
                    maxLines: 4,
                    maxLength: 100,
                    controller: _descriptionController,
                    style: openSansRegular.copyWith(color:Colors.black),
                    keyboardType: TextInputType.text,
                    cursorColor: Theme.of(context).primaryColor,
                    autofocus: false,
                    obscureText: false,
                    decoration: InputDecoration(
                      focusColor: const Color(0XF7F7F7),
                      hoverColor: const Color(0XF7F7F7),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(Dimensions.RADIUS_SMALL),
                        borderSide: const BorderSide(style: BorderStyle.none, width: 0),
                      ),
                      isDense: true,
                      hintText: AppData().language!.yourDescription,
                      fillColor: Color(0XFFF0F0F0),
                      hintStyle: openSansRegular.copyWith(fontSize: Dimensions.fontSizeSmall),
                      filled: true,

                    ),
                  ),
                ),
                SettingCard(icon: Images.setting, title: AppData().language!.accountSetting,onTap: () => Get.to(AccountSetting())),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 15.0),
                  child: Container(
                    color: Theme.of(context).disabledColor.withOpacity(0.5),
                    width: MediaQuery.of(context).size.width*0.9,
                    height: 1,
                  ),
                ),
                SettingCard(icon: Images.email_bold, title: AppData().language!.changeEmail,onTap: () => Get.to(ChangeEmail()),),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 15.0),
                  child: Container(
                    color: Theme.of(context).disabledColor.withOpacity(0.5),
                    width: MediaQuery.of(context).size.width*0.9,
                    height: 1,
                  ),
                ),
                SettingCard(icon: Images.lock_bold, title: AppData().language!.changeYourPassword,onTap: () => Get.to(ChangePassword())),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 15.0),
                  child: Container(
                    color: Theme.of(context).disabledColor.withOpacity(0.5),
                    width: MediaQuery.of(context).size.width*0.9,
                    height: 1,
                  ),
                ),
                SettingCard(icon: Images.mute, title: AppData().language!.mutedMembers,onTap: () => Get.to(MutedMember())),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 15.0),
                  child: Container(
                    color: Theme.of(context).disabledColor.withOpacity(0.5),
                    width: MediaQuery.of(context).size.width*0.9,
                    height: 1,
                  ),
                ),
                SettingCard(icon: Images.logout, title: AppData().language!.loadMore,onTap: () => Get.offAll(SocialLogin())),
              ],
            )
          ),
        ),
      ),),
    );

  }
  void updateProfilePicture() async{

      openLoadingDialog(context, "Saving");
      var response;
      response = await DioService.post('update_profile_picture', {
        "userId":user.usersId,
        "profilePicture": user.profilePicture
      });
      if(response['status']=='success'){
        var jsonData= response['data'];
        user=  UserDetail.fromJson(jsonData);
        AppData().userdetail = user;
        print(AppData().userdetail!.toJson());
        Navigator.pop(context);
        setState(() {

        });
        showCustomSnackBar(response['status'],isError: false);
      }
      else{
        Navigator.pop(context);
        setState(() {

        });
        print(response['status']);
        showCustomSnackBar(response['data']);
      }

  }
  void updateDescription() async{
    if(_descriptionController.text.toString()==""){
      showCustomSnackBar("Enter Description to update");
    }
    else{
      desciption=_descriptionController.text;
      openLoadingDialog(context, "Saving");
      var response;
      response = await DioService.post('update_profile_description', {
        "userId":user.usersId,
        "description":desciption
      });
      if(response['status']=='success'){
        print(desciption);
        AppData().userdetail!.description= desciption;
        AppData().update();
        print( AppData().userdetail!.description);

        print(AppData().userdetail!.toJson());
        Navigator.pop(context);
        showCustomSnackBar(response['data'],isError: false);
        Get.to(() => ProfileScreen(index: 0,));
      }
      else{
        Navigator.pop(context);
        print(response['status']);
        showCustomSnackBar(response['data']);
      }
    }

  }
}
