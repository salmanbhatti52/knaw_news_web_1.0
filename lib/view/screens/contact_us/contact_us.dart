import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:knaw_news/mixin/data.dart';
import 'package:knaw_news/model/about_model.dart';
import 'package:knaw_news/services/about_service.dart';
import 'package:knaw_news/services/dio_service.dart';
import 'package:knaw_news/util/dimensions.dart';
import 'package:knaw_news/util/images.dart';
import 'package:knaw_news/util/styles.dart';
import 'package:knaw_news/view/base/custom_snackbar.dart';
import 'package:knaw_news/view/base/loading_dialog.dart';
import 'package:knaw_news/view/base/web_menu_bar.dart';
import 'package:knaw_news/view/screens/menu/app_bar.dart';
import 'package:knaw_news/view/screens/menu/drawer.dart';

class ContactUs extends StatefulWidget {
  bool fromMobile;
  ContactUs({Key? key,this.fromMobile=false}) : super(key: key);

  @override
  State<ContactUs> createState() => _ContactUsState();
}

class _ContactUsState extends State<ContactUs> {
  TextEditingController subjectController=TextEditingController();
  TextEditingController nameController=TextEditingController();
  TextEditingController emailController=TextEditingController();
  TextEditingController messageController=TextEditingController();
  List<String> subjectType=[AppData().language!.changeUsername, AppData().language!.activeYourAccount,
    AppData().language!.deleteYourAccount,AppData().language!.keywordAlerts,
    AppData().language!.legalAndComplaints,AppData().language!.bugOrFeatureRequest,
    AppData().language!.contactModeratorTeam, AppData().language!.b2bPROtherProblem];
  String? subject;


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    Size size=MediaQuery.of(context).size;
    double mediaWidth=size.width;
      mediaWidth/=2;
    return Scaffold(
      drawer: new MyDrawer(),
      appBar: GetPlatform.isDesktop?WebMenuBar(context: context,isAuthenticated: AppData().isAuthenticated,isSearch: false,isHalf: true,):CustomAppBar(leading: Images.menu,title: "Contact Us",isTitle: true,isSuffix: false,),
      body: SafeArea(child: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        padding: EdgeInsets.symmetric(vertical:Dimensions.PADDING_SIZE_DEFAULT),
        child: Center(
          child: Container(
            width: GetPlatform.isDesktop?mediaWidth:MediaQuery.of(context).size.width*0.9,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(AppData().language!.contactUs,style: openSansBold),
                SizedBox(height: 15,),
                Text(AppData().language!.subject,style: openSansBold.copyWith(color: Colors.black,fontSize: Dimensions.fontSizeSmall),),
                SizedBox(height: 10,),
                Container(
                  height: 50,
                  padding: EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: Color(0XFFF0F0F0),
                    borderRadius: BorderRadius.circular(5)
                  ),
                  child: DropdownButton<String>(
                    underline: Container(),
                    isExpanded: true,
                    iconEnabledColor: Colors.black,
                    focusColor: Colors.black,
                    hint: Text("${AppData().language!.whatsYourMessageAbout}?",style: openSansRegular.copyWith(fontSize: Dimensions.fontSizeSmall),),
                    icon: Icon(Icons.arrow_drop_down_rounded),
                    items: subjectType.map((value) {
                      return new DropdownMenuItem<String>(
                        value: value,
                        child: Text(value),
                      );
                    }).toList(),
                    onChanged: (String? newValue){
                      print(newValue);
                      subject = newValue;
                      setState(() {});
                    },
                    value: subject,
                  ),
                ),
                SizedBox(height: 10,),
                Text(AppData().language!.yourName,style: openSansBold.copyWith(color: Colors.black,fontSize: Dimensions.fontSizeSmall),),
                SizedBox(height: 10,),
                TextField(
                  controller: nameController,
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
                    hintText: AppData().language!.markMood,
                    fillColor: Color(0XFFF0F0F0),
                    hintStyle: openSansRegular.copyWith(fontSize: Dimensions.fontSizeSmall),
                    filled: true,

                  ),
                ),
                SizedBox(height: 10,),
                Text(AppData().language!.yourEmailAddress,style: openSansBold.copyWith(color: Colors.black,fontSize: Dimensions.fontSizeSmall),),
                SizedBox(height: 10,),
                TextField(
                  controller: emailController,
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
                    hintText: AppData().language!.gmailHint,
                    fillColor: Color(0XFFF0F0F0),
                    hintStyle: openSansRegular.copyWith(fontSize: Dimensions.fontSizeSmall),
                    filled: true,

                  ),
                ),
                SizedBox(height: 10,),
                Text(AppData().language!.message,style: openSansBold.copyWith(color: Colors.black,fontSize: Dimensions.fontSizeSmall),),
                SizedBox(height: 10,),
                TextField(
                  controller: messageController,
                  style: openSansRegular.copyWith(fontSize: Dimensions.fontSizeSmall,color: textColor),
                  keyboardType: TextInputType.multiline,
                  cursorColor: Theme.of(context).primaryColor,
                  autofocus: false,
                  maxLines: 4,
                  minLines: 4,
                  decoration: InputDecoration(
                    focusColor: const Color(0XF7F7F7),
                    hoverColor: const Color(0XF7F7F7),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(Dimensions.RADIUS_SMALL),
                      borderSide: const BorderSide(style: BorderStyle.none, width: 0),
                    ),
                    isDense: true,
                    hintText: AppData().language!.writeTheMessage,
                    fillColor: Color(0XFFF0F0F0),
                    hintStyle: openSansRegular.copyWith(fontSize: Dimensions.fontSizeSmall),
                    filled: true,

                  ),
                ),
                SizedBox(height: 10,),
                Align(
                  alignment: Alignment.center,
                  child: Container(
                    height: 35,
                    width: GetPlatform.isDesktop?mediaWidth*0.5:mediaWidth,
                    margin: EdgeInsets.symmetric(vertical: 20),
                    child: TextButton(
                      onPressed: sendMessage,

                      style: flatButtonStyle,
                      child: Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                        Text(AppData().language!.sendMessage.toUpperCase(), textAlign: TextAlign.center, style: openSansBold.copyWith(
                          color: textBtnColor,
                          fontSize: Dimensions.fontSizeDefault,
                        )),
                      ]),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),),
    );
  }
  Future<void> sendMessage() async {
    if(subject==null){
      showCustomSnackBar("Choose Subject");

    }
    else if(nameController.text.trim().isEmpty){
      showCustomSnackBar("Enter Name");

    }
    else if(emailController.text.trim().isEmpty){
      showCustomSnackBar("Enter Email");
    }
    else if(messageController.text.trim().isEmpty){
      showCustomSnackBar("Type Message");
    }
    else{
      openLoadingDialog(context, "Sending");
      var response;

      response = await DioService.post('contact_us_web', {
        "subject": subject,
        "name": nameController.text,
        "email": emailController.text,
        "message": messageController.text
      });
      if(response['status']=='success'){
        Navigator.pop(context);
        showCustomSnackBar(response['data'],isError: false);
        if(widget.fromMobile) {
          Navigator.pop(context);
        } else {
          Get.toNamed("/");
        }
      }
      else{
        print("2---------------error response-----------");
        Navigator.pop(context);
        showCustomSnackBar(response['message']);

      }
      nameController.clear();
      emailController.clear();
      messageController.clear();
      setState(() {

      });
    }

  }
}

