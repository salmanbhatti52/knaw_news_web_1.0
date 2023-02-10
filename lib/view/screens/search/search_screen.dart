import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/src/extension_navigation.dart';
import 'package:get/get_utils/src/extensions/internacionalization.dart';
import 'package:knaw_news/mixin/data.dart';
import 'package:knaw_news/model/post_model.dart';
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
import 'package:knaw_news/view/screens/auth/social_login.dart';
import 'package:knaw_news/view/screens/home/home.dart';
import 'package:knaw_news/view/screens/home/widget/full_transition.dart';
import 'package:knaw_news/view/screens/home/widget/small_transition.dart';
import 'package:knaw_news/view/screens/menu/app_bar.dart';
import 'package:knaw_news/view/screens/search/widget/search_field.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:knaw_news/view/screens/search/widget/search_filter.dart';

class SearchScreen extends StatefulWidget {
  @override
  _SearchScreenState createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final TextEditingController _searchController = TextEditingController();
  bool isSearch=false;
  bool isView=false;
  String tagFilter="";
  String dateFilter="";
  String titleFilter="";
  String orderBy="DESC";
  String locationPostal="";
  String dateRangePreset="";
  bool isDate=false;
  int selectedDay=-1;
  List<RecentDetail>? recentDetail;
  List<PostDetail>? postDetail;
  int totalPost=-1;
  bool isShow=false;
  bool isExtend=true;
  int ind=-1;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance!.addPostFrameCallback((timeStamp) {
      getRecentSearchPost();
    });

  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        return true;
      },
      child: Scaffold(
        //backgroundColor: Color(0XFFF8F8FA),
        appBar: CustomAppBar(title: AppData().language!.search, leading: Images.arrow_back,suffix:Images.search_filter,isBack: true,isTitle: true,suffixTap: () => Get.dialog(SearchFilter(
          tag: tagFilter,
          selected: selectedDay,
          order: orderBy,
          loc: locationPostal,
          datePreset: dateRangePreset,
          isCustom: isDate,
          applyFilter: (tag,date,selected,order,location,dateRange,isCustomDate){
            tagFilter=tag;
            dateFilter=date;
            selectedDay=selected;
            orderBy=order;
            locationPostal=location;
            dateRangePreset=dateRange;
            isDate=isCustomDate;
            isShow=false;
            searchPost();
            isSearch=true;
          },
        )),),
        body: SafeArea(child: Scrollbar(
          child: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            padding: const EdgeInsets.all(Dimensions.PADDING_SIZE_SMALL),
            child: Center(
              child: Column(children: [
                Center(
                  child: SizedBox(
                    width: MediaQuery.of(context).size.width*0.9,
                    child: Row(children: [
                      Expanded(
                        child: SearchField(
                          controller: _searchController,
                          onChanged: (val) {
                            isShow=false;
                            if(val==""){
                              isSearch=false;
                              titleFilter=val;
                              totalPost=recentDetail!.length;
                              setState(() {

                              });
                            }
                            else{
                              isSearch=true;
                              titleFilter=val;
                              searchPost();
                            }
                          },
                        ),
                      ),
                      Container(
                        width: 50,
                        height: 54,
                        decoration: BoxDecoration(
                            color: Colors.grey.withOpacity(0.15),
                            borderRadius: BorderRadius.only(topRight: Radius.circular(10),bottomRight: Radius.circular(10))
                        ),
                        padding: const EdgeInsets.all(14.0),
                        child: SvgPicture.asset(Images.search,color: textColor),
                      ),
                    ],
                    ),
                  ),
                ),

                isShow?InkWell(child:
                FullTransition(
                  postDetail: isSearch?postDetail![ind]:recentDetail![ind].postDetail,
                )
                ):SingleChildScrollView(
                  physics: BouncingScrollPhysics(),
                  padding: EdgeInsets.symmetric(horizontal: Dimensions.PADDING_SIZE_EXTRA_SMALL),
                  child: SizedBox(width: MediaQuery.of(context).size.width, child: Column(crossAxisAlignment: CrossAxisAlignment.center, children: [

                    isSearch?SizedBox():Container(
                      alignment: Alignment.center,
                      width: MediaQuery.of(context).size.width*0.9,
                      child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
                        Text(AppData().language!.recent, style: openSansRegular.copyWith(fontSize: Dimensions.fontSizeLarge)),
                        isView?SizedBox():InkWell(
                          onTap: () {
                            isView=true;
                            setState(() {

                            });
                          },
                          child: Padding(
                            padding: EdgeInsets.symmetric(vertical: Dimensions.PADDING_SIZE_SMALL, horizontal: 4),
                            child: Text(AppData().language!.viewAll, style: openSansRegular.copyWith(
                              fontSize: Dimensions.fontSizeSmall, color: Theme.of(context).disabledColor,
                            )),
                          ),
                        ),
                      ]),
                    ),

                    totalPost>0?isSearch?Container(
                      width: MediaQuery.of(context).size.width*0.9,
                      child: ListView.builder(
                          physics: NeverScrollableScrollPhysics(),
                          shrinkWrap: true,
                          //padding: EdgeInsetsGeometry.infinity,
                          itemCount: postDetail!.length,
                          itemBuilder: (context,index){
                            return InkWell(
                              onTap: (){
                                addRecentSearch(index);
                                FocusManager.instance.primaryFocus!.unfocus();
                                isSearch?postDetail![index].isViewed!?null:viewPost(index):null;
                                ind=index;
                                isShow=true;
                                setState(() {

                                });
                                //loadSearchPosts(postDetail![index].newsPostId??0);

                                //Get.to(HomeScreen(fromSearch: true,postId: postDetail![index].newsPostId,category: postDetail![index].category??'Most Popular',categoryTag: postDetail![index].categoryTag??'Global News',));
                              },
                              child: Padding(
                                padding: const EdgeInsets.symmetric(vertical: 5.0),
                                child: ListTile(
                                  leading: ClipRRect(
                                    borderRadius: BorderRadius.circular(5),
                                    child: postDetail![index].postPicture == null || postDetail![index].postPicture == "" ?CustomImage(
                                      image: Images.placeholder,
                                      height: 55,
                                      width: 60,
                                      fit: BoxFit.cover,
                                    ):
                                    Image.network(
                                     postDetail![index].postPicture!,
                                      width: 60,height: 55,fit: BoxFit.cover,
                                    ),
                                  ),
                                  title: Text(postDetail![index].title??'',maxLines:3,style: openSansBold.copyWith(color: textColor),),
                                ),
                              ),
                            );
                          }
                      ),
                    ):
                    //Recent Post Result
                    Container(
                      width: MediaQuery.of(context).size.width*0.9,
                      child: ListView.builder(
                          physics: NeverScrollableScrollPhysics(),
                          shrinkWrap: true,
                          //padding: EdgeInsetsGeometry.infinity,
                          itemCount: isView?recentDetail!.length:totalPost>3?3:recentDetail!.length,
                          itemBuilder: (context,index){
                            print("index "+ index.toString());
                            return InkWell(
                              onTap: (){
                                FocusManager.instance.primaryFocus!.unfocus();
                                ind=index;
                                loadSearchPosts(recentDetail![index].postDetail!.newsPostId??0);
                                //Get.to(HomeScreen(fromSearch: true,postId: recentDetail![index].postDetail!.newsPostId,category: recentDetail![index].postDetail!.category??'Most Popular',categoryTag: recentDetail![index].postDetail!.categoryTag??'Global News',));
                              },
                              child: Padding(
                                padding: const EdgeInsets.symmetric(vertical: 5.0),
                                child: ListTile(
                                  leading: ClipRRect(
                                    borderRadius: BorderRadius.circular(5),
                                    child: recentDetail![index].postDetail!.postPicture == null || recentDetail![index].postDetail!.postPicture == "" ?CustomImage(
                                      image: Images.placeholder,
                                      height: 55,
                                      width: 60,
                                      fit: BoxFit.cover,
                                    ):
                                    Image.network(
                                     recentDetail![index].postDetail!.postPicture!,
                                      width: 60,height: 55,fit: BoxFit.cover,
                                    ),
                                  ),
                                  title: Text(recentDetail![index].postDetail!.title??'',maxLines:3,style: openSansBold.copyWith(color: textColor),),
                                ),
                              ),
                            );
                          }
                      ),
                    ):
                    Center(child: NoDataScreen(text: "",)),


                  ])),
                ),
              ]),
            ),
          ),
        ),),
      ),
    );
  }

  Future<void> searchPost() async {
    print(tagFilter+orderBy+locationPostal+dateRangePreset+dateFilter);
    //openLoadingDialog(context, "Loading");
    var response;
    response = await DioService.post('news_search_filter', {
      "usersId" : AppData().userdetail!.usersId,
      "orderBy" : orderBy,
      if(tagFilter.isEmpty&&titleFilter.isEmpty&&dateFilter.isEmpty)"noFilterPassed":"yes",
      if(tagFilter.isNotEmpty)"tagFilter" : tagFilter,
      if(titleFilter.isNotEmpty)"titleFilter": titleFilter,
      if(isDate&&dateFilter.isNotEmpty)"dateFilter" : dateFilter,
      if(!isDate&&dateRangePreset.isNotEmpty&&!dateRangePreset.contains("Custom Range"))"dateRangePreset" : dateRangePreset,
      if(locationPostal.isNotEmpty)"locationFilter" : locationPostal
    });
    if(response['status']=='success'){
      var jsonData= response['data'] as List;
      postDetail=  jsonData.map<PostDetail>((e) => PostDetail.fromJson(e)).toList();
      print(postDetail!.length);
      totalPost=postDetail!.length;
      //Navigator.pop(context);
      setState(() {

      });
      //print(followDetail[2].toJson());
    }
    else{
      totalPost=-1;
      setState(() {

      });
      //Navigator.pop(context);
      //showCustomSnackBar(response['message']);

    }
  }

  Future<void> getRecentSearchPost() async {
    openLoadingDialog(context, "Loading");
    var response;
    response = await DioService.post('get_recent_searched_posts', {
      "usersId" : AppData().userdetail!.usersId,
    });
    if(response['status']=='success'){
      var jsonData= response['data'] as List;
      recentDetail=  jsonData.map<RecentDetail>((e) => RecentDetail.fromJson(e)).toList();
      totalPost=recentDetail!.length;
      Navigator.pop(context);
      setState(() {

      });
    }
    else{
      totalPost=-1;
      setState(() {

      });
      Navigator.pop(context);
      //showCustomSnackBar(response['message']);

    }
  }

  Future<void> addRecentSearch(int index) async {
    //openLoadingDialog(context, "Loading");
    var response;
    response = await DioService.post('add_recent_after_search', {
      "usersId" : AppData().userdetail!.usersId,
      "newsPostId" : postDetail![index].newsPostId
    });
    if(response['status']=='success'){

      //Navigator.pop(context);
      setState(() {

      });
      //showCustomSnackBar(response['data'],isError: false);
    }
    else{
      setState(() {

      });
      //Navigator.pop(context);
      //showCustomSnackBar(response['message']);

    }
  }
  Future<void> viewPost(int index) async {
    var response;
    response = await DioService.post('view_post', {
      "usersId" : AppData().userdetail!.usersId,
      "newsPostId" : postDetail![index].newsPostId
    });
    if(response['status']=='success'){
      postDetail![index].isViewed=true;
      //Navigator.pop(context);
      setState(() {

      });
      //showCustomSnackBar(response['data'],isError: false);
    }
    else{
      //Navigator.pop(context);
      setState(() {

      });
      //showCustomSnackBar(response['message']);

    }
  }
  Future<void> loadSearchPosts(int postId) async {
    print(AppData().userdetail!.toJson());
    openLoadingDialog(context, "Loading");
    var response;
    response = await DioService.post('searched_post_details', {
      "usersId" : AppData().userdetail!.usersId,
      "newsPostId" : postId

    });
    if(response['status']=='success'){
      var jsonData= response['data'] as List;
      List<PostDetail> post=  jsonData.map<PostDetail>((e) => PostDetail.fromJson(e)).toList();
      recentDetail![ind].postDetail=post.first;
      isShow=true;
      Navigator.pop(context);
      //selected=categoryList.indexOf(category)+1;
      setState(() {

      });
      // showCustomSnackBar(postDetail![0].title??'');
    }
    else{
      Navigator.pop(context);
      setState(() {

      });
      //showCustomSnackBar(response['message']);

    }
  }
}
