import 'package:flutter/material.dart';
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

class WebAbout extends StatefulWidget {
  const WebAbout({Key? key}) : super(key: key);

  @override
  State<WebAbout> createState() => _WebAboutState();
}

class _WebAboutState extends State<WebAbout> {
  Future<AboutModel>? aboutModel;
  String about="";
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    WidgetsBinding.instance!.addPostFrameCallback((timeStamp) {
      getAbout();
    });
  }
  @override
  Widget build(BuildContext context) {
    Size size=MediaQuery.of(context).size;
    double mediaWidth=size.width;
      mediaWidth/=2;
    return Scaffold(
      appBar: WebMenuBar(context: context,isAuthenticated: AppData().isAuthenticated,isSearch: false,isHalf: true,),
      body: SafeArea(child: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        padding: EdgeInsets.symmetric(vertical:Dimensions.PADDING_SIZE_DEFAULT),
        child: Center(
          child: Container(
            width: mediaWidth,
            alignment: Alignment.centerLeft,

            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(AppData().language!.about,style: openSansBold),
                SizedBox(height: 15,),
                Text(about,style: openSansRegular.copyWith(color: textColor,fontSize: Dimensions.fontSizeExtraSmall),),
              ],
            ),
          ),
        ),
      ),),
    );
  }
  Future<void> getAbout() async {
    openLoadingDialog(context, "Loading");
    aboutModel=AboutServices().get();
    print(aboutModel.toString());
    await aboutModel!.then((value) {
      if(value.status=="success"){
        about=value.data!;
        setState(() {

        });

      }
      else {
        setState(() {

        });
      }
    });
    Navigator.pop(context);

  }
}

