import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/src/extension_navigation.dart';
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
import 'package:knaw_news/view/base/web_menu_bar.dart';
import 'package:knaw_news/view/screens/profile/bookmarks.dart';
import 'package:knaw_news/view/screens/profile/show_post.dart';
import 'package:knaw_news/view/screens/profile/web/web_stats.dart';

class WebProfile extends StatefulWidget {
  int index;
  WebProfile({this.index=0});

  @override
  _WebProfileState createState() => _WebProfileState();
}

class _WebProfileState extends State<WebProfile> with TickerProviderStateMixin {
  UserDetail userDetail =UserDetail();
  late TabController _tabController;


  void initState() {
    super.initState();
      _tabController = TabController(length: 3, initialIndex: widget.index, vsync: this);

    print(AppData().userdetail!.toJson());
    WidgetsBinding.instance!.addPostFrameCallback((timeStamp) {
      getProfileDetail();
    });


  }
  @override
  Widget build(BuildContext context) {
    Size size=MediaQuery.of(context).size;
    double mediaWidth=size.width;
    mediaWidth/=2;
    return Scaffold(
      appBar: WebMenuBar(context: context,isSearch: false,isAuthenticated: true,isHalf: true,),
      body: SingleChildScrollView(
        physics: BouncingScrollPhysics(),
        child: Container(
          height: MediaQuery.of(context).size.height*1.2,
          child: Column(
            children: [
              Container(
                width: mediaWidth,
                color: Colors.white,
                alignment: Alignment.topCenter,
                child: Container(
                  width: mediaWidth*0.7,
                  margin: EdgeInsets.only(top: 20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Row(
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
                                  child: userDetail.profilePicture == null || userDetail.profilePicture == "" ?CustomImage(
                                    image: Images.placeholder,
                                    height: 120,
                                    width: 120,
                                    fit: BoxFit.cover,
                                  ):Image.network(
                                    userDetail.profilePicture!,
                                    width: 120,height: 120,fit: BoxFit.cover,
                                  ),
                                ),
                                userDetail.userVerified==null?SizedBox():userDetail.userVerified?Positioned(
                                  bottom: 5, right: 5,
                                  child: SvgPicture.asset(Images.badge,),
                                ):SizedBox(),
                              ],
                            ),

                          ),
                          SizedBox(width: 20,),
                          Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(userDetail.userName??"Name",style: openSansBold.copyWith(color:Colors.black,fontSize: Dimensions.fontSizeSmall),),

                              Text("${AppData().language!.joined} "+userDetail.joinedSince.toString(),style: openSansRegular.copyWith(color:textColor,fontSize: Dimensions.fontSizeExtraSmall),),
                              Row(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.symmetric(vertical: 15.0),
                                    child: SvgPicture.asset(Images.followers,color: Colors.black,),
                                  ),
                                  SizedBox(width: 5,),
                                  Text(AppData().language!.followers,style: openSansRegular.copyWith(color:Colors.black,fontSize: Dimensions.fontSizeExtraSmall),),
                                  SizedBox(width: 5,),
                                  Text(userDetail.totalFollowers.toString(),style: openSansRegular.copyWith(color:Colors.black,fontSize: Dimensions.fontSizeExtraSmall),),
                                ],
                              ),
                              Container(
                                height: 35,
                                width: mediaWidth*0.3,
                                child: TextButton(
                                  onPressed: (){
                                    Get.toNamed("/WebPostScreen");
                                  },
                                  style: webFlatButtonStyle,
                                  child: Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                                    Text(AppData().language!.createPost, textAlign: TextAlign.center, style: openSansBold.copyWith(
                                      color: textBtnColor,
                                      fontSize: Dimensions.fontSizeDefault,
                                    )),
                                  ]),
                                ),
                              ),

                            ],
                          ),

                        ],
                      ),
                      Container(
                        alignment: Alignment.topLeft,
                          padding: EdgeInsets.symmetric(vertical: 10),
                          child: Text(userDetail.description??'',style: openSansRegular.copyWith(color:Colors.black,fontSize: Dimensions.fontSizeExtraSmall),)
                      ),

                    ],
                  ),
                ),
              ),

              Container(
                //padding: EdgeInsets.all(2),
                margin: EdgeInsets.only(top: 10),

                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  color: Colors.white,
                ),
                child: Container(
                  height: 35,
                  // padding: EdgeInsets.all(3),
                  width: mediaWidth<500?mediaWidth:mediaWidth*0.7,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: Colors.white,
                  ),
                  child: TabBar(
                    dragStartBehavior: DragStartBehavior.down,
                    labelPadding: EdgeInsets.all(2),
                    controller: _tabController,
                    indicator: BoxDecoration(
                      color: Theme.of(context).primaryColor,
                      borderRadius: BorderRadiusDirectional.circular(20),
                    ),
                    indicatorColor:Theme.of(context).primaryColor,
                    indicatorWeight: 3,
                    labelColor:Colors.black,
                    unselectedLabelColor:Colors.black,
                    unselectedLabelStyle: openSansBold.copyWith(color: Theme.of(context).disabledColor, fontSize: Dimensions.fontSizeSmall),
                    labelStyle: openSansBold.copyWith(fontSize: Dimensions.fontSizeSmall, color: Theme.of(context).primaryColor),
                    tabs: [
                      Tab(text: AppData().language!.posts),
                      Tab(text: AppData().language!.bookmarks),
                      Tab(text: AppData().language!.stats),
                    ],
                  ),
                ),
              ),

              Expanded(
                child: TabBarView(
                  controller: _tabController,
                  children: [
                    ShowPost(userId: AppData().userdetail!.usersId),
                    Bookmarks(userId: AppData().userdetail!.usersId,),
                    WebStats(userId: AppData().userdetail!.usersId,),
                    // WebStats(userId: AppData().userdetail!.usersId,),
                    // WebStats(userId: AppData().userdetail!.usersId,),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
  Future<void> getProfileDetail() async {
    var response;
    openLoadingDialog(context, "Loading");
    response = await DioService.post('get_loggedin_profile_details', {
      "usersId" : AppData().userdetail!.usersId
    });
    if(response['status']=='success'){
      var jsonData= response['data'];
      userDetail  =  UserDetail.fromJson(jsonData);
      print(userDetail.toJson());
      print(userDetail.userVerified);

      Navigator.pop(context);
      setState(() {});
      // showCustomSnackBar(response['status'],isError: false);
    }
    else{
      Navigator.pop(context);
      setState(() {

      });
      // showCustomSnackBar(response['message']);

    }
  }

}

