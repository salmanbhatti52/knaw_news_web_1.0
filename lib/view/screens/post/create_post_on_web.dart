import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_switch/flutter_switch.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/src/extension_navigation.dart';
import 'package:image_picker/image_picker.dart';
import 'package:image_picker_web/image_picker_web.dart';
import 'package:intl/intl.dart';
import 'package:knaw_news/mixin/data.dart';
import 'package:knaw_news/model/post_model.dart';
import 'package:knaw_news/services/dio_service.dart';
import 'package:knaw_news/util/app_constants.dart';
import 'package:knaw_news/util/dimensions.dart';
import 'package:knaw_news/util/images.dart';
import 'package:knaw_news/util/styles.dart';
import 'package:knaw_news/view/base/custom_image.dart';
import 'package:knaw_news/view/base/custom_snackbar.dart';
import 'package:knaw_news/view/base/loading_dialog.dart';
import 'package:knaw_news/view/base/web_menu_bar.dart';
import 'package:knaw_news/view/screens/dashboard/dashboard_screen.dart';
import 'package:knaw_news/view/screens/map/map.dart';
import 'package:knaw_news/view/screens/menu/app_bar.dart';
import 'package:knaw_news/view/screens/menu/drawer.dart';
import 'package:knaw_news/view/screens/post/widget/category_item.dart';
import 'package:knaw_news/view/screens/post/widget/news_type_item.dart';
import 'package:knaw_news/view/screens/profile/profile_screen.dart';
import 'package:knaw_news/view/screens/web/web_home.dart';
import 'package:places_service/places_service.dart';



class WebPostScreen extends StatefulWidget {
  const WebPostScreen({Key? key}) : super(key: key);

  @override
  State<WebPostScreen> createState() => _WebPostScreenState();
}

class _WebPostScreenState extends State<WebPostScreen> {
  TextEditingController eventStartDate=TextEditingController();
  TextEditingController eventEndDate=TextEditingController();
  TextEditingController addressController=TextEditingController();
  TextEditingController linkController=TextEditingController();
  PlacesService  _placesService = PlacesService();
  List<PlacesAutoCompleteResult>  _autoCompleteResult=[];
  PostDetail post=PostDetail(usersId: AppData().userdetail!.usersId,country: "Pakistan",
      location: "Multan Pakistan",latitude: 30.239829,longitude: 71.4853763,
      postalCode: "",externalLink: "");
  int newsType=1;
  int category=0;
  PickedFile _pickedFile=PickedFile("");

