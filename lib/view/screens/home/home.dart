import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/src/extension_navigation.dart';
import 'package:knaw_news/mixin/data.dart';
import 'package:knaw_news/model/post_model.dart';
import 'package:knaw_news/services/dio_service.dart';
import 'package:knaw_news/util/app_constants.dart';
import 'package:knaw_news/util/dimensions.dart';
import 'package:knaw_news/util/images.dart';
import 'package:knaw_news/util/styles.dart';
import 'package:knaw_news/view/base/loading_dialog.dart';
import 'package:knaw_news/view/base/no_data_screen.dart';
import 'package:knaw_news/view/screens/dashboard/widget/bottom_nav_item.dart';
import 'package:knaw_news/view/screens/home/widget/full_transition.dart';
import 'package:knaw_news/view/screens/menu/app_bar.dart';
import 'package:knaw_news/view/screens/menu/drawer.dart';
import 'package:knaw_news/view/screens/post/create_post_screen.dart';
import 'package:knaw_news/view/screens/post/widget/category_item.dart';
import 'package:knaw_news/view/screens/profile/profile_screen.dart';
import 'package:knaw_news/view/screens/search/search_screen.dart';


class HomeScreen extends StatefulWidget  {

  HomeScreen({Key? key,}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> with TickerProviderStateMixin {
  ScrollController scrollController=ScrollController();
  TabController? _tabController;
  List <Placemark>? plackmark;
  String address="";
  String country="";
  Position position=Position(longitude: 0, latitude: 0, timestamp: DateTime.now(),
      accuracy: 1, altitude: 1, heading: 1, speed: 1, speedAccuracy: 1);
  int selected=1;
  String category="Most Popular";
  String offset="0";
  bool isLoading=true;
  List<String> categoryList=["Most Popular","Happy","Sad","Your News Feed","Global News","Events","Business","Opinion","Technology", "Entertainment","Sports","Beauty","Science","Health",];
  List<PostDetail>? postDetail;
  int totalPost=-1;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _tabController = TabController(length: 14, initialIndex: 0, vsync: this,);
    _tabController!.addListener(_handleTabSelection);
    scrollController.addListener(_handleScroll);
    getLocation();
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
      if(totalPost>int.parse(offset)+6&&!isLoading) {
        offset = (int.parse(offset) +6).toString();
        print("load more");
        selected>3?loadPostsMore():loadOtherPostsMore();
        isLoading=true;
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
    print("setState called");
    return Scaffold(
      drawer:  MyDrawer(),
      appBar: CustomAppBar(leading: Images.menu,title: Images.logo_name,isSuffix: false,isleading: true,),
      bottomNavigationBar: ClipRRect(
        borderRadius: const BorderRadius.vertical(top: Radius.circular(10)),
        child: BottomAppBar(
          child: Padding(
            padding: EdgeInsets.all(0),
            child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  BottomNavItem(iconData: Images.home,isSelected: false, onTap: () => Get.to(HomeScreen())),
                  BottomNavItem(iconData: Images.search, isSelected: false , onTap: () => Get.to(SearchScreen())),
                  BottomNavItem(iconData: Images.add,isSelected: false, onTap: () => Get.to(PostScreen())),
                  BottomNavItem(iconData: Images.user,isSelected: false, onTap: () => Get.to(ProfileScreen())),
                ]),
          ),
        ),
      ),
      body: SafeArea(child: Center(
        child: Container(
          child: Column(
            children: [
              Container(
                color: Colors.white,
                padding: EdgeInsets.only(bottom: 5),
                child: DefaultTabController(
                    length: 14,
                    child: SizedBox(
                      height: 40,
                      //width: 200,
                      child: TabBar(
                        controller: _tabController,
                        padding: EdgeInsets.zero,
                        labelPadding: EdgeInsets.symmetric(horizontal: 5),
                        indicatorPadding: EdgeInsets.zero,
                        isScrollable: true,
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
                        ],

                      ),
                    )
                ),
              ),
              Expanded(
                child: Container(
                  width: MediaQuery.of(context).size.width*0.9,
                  child: TabBarView(
                      controller: _tabController,
                      children: [
                        for(int i=0;i<14;i++)
                          totalPost>0?Container(
                            width: MediaQuery.of(context).size.width*0.9,
                            child: ListView.builder(
                                controller: scrollController,
                                physics: BouncingScrollPhysics(),
                                shrinkWrap: true,
                                itemCount: postDetail!.length,
                                itemBuilder: (context,index){
                                  return FullTransition(postDetail: postDetail![index],);
                                }
                            ),
                          ):Center(child: NoDataScreen()),
                      ]
                  ),
                ),
              ),
            ],
          ),
        ),
      ),),
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
    var response;
    response = await DioService.post('all_news_with_base_filter', {
      "usersId" : AppData().userdetail!.usersId,
      "offset": offset,
      "category": category,
      "userCountry": AppData().userdetail!.country
    });
    if(response['status']=='success'){
      var jsonData= response['data'] as List;
      print(response);
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
    //_tabController!.index=selected-1;
    openLoadingDialog(context, "Loading");
    var response;
    response = await DioService.post('all_news_with_base_filter', {
      "usersId" : AppData().userdetail!.usersId,
      "offset": offset,
      "category": category,
      "userCountry": AppData().userdetail!.country

    });
    if(response['status']=='success'){
      var jsonData= response['data'] as List;
      postDetail!.addAll(jsonData.map<PostDetail>((e) => PostDetail.fromJson(e)).toList());
      Navigator.pop(context);
      setState(() {

      });
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

  Future<void> loadOtherPosts({bool isTap=true}) async {

    offset="0";
    _tabController!.index=selected-1;
    if(isTap){
      return;
    }
    print(AppData().userdetail!.toJson());
    openLoadingDialog(context, "Loading");
    var response;
    response = await DioService.post('all_news_with_other_filter', {
      "usersId" : AppData().userdetail!.usersId,
      "offset": offset,
      "otherCategory": category,
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
    print("load More");
    //_tabController!.index=selected-1;
    openLoadingDialog(context, "Loading");
    var response;
    response = await DioService.post('all_news_with_other_filter', {
      "usersId" : AppData().userdetail!.usersId,
      "offset": offset,
      "otherCategory": category,
      "userCountry": AppData().userdetail!.country
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
      //showCustomSnackBar(response['message']);
      totalPost=0;
      print(totalPost.toString());

    }
    isLoading=false;
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
    print("country"+country);
    if(AppData().userdetail!.address.isEmpty){
      AppData().userdetail!.address=address;
      AppData().userdetail!.country=country;
      AppData().userdetail!.latitude=position.latitude;
      AppData().userdetail!.longitude=position.longitude;
      loadOtherPosts(isTap: false);
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

    print(response.data);

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
