import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:knaw_news/mixin/data.dart';
import 'package:knaw_news/model/language_model.dart';
import 'package:knaw_news/services/dio_service.dart';
import 'package:knaw_news/util/dimensions.dart';
import 'package:knaw_news/util/images.dart';
import 'package:knaw_news/util/styles.dart';
import 'package:knaw_news/view/base/custom_snackbar.dart';
import 'package:knaw_news/view/base/loading_dialog.dart';
import 'package:knaw_news/view/screens/home/home.dart';
import 'package:knaw_news/view/screens/language/widget/language_card.dart';
import 'package:knaw_news/view/screens/menu/app_bar.dart';
import 'package:knaw_news/view/screens/menu/drawer.dart';

class LanguageScreen extends StatefulWidget {
  LanguageScreen({Key? key,}) : super(key: key);

  @override
  State<LanguageScreen> createState() => _LanguageScreenState();
}

class _LanguageScreenState extends State<LanguageScreen> {
  List<String> availableLanguages=[];
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    WidgetsBinding.instance!.addPostFrameCallback((timeStamp) {
      getAvailableLanguages();
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: new MyDrawer(),
      appBar: new CustomAppBar(leading: Images.menu,title: AppData().language!.language,isTitle: true,isSuffix: false,),
      body: SafeArea(child: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        padding: const EdgeInsets.symmetric(vertical:Dimensions.PADDING_SIZE_EXTRA_SMALL),
        child: Center(
          child: Container(
            width: MediaQuery.of(context).size.width*0.98,
            child: ListView.builder(
                physics: BouncingScrollPhysics(),
                shrinkWrap: true,
                itemCount: availableLanguages.length,
                itemBuilder: (context,index){
                  return LanguageCard(icon: "", title: availableLanguages[index],onTapSelect: () => updateLanguage(availableLanguages[index]),);
                }
            ),
          ),
        ),
      ),),
    );
  }
  void getAvailableLanguages() async {
    openLoadingDialog(context, "Loading");
    var response;
    response = await DioService.get('language_type');
    if(response['status']=='success'){
      var jsonData= response['data'] as List;
      jsonData.map((e) => availableLanguages.add(e)).toList();
      print(availableLanguages);
      Navigator.pop(context);
      setState(() {});

    }
    else{
      Navigator.pop(context);
      print(response['message']);
      // showCustomSnackBar(response['message']);
    }
  }
  void updateLanguage(String language) async {
    openLoadingDialog(context, "Loading");
    var response;
    response = await DioService.post('get_language', {
      "language":language
    });
    if(response['status']=='success'){
      var jsonData= response['data'];
      Language language   =  Language.fromJson(jsonData);
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
}

