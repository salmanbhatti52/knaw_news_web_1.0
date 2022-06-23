import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:knaw_news/mixin/data.dart';
import 'package:knaw_news/model/notification_model.dart';
import 'package:knaw_news/services/dio_service.dart';
import 'package:knaw_news/util/dimensions.dart';
import 'package:knaw_news/util/images.dart';
import 'package:knaw_news/util/styles.dart';
import 'package:knaw_news/view/base/custom_snackbar.dart';
import 'package:knaw_news/view/base/loading_dialog.dart';
import 'package:knaw_news/view/base/no_data_screen.dart';
import 'package:knaw_news/view/base/web_menu_bar.dart';
import 'package:knaw_news/view/screens/dashboard/dashboard_screen.dart';
import 'package:knaw_news/view/screens/inbox/widget/friend_widget.dart';
import 'package:knaw_news/view/screens/inbox/widget/web_friend_widget.dart';
import 'package:knaw_news/view/screens/menu/app_bar.dart';
import 'package:knaw_news/view/screens/menu/drawer.dart';
import 'package:knaw_news/view/screens/dashboard/widget/bottom_nav_item.dart';
import 'package:knaw_news/view/screens/profile/follow_profile.dart';

class WebInbox extends StatefulWidget {
  const WebInbox({Key? key}) : super(key: key);

  @override
  State<WebInbox> createState() => _WebInboxState();
}

class _WebInboxState extends State<WebInbox> {
  NotificationModel? notificationModel;
  int offset=0;
  int total=0;
  int yesterdayTotal=0;
  int thisWeekTotal=0;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    WidgetsBinding.instance!.addPostFrameCallback((timeStamp) {
      getAllInboxNotification();
    });
  }
  @override
  Widget build(BuildContext context) {
    Size size=MediaQuery.of(context).size;
    double mediaWidth=size.width;
    mediaWidth/=2;
    return Scaffold(
      appBar: WebMenuBar(context: context,isAuthenticated: true,isSearch: false,),
      body: SafeArea(child: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        padding: EdgeInsets.symmetric(vertical:Dimensions.PADDING_SIZE_EXTRA_SMALL),
        child: Center(
          child: Container(
            width: mediaWidth,
            child: total>0?Column(
              children: [
                //Yesterday Notification
                yesterdayTotal>0?Container(
                  padding: EdgeInsets.only(left: mediaWidth*0.04),
                  alignment: Alignment.centerLeft,
                  child: Text(
                    "Yesterday",
                    style: openSansRegular.copyWith(color: textColor,fontSize: Dimensions.fontSizeSmall,),
                  ),
                ):SizedBox(),

                yesterdayTotal>0?ListView.builder(
                    physics: NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    itemCount: notificationModel!.yesterdayNotifications!.length,
                    itemBuilder: (context,index){
                      return WebFriendCard(notificationDetail: notificationModel!.yesterdayNotifications![index],);
                    }
                ):SizedBox(),


                // This week Notification
                thisWeekTotal>0?Container(
                  padding: EdgeInsets.only(left: mediaWidth*0.04),
                  alignment: Alignment.centerLeft,
                  child: Text(
                    "This Week",
                    style: openSansRegular.copyWith(color: textColor,fontSize: Dimensions.fontSizeSmall,),
                  ),
                ):SizedBox(),

                thisWeekTotal>0?ListView.builder(
                    physics: NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    //padding: EdgeInsetsGeometry.infinity,
                    itemCount: notificationModel!.thisWeekNotifications!.length,
                    itemBuilder: (context,index){
                      return WebFriendCard(notificationDetail: notificationModel!.thisWeekNotifications![index],);

                    }
                ):SizedBox(),

              ],
            ):Center(child: NoDataScreen(text: "No Notification Found",)),
          ),
        ),
      ),),
    );
  }
  Future<void> getAllInboxNotification() async {
    openLoadingDialog(context, "Loading");
    var response;
    response = await DioService.post('get_all_inbox_notifications', {
      "usersId" : AppData().userdetail!.usersId
    });
    if(response['status']=='success'){
      var jsonData= response['data'];
      notificationModel=  NotificationModel.fromJson(jsonData);
      yesterdayTotal=notificationModel!.yesterdayNotifications!.length;
      thisWeekTotal=notificationModel!.thisWeekNotifications!.length;
      total=yesterdayTotal+thisWeekTotal;
      Navigator.pop(context);
      setState(() {

      });
    }
    else{
      Navigator.pop(context);
      showCustomSnackBar(response['message']);

    }
  }
}
