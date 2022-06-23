import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:knaw_news/mixin/data.dart';
import 'package:knaw_news/model/language_model.dart';
import 'package:knaw_news/model/signup_model.dart';
import 'package:knaw_news/services/dio_service.dart';
import 'package:knaw_news/util/dimensions.dart';
import 'package:knaw_news/util/images.dart';
import 'package:knaw_news/util/styles.dart';
import 'package:knaw_news/view/base/custom_image.dart';
import 'package:knaw_news/view/base/custom_snackbar.dart';
import 'package:knaw_news/view/base/loading_dialog.dart';
import 'package:knaw_news/view/base/web_menu_bar.dart';
import 'package:knaw_news/view/screens/auth/social_login.dart';
import 'package:knaw_news/view/screens/menu/app_bar.dart';
import 'package:knaw_news/view/screens/menu/appbar_with_back.dart';
import 'package:knaw_news/view/screens/menu/drawer.dart';
import 'package:knaw_news/view/screens/profile/profile_screen.dart';
import 'package:knaw_news/view/screens/setting/account_setting.dart';
import 'package:knaw_news/view/screens/setting/change_email.dart';
import 'package:knaw_news/view/screens/setting/change_password.dart';
import 'package:knaw_news/view/screens/setting/language.dart';
import 'package:knaw_news/view/screens/setting/muted_member.dart';
import 'package:knaw_news/view/screens/setting/widget/setting_card.dart';
import 'package:image_picker/image_picker.dart';

class ProfileSetting extends StatefulWidget {
  String description;
  ProfileSetting({Key? key,this.description=""}) : super(key: key);

  @override
  State<ProfileSetting> createState() => _ProfileSettingState();
}

