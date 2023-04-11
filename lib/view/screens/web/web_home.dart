import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/src/extension_navigation.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_notifier.dart';
import 'package:get/get_utils/src/extensions/internacionalization.dart';
import 'package:knaw_news/mixin/data.dart';
import 'package:knaw_news/model/follow_model.dart';
import 'package:knaw_news/model/post_model.dart';
import 'package:knaw_news/model/signup_model.dart';
import 'package:knaw_news/services/dio_service.dart';
import 'package:knaw_news/util/app_constants.dart';
import 'package:knaw_news/util/dimensions.dart';
import 'package:knaw_news/util/images.dart';
import 'package:knaw_news/util/styles.dart';
import 'package:knaw_news/view/base/custom_button.dart';
import 'package:knaw_news/view/base/custom_image.dart';
import 'package:knaw_news/view/base/custom_snackbar.dart';
import 'package:knaw_news/view/base/loading_dialog.dart';
import 'package:knaw_news/view/base/no_data_screen.dart';
import 'package:knaw_news/view/base/web_menu_bar.dart';
import 'package:knaw_news/view/screens/auth/social_login.dart';
import 'package:knaw_news/view/screens/auth/web/web_sign_in.dart';
import 'package:knaw_news/view/screens/dashboard/widget/bottom_nav_item.dart';
import 'package:knaw_news/view/screens/home/widget/full_transition.dart';
import 'package:knaw_news/view/screens/home/widget/report_dialog.dart';
import 'package:knaw_news/view/screens/home/widget/small_transition.dart';
import 'package:knaw_news/view/screens/home/widget/vertical_tile.dart';
import 'package:knaw_news/view/screens/menu/app_bar.dart';
import 'package:knaw_news/view/screens/menu/drawer.dart';
import 'package:knaw_news/view/screens/post/create_post_screen.dart';
import 'package:knaw_news/view/screens/post/widget/category_item.dart';
import 'package:knaw_news/view/screens/profile/follow_profile.dart';
import 'package:knaw_news/view/screens/profile/profile_screen.dart';
import 'package:knaw_news/view/screens/profile/web/web_follow_profile.dart';
import 'package:knaw_news/view/screens/search/search_screen.dart';
import 'package:knaw_news/view/screens/web/initial_screen.dart';
import 'package:knaw_news/view/screens/web/widget/follow_card.dart';
import 'package:knaw_news/view/screens/web/widget/help.dart';
import 'package:knaw_news/view/screens/web/widget/recent_post.dart';
import 'package:knaw_news/view/screens/web/widget/user_info.dart';
import 'package:knaw_news/view/screens/web/widget/web_sidebar.dart';


class WebHome extends StatefulWidget  {

  WebHome({Key? key,}) : super(key: key);

  @override
  State<WebHome> createState() => _WebHomeState();
}

