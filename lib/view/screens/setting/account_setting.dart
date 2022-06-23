import 'package:flutter/material.dart';
import 'package:flutter_switch/flutter_switch.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/src/extension_navigation.dart';
import 'package:get/get_utils/get_utils.dart';
import 'package:knaw_news/mixin/data.dart';
import 'package:knaw_news/services/dio_service.dart';
import 'package:knaw_news/util/dimensions.dart';
import 'package:knaw_news/util/styles.dart';
import 'package:knaw_news/view/base/custom_snackbar.dart';
import 'package:knaw_news/view/base/loading_dialog.dart';
import 'package:knaw_news/view/screens/menu/appbar_with_back.dart';
import 'package:knaw_news/view/screens/setting/setting.dart';

class AccountSetting extends StatefulWidget {
  const AccountSetting({Key? key}) : super(key: key);

  @override
  _AccountSettingState createState() => _AccountSettingState();
}

class _AccountSettingState extends State<AccountSetting> {
  double minPrice = 0;
  double maxPrice = 100;
  double _lowerValue = 0;
  bool isActive=false;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _lowerValue=AppData().userdetail!.newsRadius!.toDouble();
    isActive=AppData().userdetail!.notificationStatus=="False"?false:true;
    print("  -----------------------active  -------------");
    print(isActive);
  }

  @override
  Widget build(BuildContext context) {
    return GetPlatform.isDesktop?Container(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Container(
            alignment: Alignment.centerLeft,
            child: ListTile(
              title: Text(AppData().language!.notifications,style: openSansRegular.copyWith(color: Colors.black87,fontSize: Dimensions.fontSizeSmall),),
              trailing: Container(
                height: 25,
                width: 45,
                child: FlutterSwitch(
                  height: 25.0,
                  width: 38.0,
                  padding: 2.0,
                  inactiveToggleColor: Colors.black,
                  activeToggleColor: Theme.of(context).primaryColor,
                  toggleSize: 25.0,
                  borderRadius: 15.0,
                  value: isActive,
                  inactiveColor: Theme.of(context).disabledColor.withOpacity(0.5),
                  activeColor: Colors.black,
                  onToggle: (v) {
                    setState(() {
                      isActive=v;
                    });
                  },
                ),
              ),
            ),
          ),
          SizedBox(height: 20),
          Container(
            height: 35,
            width: MediaQuery.of(context).size.width*0.2,
            child: TextButton(
              onPressed: () => updateSetting(),
              style: flatButtonStyle,
              child: Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                Text(AppData().language!.Save, textAlign: TextAlign.center, style: openSansBold.copyWith(
                  color: textBtnColor,
                  fontSize: Dimensions.fontSizeSmall,
                )),
              ]),
            ),
          ),
        ],
      ),
    ):
    Scaffold(
      appBar: AppBarWithBack(title: AppData().language!.accountSetting,isTitle: true,isSuffix: false,),
      //backgroundColor:Get.isDarkMode ? Colors.black : Colors.white,
      body: SafeArea(child: Scrollbar(
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          padding: const EdgeInsets.all(Dimensions.PADDING_SIZE_SMALL),
          child: Center(
            child: Container(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[

                  Container(
                    padding: EdgeInsets.symmetric(horizontal: MediaQuery.of(context).size.width*0.03),
                    alignment: Alignment.centerLeft,
                    child: ListTile(
                      title: Text(AppData().language!.notifications,style: openSansRegular.copyWith(color: textColor,),),
                      trailing: Container(
                        height: 25,
                        width: 45,
                        child: FlutterSwitch(
                          height: 25.0,
                          width: 38.0,
                          padding: 2.0,
                          inactiveToggleColor: Colors.black,
                          activeToggleColor: Theme.of(context).primaryColor,
                          toggleSize: 25.0,
                          borderRadius: 15.0,
                          value: isActive,
                          inactiveColor: Theme.of(context).disabledColor.withOpacity(0.5),
                          activeColor: Colors.black,
                          onToggle: (v) {
                            setState(() {
                              isActive=v;
                            });
                          },
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: MediaQuery.of(context).size.height*0.2,),
                  Container(
                    height: 45,
                    width: MediaQuery.of(context).size.width*0.7,
                    child: TextButton(
                      onPressed: () => updateSetting(),
                      style: flatButtonStyle,
                      child: Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                        Text(AppData().language!.update, textAlign: TextAlign.center, style: openSansBold.copyWith(
                          color: textBtnColor,
                          fontSize: Dimensions.fontSizeDefault,
                        )),
                      ]),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),),
    );
  }
  Future<void> updateSetting() async {

    openLoadingDialog(context, "Updating");
    var response;
    response = await DioService.post('update_profile_settings', {
      "userId":AppData().userdetail!.usersId,
      "notificationStatus":isActive?"True":"False"
    });
    if(response['status']=='success'){
      AppData().userdetail!.newsRadius= _lowerValue.floor();
      AppData().userdetail!.notificationStatus= isActive?"True":"False";
      AppData().update();
      print( AppData().userdetail!.newsRadius);
      print(AppData().userdetail!.toJson());
      Navigator.pop(context);
      showCustomSnackBar(response['data'],isError: false);
      GetPlatform.isDesktop?null:Get.to(() => SettingScreen());
    }
    else{
      Navigator.pop(context);
      print(response['status']);
      showCustomSnackBar(response['message']);
    }
  }
}