class _ProfileSettingState extends State<ProfileSetting> {
  PickedFile _pickedFile=PickedFile("");
  UserDetail user=UserDetail();
  final TextEditingController _descriptionController = TextEditingController();
  String desciption="";
  int selected=0;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    user=AppData().userdetail!;
    _descriptionController.text=AppData().userdetail!.description ?? "";
  }
  @override
  Widget build(BuildContext context) {
    Size size=MediaQuery.of(context).size;
    double mediaWidth=size.width;
    mediaWidth/=2;
    return Scaffold(
      appBar: WebMenuBar(context: context,isSearch: false,isAuthenticated: true,isHalf: true,),
      body: SafeArea(child: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Center(
          child: Column(
            children: [
              Container(
                width: mediaWidth,
                color: Colors.white,
                alignment: Alignment.center,
                child: Container(
                  width: mediaWidth*0.9,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [

                      Text(AppData().language!.myProfileSetting,style: openSansBold.copyWith(color: Colors.amber,),),
                      SizedBox(height: 10,),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            decoration: BoxDecoration(
                                border: Border.all(
                                  color: Colors.amber,
                                  width: 2,
                                ),
                                shape: BoxShape.circle
                            ),

                            child: Stack(
                              children: [
                                ClipOval(
                                  child: user.profilePicture == null || user.profilePicture == "" ?CustomImage(
                                    image: Images.placeholder,
                                    height: 120,
                                    width: 120,
                                    fit: BoxFit.cover,
                                  ):Image.network(
                                    user.profilePicture??'',
                                    width: 120,height: 120,fit: BoxFit.cover,
                                  ),
                                ),
                                Positioned(
                                  bottom: 0, right: 0,
                                  child: InkWell(
                                    onTap: () async {
                                      _pickedFile = (await ImagePicker().getImage(source: ImageSource.gallery))!;
                                      final   fileaa = _pickedFile.readAsBytes();
                                      user.profilePicture = base64Encode(await fileaa);
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
                          SizedBox(width: 20,),
                          Column(
                            children: [
                              SizedBox(
                                width: mediaWidth*0.6,
                                child: TextField(
                                  minLines: 4,
                                  maxLines: 4,
                                  maxLength: 100,
                                  controller: _descriptionController,
                                  style: openSansRegular.copyWith(color:Colors.black),
                                  keyboardType: TextInputType.multiline,
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
                              Container(
                                height: 30,
                                width: MediaQuery.of(context).size.width*0.1,
                                child: TextButton(
                                  onPressed: () => updateDescription(),
                                  style: flatButtonStyle,
                                  child: Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                                    Text(AppData().language!.Save, textAlign: TextAlign.center, style: openSansBold.copyWith(
                                      color: textBtnColor,
                                      fontSize: Dimensions.fontSizeSmall,
                                    )),
                                  ]),
                                ),
                              ),
                              SizedBox(height: 10,)
                            ],
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              Container(
                width: mediaWidth,
                child: Column(
                  children: [
                    SizedBox(height: 20,),
                    SettingCard(icon: Images.setting, title: AppData().language!.accountSetting,onTap: (){setState(() {selected==1?selected=0:selected=1;});},),
                    selected==1?Container(
                      width:mediaWidth*0.8,
                      margin: EdgeInsets.symmetric(vertical: 10),
                      child: AccountSetting(),
                    ):SizedBox(),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 15.0),
                      child: Container(
                        color: Theme.of(context).disabledColor.withOpacity(0.5),
                        width: MediaQuery.of(context).size.width*0.9,
                        height: 1,
                      ),
                    ),
                    SettingCard(icon: Images.language, title: AppData().language!.language,onTap: (){setState(() {selected==2?selected=0:selected=2;});},),
                    selected==2?Container(
                      width:mediaWidth*0.8,
                      margin: EdgeInsets.symmetric(vertical: 10),
                      child: LanguageScreen(onLanguageSelect: (language) => updateLanguage(language),),
                    ):SizedBox(),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 15.0),
                      child: Container(
                        color: Theme.of(context).disabledColor.withOpacity(0.5),
                        width: MediaQuery.of(context).size.width*0.9,
                        height: 1,
                      ),
                    ),
                    SettingCard(icon: Images.email_bold, title: AppData().language!.changeEmail,onTap: (){setState(() {selected==3?selected=0:selected=3;});},),
                    selected==3?Container(
                      width:mediaWidth*0.8,
                      margin: EdgeInsets.symmetric(vertical: 10),
                      child: ChangeEmail(),
                    ):SizedBox(),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 15.0),
                      child: Container(
                        color: Theme.of(context).disabledColor.withOpacity(0.5),
                        width: MediaQuery.of(context).size.width*0.9,
                        height: 1,
                      ),
                    ),
                    SettingCard(icon: Images.lock_bold, title: AppData().language!.changeYourPassword,onTap: (){setState(() {selected==4?selected=0:selected=4;});},),
                    selected==4?Container(
                      width:mediaWidth*0.8,
                      margin: EdgeInsets.symmetric(vertical: 10),
                      child: ChangePassword(),
                    ):SizedBox(),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 15.0),
                      child: Container(
                        color: Theme.of(context).disabledColor.withOpacity(0.5),
                        width: MediaQuery.of(context).size.width*0.9,
                        height: 1,
                      ),
                    ),
                    SettingCard(icon: Images.mute, title: AppData().language!.mutedMembers,onTap: (){setState(() {selected==5?selected=0:selected=5;});},),
                    selected==5?Container(
                      width:mediaWidth*0.8,
                      margin: EdgeInsets.symmetric(vertical: 10),
                      child: MutedMember(),
                    ):SizedBox(),
                    SizedBox(height: 20,),

                  ],
                ),
              ),
            ],
          )
        ),
      ),),
    );

  }
  void updateLanguage(String language) async {
    openLoadingDialog(context, "Loading");
    var response;
    response = await DioService.post('get_language', {
      "language":language
    });
    if(response['status']=='success'){
      var jsonData= response['data'];
      Language language = Language.fromJson(jsonData);
      AppData().language=language;
      print(AppData().language!.toJson());
      setState(() {

      });
      Navigator.pop(context);
    }
    else{
      Navigator.pop(context);
      print(response['message']);
      //showCustomSnackBar(response['message']);
    }


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
    if(_descriptionController.text.isEmpty){
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
      }
      else{
        Navigator.pop(context);
        print(response['status']);
        showCustomSnackBar(response['data']);
      }
    }

  }
}