  bool isActive=false;
  bool isLocation=false;
  bool isEventIndefinit=false;
  bool isEvent=false;
  String? postPicture;
  Uint8List? bytesFromPicker;
  Image? fromPicker;
  Position? position;
  DateTime selectedDate=DateTime.now();

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
  
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getPosition();
    _placesService.initialize(apiKey: AppConstants.apiKey);
  }
  Future<void> getPosition() async {
    position= await _determinePosition();
    await convertToAddress(position!.latitude, position!.longitude, AppConstants.apiKey);

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

          post.location = firstresult["formatted_address"];
          List<String> list=post.location!.split(',');
          print("this is country name");
          print(list.last);
          post.country = list.last.trim();
          print(post.country);
          addressController.text=post.country!;


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
  
  @override
  Widget build(BuildContext context) {

    Size size=MediaQuery.of(context).size;
    double mediaWidth=size.width;
    if(mediaWidth>1000)
      mediaWidth*=0.5;
    return Scaffold(
      appBar: WebMenuBar(context: context,isAuthenticated: true,isHalf: true,),
      body: SafeArea(child: InkWell(
        hoverColor: Color(0xFFF8F8FA),
        splashColor: Color(0xFFF8F8FA),
        highlightColor: Color(0xFFF8F8FA),
        focusColor: Color(0xFFF8F8FA),
        onTap: (){

          setState(() {
            _autoCompleteResult.clear();
          });
        },
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          //padding: EdgeInsets.symmetric(horizontal:Dimensions.PADDING_SIZE_SMALL),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                SizedBox(height: 20,),

                Container(
                    width: mediaWidth,
                    //padding: EdgeInsets.only(left: MediaQuery.of(context).size.width*0.03),
                    //alignment: Alignment.centerLeft,
                    child: Text(AppData().language!.post,style: openSansBold.copyWith(color: Colors.black),)
                ),
                SizedBox(height: 10,),
                Container(
                  height: mediaWidth*0.45,
                  width: mediaWidth,
                  color: const Color(0XFFF0F0F0),
                  // decoration: BoxDecoration(
                  //   color: const Color(0XFFF0F0F0),
                  //   borderRadius: BorderRadius.circular(10),
                  // ),
                  child: Stack(
                    children: [
                      ClipRRect(
                        child: bytesFromPicker==null || bytesFromPicker!.isEmpty?Container(
                          height: mediaWidth*0.45,
                          width: mediaWidth,
                        ):
                        Image.memory(
                          bytesFromPicker!,width: mediaWidth, height: mediaWidth*0.45,fit: BoxFit.cover,
                        )
                      ),
                      Center(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            InkWell(
                              onTap: () async {
                                bytesFromPicker= await ImagePickerWeb.getImageAsBytes();
                                post.postPicture = base64Encode(bytesFromPicker!);
                                setState(() {

                                });
                                // //fromPicker=await ImagePickerWeb.getImageAsWidget();
                                // //fromPicker=Image(image: fromPicker!.image,fit: BoxFit.cover,);
                                // //bytesFromPicker = await ImagePickerWeb.getImageAsBytes();
                                // //File file=File.fromRawPath(bytesFromPicker!);
                                // //print(file.path);
                                // //result = await FilePicker.platform.pickFiles(type: FileType.image);
                                // if (result != null) {
                                //  // print(result!.files);
                                //   //print(result!.files.first);
                                //   //print(result!.files.first.name);
                                //
                                //   //uploadPicture(result);
                                //
                                //
                                //
                                //   // var file = result!.files.first;
                                //   // print(file);
                                //   // final data = FormData.fromMap({
                                //   //   'news_image': MultipartFile.fromBytes(file.bytes as List<int>)
                                //   // });
                                //   // setState(() {
                                //   //
                                //   // });
                                // } else {
                                //   // User canceled the picker
                                // }
                                // // if (bytesFromPicker != null) {
                                // //     //final tempDir = await getTemporaryDirectory();
                                // //     final file = await File('').create();
                                // //     file.writeAsBytesSync(bytesFromPicker!);
                                // // }
                              },
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: SvgPicture.asset(Images.camera,width: 40,),
                              ),
                            ),
                            Text(AppData().language!.addAPhoto,style: openSansRegular.copyWith(color: textColor),),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 10,),
                SizedBox(
                  width: mediaWidth,
                  child: TextField(
                    onChanged: (value)=> post.title=value,
                    //controller: _titleController,
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
                      hintText: AppData().language!.title,
                      fillColor: Color(0XFFF0F0F0),
                      hintStyle: openSansRegular.copyWith(fontSize: Dimensions.fontSizeSmall),
                      filled: true,

                    ),
                  ),
                ),
                SizedBox(height: 10,),
                SizedBox(
                  width: mediaWidth,
                  child: TextField(
                    onChanged: (value)=> post.description=value,
                    minLines: 4,
                    maxLines: 4,
                    style: openSansRegular.copyWith(fontSize: Dimensions.fontSizeSmall,color: textColor),
                    keyboardType: TextInputType.multiline,
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
                      hintText: AppData().language!.yourDescription,
                      fillColor: Color(0XFFF0F0F0),
                      hintStyle: openSansRegular.copyWith(fontSize: Dimensions.fontSizeSmall),
                      filled: true,

                    ),
                  ),
                ),
                SizedBox(height: 10,),
                Container(
                    width: mediaWidth,
                    //padding: EdgeInsets.only(left: MediaQuery.of(context).size.width*0.03),
                    //alignment: Alignment.centerLeft,
                    child: Text(AppData().language!.category,style: openSansBold.copyWith(color: Colors.black),)
                ),

                SizedBox(height: 10,),

                Container(
                  //width: mediaWidth,
                  padding: EdgeInsets.only(left: size.width>750?mediaWidth*0.5:mediaWidth*0.12),
                  child: SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      children: [
                        CategoryItem(title: AppData().language!.events, icon: Images.event,isSelected: category==1?true:false,
                          onTap: (){
                            setState(() {
                              isEvent=true;
                              category=1;
                              post.category="Events";
                            });
                          },),
                        SizedBox(width: 5,),
                        CategoryItem(title: AppData().language!.business, icon: Images.bussiness,isSelected: category==2?true:false,
                          onTap: (){
                            setState(() {
                              isEvent=false;
                              category=2;
                              post.category="Business";
                            });
                          },),
                        SizedBox(width: 5,),
                        CategoryItem(title: AppData().language!.opinion, icon: Images.opinion,isSelected: category==3?true:false,
                          onTap: (){
                            setState(() {
                              isEvent=false;
                              category=3;
                              post.category="Opinion";
                            });
                          },),
                        SizedBox(width: 5,),
                        CategoryItem(title: AppData().language!.technology, icon: Images.technology,isSelected: category==4?true:false,
                          onTap: (){
                            setState(() {
                              isEvent=false;
                              category=4;
                              post.category="Technology";
                            });
                          },),
                        SizedBox(width: 5,),
                        CategoryItem(title: AppData().language!.entertainment, icon: Images.entertainment,isSelected: category==5?true:false,
                          onTap: (){
                            setState(() {
                              isEvent=false;
                              category=5;
                              post.category="Entertainment";
                            });
                          },),
                        SizedBox(width: 5,),
                        CategoryItem(title: AppData().language!.sports, icon: Images.sport,isSelected: category==6?true:false,
                          onTap: (){
                            setState(() {
                              isEvent=false;
                              category=6;
                              post.category="Sports";
                            });
                          },),
                        SizedBox(width: 5,),
                        CategoryItem(title: AppData().language!.beauty, icon: Images.beauty,isSelected: category==7?true:false,
                          onTap: (){
                            setState(() {
                              isEvent=false;
                              category=7;
                              post.category="Beauty";
                            });
                          },),
                        SizedBox(width: 5,),
                        CategoryItem(title: AppData().language!.science, icon: Images.science,isSelected: category==8?true:false,
                          onTap: (){
                            setState(() {
                              isEvent=false;
                              category=8;
                              post.category="Science";
                            });
                          },),
                        SizedBox(width: 5,),
                        CategoryItem(title: AppData().language!.health, icon: Images.health,isSelected: category==9?true:false,
                          onTap: (){
                            setState(() {
                              isEvent=false;
                              category=9;
                              post.category="Health";
                            });
                          },),
                        SizedBox(width: 5,),

                        CategoryItem(title: "Local", icon: Images.global_news,isSelected: category==10?true:false,
                          onTap: (){
                            setState(() {
                              isEvent=false;
                              category=10;
                              post.category="Local";
                            });
                          },),

                        CategoryItem(title: "National", icon: Images.global_news,isSelected: category==11?true:false,
                          onTap: (){
                            setState(() {
                              isEvent=false;
                              category=11;
                              post.category="National";
                            });
                          },),

                      ],
                    ),
                  ),
                ),
                isEvent?Column(
                  children: [
                    Container(
                      width: mediaWidth,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(AppData().language!.indefinitRemain,style: openSansMedium.copyWith(fontSize:Dimensions.fontSizeSmall,color: Colors.black),),
                          Container(
                            height: 30,
                            width: 40,
                            child: FlutterSwitch(
                              height: 25.0,
                              width: 38.0,
                              padding: 2.0,
                              inactiveToggleColor: Colors.black,
                              activeToggleColor: Theme.of(context).primaryColor,
                              toggleSize: 25.0,
                              borderRadius: 15.0,
                              value: isEventIndefinit,
                              inactiveColor: Theme.of(context).disabledColor.withOpacity(0.5),
                              activeColor: Colors.black,
                              onToggle: (v) {
                                setState(() {
                                  isEventIndefinit=v;
                                  if(v){
                                    eventStartDate.clear();
                                    eventEndDate.clear();
                                    post.eventNewsStartDate="";
                                    post.eventNewsEndDate="";
                                  }
                                });
                              },
                            ),
                          ),
                        ],
                      ),
                    ),
                    isEventIndefinit?SizedBox():
                    Column(
                      children: [
                        Container(
                            width: mediaWidth,
                            child: Text(AppData().language!.eventStarts,style: openSansBold.copyWith(fontSize:Dimensions.fontSizeSmall,color: Colors.black),)
                        ),
                        SizedBox(height: 10,),
                        InkWell(
                          onTap: () => _selectStartDate(context),
                          child: SizedBox(
                            width: mediaWidth,
                            child: TextField(
                              controller: eventStartDate,
                              onChanged: (value)=> post.eventNewsStartDate=value,
                              //controller: _eventStartDate,
                              enabled: false,
                              style: openSansRegular.copyWith(fontSize: Dimensions.fontSizeSmall,color: textColor),
                              keyboardType: TextInputType.text,
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
                                hintText: "",
                                fillColor: Color(0XFFF0F0F0),
                                hintStyle: openSansRegular.copyWith(fontSize: Dimensions.fontSizeSmall),
                                filled: true,
                                suffixIcon: Padding(
                                  padding: EdgeInsets.all(Dimensions.PADDING_SIZE_SMALL),
                                  child: SvgPicture.asset(Images.calendar, height: 10, width: 10,),
                                ),

                              ),
                            ),
                          ),
                        ),
                        SizedBox(height: 10,),
                        Container(
                            width: mediaWidth,
                            child: Text(AppData().language!.eventExpires,style: openSansBold.copyWith(fontSize:Dimensions.fontSizeSmall,color: Colors.black),)
                        ),
                        SizedBox(height: 10,),
                        InkWell(
                          onTap: () => _selectEndDate(context),
                          child: SizedBox(
                            width: mediaWidth,
                            child: TextField(
                              controller: eventEndDate,
                              onChanged: (value)=> post.eventNewsEndDate=value,
                              //controller: _eventEndDate,
                              style: openSansRegular.copyWith(fontSize: Dimensions.fontSizeSmall,color: textColor),
                              keyboardType: TextInputType.text,
                              cursorColor: Theme.of(context).primaryColor,
                              enabled: false,
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
                                hintText: "",
                                fillColor: Color(0XFFF0F0F0),
                                hintStyle: openSansRegular.copyWith(fontSize: Dimensions.fontSizeSmall),
                                filled: true,
                                suffixIcon: Padding(
                                  padding: EdgeInsets.all(Dimensions.PADDING_SIZE_SMALL),
                                  child: SvgPicture.asset(Images.calendar, height: 10, width: 10,),
                                ),

                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ):SizedBox(),
                SizedBox(height: 10,),

                SizedBox(
                  width: mediaWidth,
                  child: Row(
                    children: [
                      SizedBox(
                        width: mediaWidth*0.9,
                        child: TextField(
                          onChanged: (value)=> post.externalLink=value,
                          controller: linkController,
                          style: openSansRegular.copyWith(fontSize: Dimensions.fontSizeSmall,color: textColor),
                          keyboardType: TextInputType.text,
                          cursorColor: Theme.of(context).primaryColor,
                          autofocus: false,
                          enabled: isActive,
                          obscureText: false,
                          decoration: InputDecoration(
                            focusColor: const Color(0XF7F7F7),
                            hoverColor: const Color(0XF7F7F7),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(Dimensions.RADIUS_SMALL),
                              borderSide: const BorderSide(style: BorderStyle.none, width: 0),
                            ),
                            isDense: true,
                            hintText: AppData().language!.link,
                            fillColor: Color(0XFFF0F0F0),
                            hintStyle: openSansRegular.copyWith(fontSize: Dimensions.fontSizeSmall),
                            filled: true,
                          ),
                        ),
                      ),
                      Container(
                        height: 40,
                        width: 40,
                        margin: EdgeInsets.only(left: 10),
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
                            if(isActive)linkController.clear(); post.externalLink="";
                            setState(() {
                              isActive=v;
                            });
                          },
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 10,),

                SizedBox(
                  width: mediaWidth,
                  child: Row(
                    children: [
                      SizedBox(
                        width: mediaWidth*0.9,
                        child: TextFormField(
                          controller: addressController,
                          onChanged: (value) async {
                            // if(value==""){
                            //   setState(() {
                            //     _autoCompleteResult.clear();
                            //   });
                            // }
                            // else{
                            //   print(value);
                            //   print(addressController.text);
                            //   final autoCompleteSuggestions = await _placesService.getAutoComplete(value);
                            //   _autoCompleteResult = autoCompleteSuggestions;
                            //   setState(() {
                            //
                            //   });
                            // }
                            //print(_autoCompleteResult.first.mainText);
                          },
                          style: openSansRegular.copyWith(fontSize: Dimensions.fontSizeSmall,color: textColor),
                          keyboardType: TextInputType.text,
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
                            hintText: AppData().language!.location,
                            fillColor: Color(0XFFF0F0F0),
                            hintStyle: openSansRegular.copyWith(fontSize: Dimensions.fontSizeSmall),
                            filled: true,

                          ),
                        ),
                      ),
                      Container(
                        height: 40,
                        width: 40,
                        margin: EdgeInsets.only(left: 10),
                        child: FlutterSwitch(
                          height: 25.0,
                          width: 38.0,
                          padding: 2.0,
                          inactiveToggleColor: Colors.black,
                          activeToggleColor: Theme.of(context).primaryColor,
                          toggleSize: 25.0,
                          borderRadius: 15.0,
                          value: isLocation,
                          inactiveColor: Theme.of(context).disabledColor.withOpacity(0.5),
                          activeColor: Colors.black,
                          onToggle: (v) {
                            //if(isActive)linkController.clear(); post.externalLink="";
                            setState(() {
                              isLocation=v;
                              if(isLocation)
                                addressController.clear();
                              else
                                addressController.text=post.country!;
                            });
                          },
                        ),
                      ),
                      // IconButton(
                      //   onPressed: ()async{
                      //       if(position!=null){
                      //         Get.to(MapScreen(
                      //           position: position,
                      //           okTap: (address,country,latitude,longitude){
                      //             post.location=address;
                      //             post.country=country;
                      //             post.latitude=double.parse(latitude);
                      //             post.longitude=double.parse(longitude);
                      //             position=Position(longitude: double.parse(longitude), latitude: double.parse(latitude), timestamp: DateTime.now(), accuracy: 1, altitude: 1, heading: 1, speed: 1, speedAccuracy: 1);
                      //             addressController.text=address;
                      //             setState(() {
                      //
                      //             });
                      //           },
                      //         ));
                      //       }
                      //       else{
                      //         openLoadingDialog(context, "Loading");
                      //         position= await _determinePosition();
                      //         Navigator.pop(context);
                      //         if(position!=null){
                      //           Get.to(MapScreen(
                      //             position: position,
                      //             okTap: (address,country,latitude,longitude){
                      //               post.location=address;
                      //               post.country=country;
                      //               post.latitude=double.parse(latitude);
                      //               post.longitude=double.parse(longitude);
                      //               position=Position(longitude: double.parse(longitude), latitude: double.parse(latitude), timestamp: DateTime.now(), accuracy: 1, altitude: 1, heading: 1, speed: 1, speedAccuracy: 1);
                      //               addressController.text=address;
                      //               setState(() {
                      //
                      //               });
                      //             },
                      //           ));
                      //         }
                      //       }
                      //
                      //   },
                      //   icon: SvgPicture.asset(
                      //       Images.location, height:15, width: 15,color: Colors.black
                      //   ),
                      // ),
                    ],
                  ),
                ),
                if (_autoCompleteResult.isNotEmpty)
                  Padding(
                    padding: const EdgeInsets.only(top: 10.0),
                    child: Container(
                      width: mediaWidth,
                      decoration: BoxDecoration(
                          color: Colors.white,
                          //: Border.all(color: Colors.black)
                        ),
                      height: 140,
                      child: ListView.builder(
                        itemCount: _autoCompleteResult.length,
                        itemBuilder: (context, index) {
                          return ListTile(
                            title: Text(_autoCompleteResult[index].mainText ?? ""),
                            //subtitle: Text(_autoCompleteResult[index].description ?? ""),
                            onTap: () async {
                              var id = _autoCompleteResult[index].placeId;
                              final placeDetails = await _placesService.getPlaceDetails(id!);
                              setState(() {
                                print(placeDetails);
                                addressController.text="${_autoCompleteResult[index].mainText!} " + _autoCompleteResult[index].secondaryText!;
                                position=Position(longitude: placeDetails.lng??0, latitude: placeDetails.lat??0, timestamp: DateTime.now(),
                                    accuracy: 1, altitude: 1, heading: 1, speed: 1, speedAccuracy: 1);
                                post.location=addressController.text;
                                post.latitude=placeDetails.lat;
                                post.longitude=placeDetails.lng;
                                print(post.latitude);
                                print(post.longitude);
                                _autoCompleteResult.clear();
                                // zip.text = placeDetails.zip!;
                                // state.text = placeDetails.state!;
                                // city.text = placeDetails.city!;
                                // latlng = LatLng(lat, lng);
                                // event.locationLat = placeDetails.lat!;
                                // event.locationLong = placeDetails.lng!;
                                // mainText.text = "${_autoCompleteResult[index].mainText!} " + _autoCompleteResult[index].secondaryText!;
                                // _autoCompleteResult.clear();
                                // addMarker(event.locationLat!.toDouble(),event.locationLong!.toDouble());
                              });
                            },
                          );
                        },
                      ),
                    ),
                  ),
                //InkWell(child: SvgPicture.asset(Images.location, height: 15, width: 15,color: Colors.black),onTap: () => Get.to(MapScreen()),),
                SizedBox(height: 10,),

                if(position!=null)Container(
                  height: mediaWidth*0.45,
                  width: mediaWidth,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10)
                  ),
                  // decoration: BoxDecoration(
                  //   color: const Color(0XFFF0F0F0),
                  //   borderRadius: BorderRadius.circular(10),
                  // ),
                  child: MapScreen(
                    position: position,
                    okTap: (address,country,latitude,longitude){
                      post.location=address;
                      post.country=country;
                      post.latitude=double.parse(latitude);
                      post.longitude=double.parse(longitude);
                      position=Position(longitude: double.parse(longitude), latitude: double.parse(latitude), timestamp: DateTime.now(), accuracy: 1, altitude: 1, heading: 1, speed: 1, speedAccuracy: 1);
                      addressController.text=address;
                      setState(() {

                      });
                    },
                  ),
                ),
                Container(
                  height: 35,
                  width: mediaWidth*0.5,
                  margin: EdgeInsets.symmetric(vertical: 20),
                  child: TextButton(
                    onPressed: () => postNews(),

                    style: flatButtonStyle,
                    child: Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                      Text(AppData().language!.post.toUpperCase(), textAlign: TextAlign.center, style: openSansBold.copyWith(
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
      ),),
    );
  }

  Future<void> postNews() async {
    print(post.toJson());
    if(post.country!.isEmpty){
      // showCustomSnackBar("Choose Location");
      return;
    }
    if(isEvent&&!isEventIndefinit&&(eventStartDate.text.isEmpty||eventEndDate.text.isEmpty)){
      print("here");
      // showCustomSnackBar("Select Event start and end date");
      return;
    }
    openLoadingDialog(context, "Loading");
    var response;

    response = await DioService.post('create_news_post_web', {
      "usersId" : post.usersId,
      "title": post.title,
      "description": post.description,
      "category": post.category,
      if(post.externalLink!=null && post.externalLink!.isNotEmpty)"externalLink": post.externalLink??' ',
      "location": post.location,
      "newsCountry": post.country==""?"Pakistan":post.country,
      "longitude": post.longitude,
      "latitude": post.latitude,
      if(post.postPicture!=null)"postPicture": post.postPicture,
      if(isEvent&&!isEventIndefinit)"eventNewsStartDate" : post.eventNewsStartDate,
      if(isEvent&&!isEventIndefinit)"eventNewsEndDate" : post.eventNewsEndDate
    });
    if(response['status']=='success'){
      print("1---------------success response-----------");
      Navigator.pop(context);
      Get.toNamed("/");
    }
    else{
      print("2---------------error response-----------");
      Navigator.pop(context);
      // showCustomSnackBar(response['message']);

    }
  }
  Future uploadPicture(var data) async {
    print(bytesFromPicker);

    print(data.files.toList());
    print(data.fields.toList().toList());
    //print(data.finalize().toList());
    openLoadingDialog(context, "Loading");
    var response;

    response = await DioService.post('upload_news_image', FormData.fromMap(({
      'news_image' :  MultipartFile.fromBytes(data.bytes as List<int>)
    })));
    if(response['status']=='success'){
      post.postPicture=response["data"];
      Navigator.pop(context);
      // showCustomSnackBar(response['data']);
    }
    else{
      Navigator.pop(context);
      print("helllooo");
      print(response['message']);
      // showCustomSnackBar(response['message']);

    }
  }
  _selectStartDate(BuildContext context) async {
    final DateTime? selected = await showDatePicker(
      context: context,
      initialDate: selectedDate,
      firstDate: selectedDate,
      lastDate: DateTime(selectedDate.year+5),
    );
    if (selected != null && selected != selectedDate) {
      print(selected);
      setState(() {
        selectedDate = selected;
        eventStartDate.text=DateFormat("dd MMM, yyyy").format(selectedDate);
        post.eventNewsStartDate=eventStartDate.text;
      });
    }
  }
  _selectEndDate(BuildContext context) async {
    final DateTime? selected = await showDatePicker(
      context: context,
      initialDate: selectedDate,
      firstDate: selectedDate,
      lastDate: DateTime(selectedDate.year+5),
    );
    if (selected != null && selected != selectedDate) {
      print(selected);
      setState(() {
        selectedDate = selected;
        eventEndDate.text=DateFormat("dd MMM, yyyy").format(selectedDate);
        post.eventNewsEndDate=eventEndDate.text;
      });
    }
  }


}