class _WebHomeState extends State<WebHome> with TickerProviderStateMixin {
  ScrollController scrollController=ScrollController();
  TabController? _tabController;
  List <Placemark>? plackmark;
  String address="";
  String country="";
  Position position=Position(longitude: 0, latitude: 0, timestamp: DateTime.now(),
      accuracy: 1, altitude: 1, heading: 1, speed: 1, speedAccuracy: 1);
  int selected=1;
  String categoryTag="";
  String category="Most Popular";
  String offset="0";
  bool isLoading=true;
  List<String> categoryList=["Most Popular","Happy","Sad","Your News Feed","Global News","Events","Business","Opinion","Technology", "Entertainment","Sports","Beauty","Science","Health","Local","National"];
  List<PostDetail>? postDetail;
  List<PostDetail>? recentPostDetail=[PostDetail()];
  List<FollowDetail>? followDetail;
  List<UserDetail>? suggestedDetail;
  int totalFollowers=0;
  int totalPost=-1;
  int totalSuggested=0;
  int totalRecentPost=0;


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _tabController = TabController(length: 16, initialIndex: 0, vsync: this,);
    _tabController!.addListener(_handleTabSelection);
    scrollController.addListener(_handleScroll);
    getLocation();
    recentPost();
    myFollowingList();
    getSuggestedUser();
    WidgetsBinding.instance!.addPostFrameCallback((timeStamp) {
      loadOtherPosts(isTap: false);
     });
  }
  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    scrollController.dispose();
  }
  void _handleTabSelection() {
    selected=_tabController!.index+1;
    setState(() {});
    category=categoryList[selected-1];
    selected>3?loadPosts(isTap: false):loadOtherPosts(isTap: false);
  }

  void _handleScroll() {

    if(scrollController.position.pixels >= scrollController.position.maxScrollExtent){
      print("max scroll");
      if(totalPost>int.parse(offset)+6) {
        offset = (int.parse(offset) +6).toString();
        print("load more");
        selected>3?loadPostsMore():loadOtherPostsMore();
      }
      else{
        print("post not avilable");
      }

    }
    else{
      print("no max scroll");
    }
  }

  @override
  Widget build(BuildContext context) {
    Size size=MediaQuery.of(context).size;
    double mediaWidth=size.width<1000?size.width:size.width*0.7;

    return Scaffold(
      appBar: WebMenuBar(context: context,isAuthenticated: true,),
      body: Scrollbar(
        interactive: true,
        controller: scrollController,
        showTrackOnHover: true,
        trackVisibility: true,
        isAlwaysShown: true,
        child: SafeArea(child: Center(
          child: Container(
            child: Column(
              children: [
                Container(
                  width: mediaWidth,
                  color: Colors.white,
                  padding: EdgeInsets.only(bottom: 5,left: 20,right: 20),
                  child: Row(
                    children: [
                      InkWell(
                          onTap: (){
                            if(_tabController!.index>0){
                              _tabController!.index--;
                            }
                          },
                          child: Icon(Icons.arrow_back_ios,size: 20,)
                      ),
                      Expanded(
                        child: SizedBox(
                          height: 40,
                          //width: 200,
                          child: TabBar(
                            controller: _tabController,
                            padding: EdgeInsets.zero,
                            labelPadding: EdgeInsets.symmetric(horizontal: 5),
                            indicatorPadding: EdgeInsets.zero,
                            isScrollable: true,
                            // indicator: BoxDecoration(
                            //   color: Theme.of(context).primaryColor,
                            //   borderRadius: BorderRadiusDirectional.circular(20),
                            // ),
                            indicatorWeight: 0.0001,
                            indicatorColor: Colors.white,
                            indicatorSize: TabBarIndicatorSize.label,
                            labelColor:Colors.black,
                            unselectedLabelColor:Colors.black,
                            unselectedLabelStyle: openSansBold.copyWith(color: Theme.of(context).disabledColor, fontSize: Dimensions.fontSizeSmall),
                            labelStyle: openSansBold.copyWith(fontSize: Dimensions.fontSizeSmall, color: Theme.of(context).primaryColor),
                            tabs: [
                              CategoryItem(title: AppData().language!.trending, icon: Images.star,isSelected: selected==1?true:false,onTap: (){selected=1;category="Most Popular";setState(() {});loadOtherPosts();},),
                              CategoryItem(title: AppData().language!.happy, icon: Images.happy,isSelected: selected==2?true:false,onTap: (){selected=2;category="Happy";setState(() {});loadOtherPosts();},),
                              CategoryItem(title: AppData().language!.gloomy, icon: Images.sad,isSelected: selected==3?true:false,onTap: (){selected=3;category="Sad";setState(() {});loadOtherPosts();},),
                              CategoryItem(title: AppData().language!.yourNewsFeed, icon: Images.local_news,isSelected: selected==4?true:false,onTap: (){selected=4;category="Your News Feed";setState(() {});loadPosts();},),
                              CategoryItem(title: AppData().language!.globalNews, icon: Images.global_news,isSelected: selected==5?true:false,onTap: (){selected=5;category="Global News";setState(() {});loadPosts();},),
                              CategoryItem(title: AppData().language!.events, icon: Images.event,isSelected: selected==6?true:false,onTap: (){selected=6;category="Events";setState(() {});loadPosts();},),
                              CategoryItem(title: AppData().language!.business, icon: Images.bussiness,isSelected: selected==7?true:false,onTap: (){selected=7;category="Business";setState(() {});loadPosts();},),
                              CategoryItem(title: AppData().language!.opinion, icon: Images.opinion,isSelected: selected==8?true:false,onTap: (){
                                selected=8;
                                category="Opinion";
                                setState(() {});
                                loadPosts();

                              },),
                              CategoryItem(title: AppData().language!.technology, icon: Images.technology,isSelected: selected==9?true:false,onTap: (){selected=9;category="Technology";setState(() {});loadPosts();},),
                              CategoryItem(title: AppData().language!.entertainment, icon: Images.entertainment,isSelected: selected==10?true:false,onTap: (){selected=10;category="Entertainment";setState(() {});loadPosts();},),
                              CategoryItem(title: AppData().language!.sports, icon: Images.sport,isSelected: selected==11?true:false,onTap: (){
                                selected=11;
                                category="Sports";
                                setState(() {});
                                loadPosts();
                              },),
                              CategoryItem(title: AppData().language!.beauty, icon: Images.beauty,isSelected: selected==12?true:false,onTap: (){
                                selected=12;
                                category="Beauty";
                                setState(() {});
                                loadPosts();
                              },),
                              CategoryItem(title: AppData().language!.science, icon: Images.science,isSelected: selected==13?true:false,onTap: (){
                                selected=13;
                                category="Science";
                                setState(() {});
                                loadPosts();
                              },),
                              CategoryItem(title: AppData().language!.health, icon: Images.health,isSelected: selected==14?true:false,onTap: (){
                                selected=14;
                                category="Health";
                                setState(() {});
                                loadPosts();
                              },),
                              CategoryItem(title: "Local", icon: Images.global_news,isSelected: selected==15?true:false,onTap: (){
                                selected=15;
                                category="Local";
                                setState(() {});
                                loadPosts();
                              },),
                              CategoryItem(title: "National", icon: Images.global_news,isSelected: selected==16?true:false,onTap: (){
                                selected=16;
                                category="National";
                                setState(() {});
                                loadPosts();
                              },),
                            ],

                          ),
                        ),
                      ),
                      SizedBox(width: 10,),
                      InkWell(
                        onTap: (){
                          if(_tabController!.index<16){
                            _tabController!.index++;
                          }
                        },
                        child: Icon(Icons.arrow_forward_ios,size: 20,),
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SingleChildScrollView(
                        child: Container(
                          color: Colors.white,
                          width: mediaWidth>710?mediaWidth*0.2:mediaWidth*0.4,
                          margin: EdgeInsets.only(right: mediaWidth*0.01,top: 10),
                          child: Column(
                            children: [
                              WebSideBar(isLogin: true,),
                              Container(
                                height: 10,
                                width: mediaWidth>710?mediaWidth*0.2:mediaWidth*0.4,
                                color: Color(0xFFF8F8FA),
                              ),
                              Text(AppData().language!.followingAccounts,style: openSansBold.copyWith(color: Colors.black,fontSize: Dimensions.fontSizeSmall),),
                              totalFollowers>0?Container(
                                width: mediaWidth>710?mediaWidth*0.2:mediaWidth*0.4,
                                child: ListView.builder(
                                    physics: NeverScrollableScrollPhysics(),
                                    shrinkWrap: true,
                                    //padding: EdgeInsetsGeometry.infinity,
                                    itemCount: followDetail!.length,
                                    itemBuilder: (context,index){
                                      return Column(
                                        children: [
                                          FollowCard(
                                            width: mediaWidth>710?mediaWidth*0.2:mediaWidth*0.4,
                                            icon: followDetail![index].followProfilePicture??'',
                                            title: followDetail![index].followUserName??'',
                                            isVerified: followDetail![index].userVerified,
                                            onTap: () => Get.to(() => WebFollowProfile(userId: followDetail![index].followingToUserId,)),
                                          ),
                                        ],
                                      );
                                    }
                                ),
                              ):Center(child: NoDataScreen(text: "No Following Found",)),
                              Container(
                                height: 10,
                                width: mediaWidth>710?mediaWidth*0.2:mediaWidth*0.4,
                                color: Color(0xFFF8F8FA),
                              ),
                              Text(AppData().language!.suggestedAccounts,style: openSansBold.copyWith(color: Colors.black,fontSize: Dimensions.fontSizeSmall),),
                              totalSuggested>0?Container(
                                width: mediaWidth>710?mediaWidth*0.2:mediaWidth*0.4,
                                child: ListView.builder(
                                    physics: NeverScrollableScrollPhysics(),
                                    shrinkWrap: true,
                                    //padding: EdgeInsetsGeometry.infinity,
                                    itemCount: suggestedDetail!.length,
                                    itemBuilder: (context,index){
                                      return Column(
                                        children: [
                                          FollowCard(
                                            width: mediaWidth>710?mediaWidth*0.2:mediaWidth*0.4,
                                            icon: suggestedDetail![index].profilePicture??'',
                                            title: suggestedDetail![index].userName??'',
                                            isVerified: suggestedDetail![index].userVerified,
                                            onTap: () => Get.to(() => WebFollowProfile(userId: suggestedDetail![index].usersId,)),
                                          ),
                                        ],
                                      );
                                    }
                                ),
                              ):Center(child: NoDataScreen(text: "No Suggested Found",)),
                              Container(
                                height: 30,
                                padding: EdgeInsets.only(left: mediaWidth*0.02,right: mediaWidth*0.01),
                                margin: EdgeInsets.only(top: 10,bottom: 10),
                                child: TextButton(
                                  onPressed: () {
                                    AppData().signOut();
                                    Get.offAll(() => InitialScreen());
                                  },
                                  style: webFlatButtonStyle,
                                  child: Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                                    Text(AppData().language!.logout.toUpperCase(), textAlign: TextAlign.center, style: openSansBold.copyWith(
                                      color: textBtnColor,
                                      fontSize: Dimensions.fontSizeExtraSmall,
                                    )),
                                  ]),
                                ),
                              ),
                              Container(
                                height: 10,
                                width: mediaWidth>710?mediaWidth*0.2:mediaWidth*0.4,
                                color: Color(0xFFF8F8FA),
                              ),
                              Container(
                                padding: EdgeInsets.only(left: mediaWidth*0.02),
                                child: Help(),
                              ),

                              Container(
                                height: 5,
                                width: mediaWidth*0.4,
                                color: Color(0xFFF8F8FA),
                              ),
                              mediaWidth<710?Container(
                                  color: Color(0xFFF8F8FA),
                                  width: mediaWidth*0.4,
                                  child: ListView.builder(
                                      physics: BouncingScrollPhysics(),
                                      shrinkWrap: true,
                                      //padding: EdgeInsetsGeometry.infinity,
                                      itemCount: recentPostDetail!.length,
                                      itemBuilder: (context,index){
                                        return Container(
                                          color: Colors.white,
                                          margin: EdgeInsets.only(top: 5),
                                          padding: EdgeInsets.symmetric(vertical: 5),
                                          child: Column(
                                            children: [
                                              index==0?Container(
                                                margin: EdgeInsets.symmetric(vertical: 5),
                                                child: Text(
                                                  AppData().language!.recentPosts,
                                                  maxLines: 1,
                                                  style: openSansBold.copyWith(fontSize: Dimensions.fontSizeExtraSmall,color: Colors.black,overflow: TextOverflow.ellipsis),
                                                ),
                                              ):SizedBox(),
                                              UserInfo(postDetail: recentPostDetail![index]),
                                              Align(
                                                alignment:Alignment.topLeft,
                                                child: Padding(
                                                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                                                  child: Text(
                                                    recentPostDetail![index].title??'',
                                                    maxLines: 2,
                                                    style: openSansRegular.copyWith(fontSize: Dimensions.fontSizeExtraSmall,color: Colors.black,overflow: TextOverflow.ellipsis),
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        );
                                      }
                                  )
                                //child: postDetail!=null?UserInfo(postDetail: postDetail!.first):SizedBox(),
                              ):SizedBox(),
                            ],
                          ),
                        ),
                      ),
                      //SizedBox(width: MediaQuery.of(context).size.width*0.01,),
                      Container(
                        width: mediaWidth*0.58,
                        child: totalPost>0?ListView.builder(
                            controller: scrollController,
                            physics: const BouncingScrollPhysics(),
                            shrinkWrap: true,
                            //padding: EdgeInsetsGeometry.infinity,
                            itemCount: postDetail!.length,
                            itemBuilder: (context,index){
                              return FullTransition(postDetail: postDetail![index],);

                            }
                        ):Center(child: NoDataScreen()),
                      ),
                      //SizedBox(width: MediaQuery.of(context).size.width*0.01,),
                      mediaWidth>710?SingleChildScrollView(
                        child: Container(
                            width: mediaWidth*0.2,
                            margin: EdgeInsets.only(left: mediaWidth*0.01),
                            child: totalRecentPost>0?ListView.builder(
                                physics: NeverScrollableScrollPhysics(),
                                shrinkWrap: true,
                                //padding: EdgeInsetsGeometry.infinity,
                                itemCount: recentPostDetail!.length,
                                itemBuilder: (context,index){
                                  return Container(
                                    color: Colors.white,
                                    margin: EdgeInsets.only(top: 5),
                                    padding: index==0?EdgeInsets.only(bottom: 5):EdgeInsets.symmetric(vertical: 5),
                                    child: Column(
                                      children: [
                                        index==0?Container(
                                          height: 5,
                                          width: mediaWidth*0.2,
                                          color: Color(0xFFF8F8FA),
                                        ):SizedBox(),
                                        index==0?Container(
                                          margin: EdgeInsets.symmetric(vertical: 5),
                                          child: Text(
                                            AppData().language!.recentPosts,
                                            maxLines: 1,
                                            style: openSansBold.copyWith(fontSize: Dimensions.fontSizeExtraSmall,color: Colors.black,overflow: TextOverflow.ellipsis),
                                          ),
                                        ):SizedBox(),
                                        UserInfo(postDetail: recentPostDetail![index]),
                                        InkWell(
                                          onTap:(){
                                            Get.to(RecentPost(postDetail: recentPostDetail![index]));
                                          },
                                          child: Align(
                                            alignment:Alignment.topLeft,
                                            child: Padding(
                                              padding: const EdgeInsets.symmetric(horizontal: 8.0),
                                              child: Text(
                                                recentPostDetail![index].title??'',
                                                maxLines: 2,
                                                style: openSansRegular.copyWith(fontSize: Dimensions.fontSizeExtraSmall,color: Colors.black,overflow: TextOverflow.ellipsis),
                                              ),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  );
                                }
                            ):
                            Center(child: NoDataScreen(text: "No Recent Post Found",))
                          //child: postDetail!=null?UserInfo(postDetail: postDetail!.first):SizedBox(),
                        ),
                      ):SizedBox(),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),),
      ),
    );
  }
  Future<void> loadPosts({bool isTap=true}) async {
    offset="0";
    print(AppData().userdetail!.toJson());
    _tabController!.index=selected-1;
    if(isTap){
      return;
    }
    openLoadingDialog(context, "Loading");
    print("url ${AppConstants.apiUrl}all_news_with_base_filter");
    print("usersId ${AppData().userdetail!.usersId}");
    print("offset ${offset}");
    print("category ${category}");
    print("userCountry ${AppData().userdetail!.country}");

    var response;
    response = await DioService.post('all_news_with_base_filter', {
      "usersId" : AppData().userdetail!.usersId,
      "offset": offset,
      "category": category,
      if(categoryTag.isNotEmpty)"categoryTag": categoryTag,
      "userCountry": AppData().userdetail!.country,
      "userLat":0.00,
      "userLong":0.00
    });
    print("ststus: ${response['status']}");
    if(response['status']=='success'){
      var jsonData= response['data'] as List;
      print("category: ${jsonData}");
     postDetail=  jsonData.map<PostDetail>((e) => PostDetail.fromJson(e)).toList();
      Navigator.pop(context);
      setState(() {

      });
      // showCustomSnackBar(postDetail![0].title??'');
      totalPost=int.tryParse(response['total_posts'].toString())!;
      print(totalPost.toString());
    }
    else{
      Navigator.pop(context);
      setState(() {

      });
      //showCustomSnackBar(response['message']);
      totalPost=0;
      print(totalPost.toString());

    }
    isLoading=false;
  }

  Future<void> loadPostsMore() async {
    print(AppData().userdetail!.toJson());
    _tabController!.index=selected-1;
    openLoadingDialog(context, "Loading");
    var response;
    response = await DioService.post('all_news_with_base_filter', {
      "usersId" : AppData().userdetail!.usersId,
      "offset": offset,
      "category": category,
      if(categoryTag.isNotEmpty)"categoryTag": categoryTag,
      "userCountry": AppData().userdetail!.country,
      "userLat":0.00,
      "userLong":0.00
    });
    if(response['status']=='success'){
      var jsonData= response['data'] as List;
      postDetail!.addAll(jsonData.map<PostDetail>((e) => PostDetail.fromJson(e)).toList());
      Navigator.pop(context);
      setState(() {

      });
      // showCustomSnackBar(postDetail![0].title??'');
      totalPost=int.tryParse(response['total_posts'].toString())!;
      print(totalPost.toString());
    }
    else{
      Navigator.pop(context);
      setState(() {

      });
      // showCustomSnackBar(response['message']);
      totalPost=0;
      print(totalPost.toString());

    }
    isLoading=false;
  }

  Future<void> loadOtherPosts({bool isTap=true}) async {

    offset="0";
    print(AppData().userdetail!.toJson());
    _tabController!.index=selected-1;
    if(isTap){
      return;
    }
    openLoadingDialog(context, "Loading");
    var response;
    response = await DioService.post('all_news_with_other_filter', {
      "usersId" : AppData().userdetail!.usersId,
      "offset": offset,
      "otherCategory": category,
      if(categoryTag.isNotEmpty)"categoryTag": categoryTag,
      "userCountry": AppData().userdetail!.country
    });
    if(response['status']=='success'){
      var jsonData= response['data'] as List;
      postDetail=  jsonData.map<PostDetail>((e) => PostDetail.fromJson(e)).toList();
      print(AppData().userdetail!.usersId);
      Navigator.pop(context);
      setState(() {

      });
      // showCustomSnackBar(postDetail![0].title??'');
      totalPost=int.tryParse(response['total_posts'].toString())!;
      print(totalPost.toString());
    }
    else{
      Navigator.pop(context);
      setState(() {

      });
      //showCustomSnackBar(response['message']);
      totalPost=0;
      print(totalPost.toString());

    }
    isLoading=false;
  }

  Future<void> loadOtherPostsMore() async {
    print(AppData().userdetail!.toJson());
    _tabController!.index=selected-1;
    openLoadingDialog(context, "Loading");
    var response;
    response = await DioService.post('all_news_with_other_filter', {
      "usersId" : AppData().userdetail!.usersId,
      "offset": offset,
      "otherCategory": category,
      if(categoryTag.isNotEmpty)"categoryTag": categoryTag,
      "userCountry": AppData().userdetail!.country
    });
    if(response['status']=='success'){
      var jsonData= response['data'] as List;
      postDetail!.addAll(jsonData.map<PostDetail>((e) => PostDetail.fromJson(e)).toList());
      print(AppData().userdetail!.usersId);
      Navigator.pop(context);
      setState(() {

      });
      // showCustomSnackBar(postDetail![0].title??'');
      totalPost=int.tryParse(response['total_posts'].toString())!;
      print(totalPost.toString());
    }
    else{
      Navigator.pop(context);
      setState(() {

      });
      // showCustomSnackBar(response['message']);
      totalPost=0;
      print(totalPost.toString());

    }
    isLoading=false;
  }


  Future<void> recentPost() async {
    var response;
    response = await DioService.post('get_recent_posts_web', {
      "usersId" : AppData().userdetail!.usersId
    });
    if(response['status']=='success'){
      var jsonData= response['data'] as List;
      recentPostDetail=  jsonData.map<PostDetail>((e) => PostDetail.fromJson(e)).toList();
      totalRecentPost=recentPostDetail!.length;
      setState(() {

      });
    }
    else{
      totalRecentPost=0;
      setState(() {

      });

    }
    isLoading=false;
  }

  Future<void> myFollowingList() async {
    var response;
    response = await DioService.post('get_all_following_web', {
      "usersId" : AppData().userdetail!.usersId,
      "offset": "0"
    });
    if(response['status']=='success'){
      var jsonData= response['data'] as List;
      followDetail=  jsonData.map<FollowDetail>((e) => FollowDetail.fromJson(e)).toList();
      totalFollowers=followDetail!.length;
      setState(() {

      });
    }
    else{
      totalFollowers=-1;
    }
  }

  Future<void> getSuggestedUser() async {
    var response;
    response = await DioService.post('get_suggested_accounts', {
      "usersId" : AppData().userdetail!.usersId,
    });
    if(response['status']=='success'){
      var jsonData= response['data'] as List;
      suggestedDetail=  jsonData.map<UserDetail>((e) => UserDetail.fromJson(e)).toList();
      totalSuggested=suggestedDetail!.length;
      setState(() {

      });
    }
    else{
      totalSuggested=-1;
    }
  }


  Future<Position> _determinePosition() async {
    bool serviceEnabled;
    LocationPermission permission;
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      return Future.error('Location services are disabled.');
    }
    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return Future.error('Location permissions are denied');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      return Future.error(
          'Location permissions are permanently denied, we cannot request permissions.');
    }
    return await Geolocator.getCurrentPosition();
  }

  Future<void> getLocation() async {

      position=await _determinePosition();
      await convertToAddress(position.latitude, position.longitude, AppConstants.apiKey);
      //plackmark= await placemarkFromCoordinates(position.latitude, position.longitude);
      //address="${plackmark!.first.subLocality}${plackmark!.first.locality}";

      //position=await _determinePosition();
      //plackmark= await placemarkFromCoordinates(position.latitude, position.longitude);
      //address="${plackmark!.first.subLocality}${plackmark!.first.locality}";

    print("getLocation");
    print("address"+address);
    if(AppData().userdetail!.address.isEmpty){
      AppData().userdetail!.address=address;
      AppData().userdetail!.country=country;
      AppData().userdetail!.latitude=position.latitude;
      AppData().userdetail!.longitude=position.longitude;
      //loadOtherPosts(isTap: false);
    }
    else{
      AppData().userdetail!.address=address;
      AppData().userdetail!.country=country;
      AppData().userdetail!.latitude=position.latitude;
      AppData().userdetail!.longitude=position.longitude;
    }
    AppData().update();

  }
  convertToAddress(double lat, double long, String apikey) async {
    Dio dio = Dio();  //initilize dio package
    String apiurl = "https://maps.googleapis.com/maps/api/geocode/json?latlng=$lat,$long&key=$apikey";

    var response = await dio.get(apiurl); //send get request to API URL

    //print(response.data);

    if(response.statusCode == 200){ //if connection is successful
      Map data = response.data; //get response data
      if(data["status"] == "OK"){ //if status is "OK" returned from REST API
        if(data["results"].length > 0){ //if there is atleast one address
          Map firstresult = data["results"][0]; //select the first address

          address = firstresult["formatted_address"];
          List<String> list=address.split(',');
          print("this is country name");
          print(list.last);
          country = list.last.trim();
          print(firstresult["geometry"]["location"]);



          //showCustomSnackBar(address,isError: false);//get the address

          //you can use the JSON data to get address in your own format

          setState(() {
            //refresh UI
          });
        }
      }else{
        print(data["error_message"]);
      }
    }else{
      print("error while fetching geoconding data");
    }
  }
}
