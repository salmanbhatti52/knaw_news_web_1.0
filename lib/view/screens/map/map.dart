import 'dart:typed_data';
import 'dart:ui';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:knaw_news/mixin/data.dart';
import 'package:knaw_news/util/app_constants.dart';
import 'package:knaw_news/util/dimensions.dart';
import 'package:knaw_news/util/images.dart';
import 'package:knaw_news/util/styles.dart';
import 'package:knaw_news/view/base/custom_snackbar.dart';

class MapScreen extends StatefulWidget {
  Function(String address,String country,String latilute,String longitude)? okTap;
  Position? position;
  MapScreen({Key? key,this.position,this.okTap}) : super(key: key);

  @override
  State<MapScreen> createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {

  CameraPosition? _cameraPosition;
  Position _position = Position(longitude: 0, latitude: 0, timestamp: DateTime.now(), accuracy: 1, altitude: 1, heading: 1, speed: 1, speedAccuracy: 1);
  Set<Marker> _markers = Set.of([]);
  late GoogleMapController _mapController;
  List <Placemark>? plackmark;
  String address="";
  String country="";
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _position = Position(longitude: widget.position!.longitude, latitude: widget.position!.latitude, timestamp: DateTime.now(), accuracy: 1, altitude: 1, heading: 1, speed: 1, speedAccuracy: 1);
    convertToAddress(_position.latitude, _position.longitude, AppConstants.apiKey);

    _setMarker();
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
  Widget build(BuildContext context) {
    return GetPlatform.isDesktop?Stack(
      alignment: Alignment.topCenter,
      children: [
        GoogleMap(
          markers: _markers,
          initialCameraPosition: CameraPosition(
            target: LatLng(_position.latitude,_position.longitude),
            zoom: 13,
          ),
          onMapCreated: (GoogleMapController mapController) {
            _mapController = mapController;

          },
          zoomControlsEnabled: false,
          onCameraMove: (CameraPosition cameraPosition) async {
            _cameraPosition=cameraPosition;
            setState(() {
              _markers.add(Marker(markerId: MarkerId('marker'),position: _cameraPosition!.target,));
            });
          },
          onCameraMoveStarted: () {

          },
          onCameraIdle: () async {
            print("cameraIdle");
            //plackmark= await placemarkFromCoordinates(_cameraPosition!.target.latitude, _cameraPosition!.target.longitude);
            //address="${plackmark!.first.subLocality}${plackmark!.first.locality}";
            await convertToAddress(_cameraPosition!.target.latitude, _cameraPosition!.target.longitude, AppConstants.apiKey);
            if(GetPlatform.isDesktop){
              widget.okTap!(address,country,_cameraPosition!.target.latitude.toString(),_cameraPosition!.target.longitude.toString(),);
              _markers.add(Marker(markerId: MarkerId('marker'),position: _cameraPosition!.target,));
              setState(() {

              });
            }
          },
        ),
        Positioned(
            top: 40,
            child: Row(
              children: [
                SvgPicture.asset(Images.location_maker,color: Colors.grey,),
                SizedBox(width: 5,),
                Text(address,style: openSansSemiBold.copyWith(fontSize: Dimensions.fontSizeSmall,color: Colors.grey),),
              ],
            )
        ),

        if(!GetPlatform.isDesktop)Positioned(
          bottom: MediaQuery.of(context).size.height*0.03,
          left: MediaQuery.of(context).size.width*0.35,
          right: MediaQuery.of(context).size.width*0.35,

          //right: MediaQuery.of(context).size.height*0.25,
          child: TextButton(
            onPressed: () async{
              if(_cameraPosition==null){
                widget.okTap!(address,country,widget.position!.latitude.toString(),widget.position!.longitude.toString());
                Get.back();
              }
              else{
                //plackmark= await placemarkFromCoordinates(_cameraPosition!.target.latitude, _cameraPosition!.target.longitude);
                //address="${plackmark!.first.subLocality} ${plackmark!.first.locality}";
                print("address"+address);
                widget.okTap!(address,country,_cameraPosition!.target.latitude.toString(),_cameraPosition!.target.longitude.toString(),);
                Get.back();
              }

            },

            style: flatButtonStyle,
            child: Row(mainAxisAlignment: MainAxisAlignment.center, children: [
              Text("Ok", textAlign: TextAlign.center, style: openSansBold.copyWith(
                color: textBtnColor,
                fontSize: Dimensions.fontSizeDefault,
              )),
            ]),
          ),
        ),


      ],
    ): Scaffold(
      body: Stack(
        alignment: Alignment.topCenter,
        children: [
          GoogleMap(
            markers: _markers,
            initialCameraPosition: CameraPosition(
              target: LatLng(_position.latitude,_position.longitude),
              zoom: 13,
            ),
            onMapCreated: (GoogleMapController mapController) {
              _mapController = mapController;

            },
            zoomControlsEnabled: false,
            onCameraMove: (CameraPosition cameraPosition) async {
              _cameraPosition=cameraPosition;
              setState(() {
                _markers.add(Marker(markerId: MarkerId('marker'),position: _cameraPosition!.target,));
              });
            },
            onCameraMoveStarted: () {

            },
            onCameraIdle: () async {
              print("cameraIdle");
              //plackmark= await placemarkFromCoordinates(_cameraPosition!.target.latitude, _cameraPosition!.target.longitude);
              //address="${plackmark!.first.subLocality}${plackmark!.first.locality}";
              await convertToAddress(_cameraPosition!.target.latitude, _cameraPosition!.target.longitude, AppConstants.apiKey);
            },
          ),
          Positioned(
            top: 40,
              child: Row(
                children: [
                  SvgPicture.asset(Images.location_maker,color: Colors.grey,),
                  SizedBox(width: 5,),
                  Text(address,style: openSansSemiBold.copyWith(fontSize: Dimensions.fontSizeSmall,color: Colors.grey),),
                ],
              )
          ),

          Positioned(
            bottom: MediaQuery.of(context).size.height*0.03,
            left: MediaQuery.of(context).size.width*0.35,
            right: MediaQuery.of(context).size.width*0.35,

            //right: MediaQuery.of(context).size.height*0.25,
            child: TextButton(
              onPressed: () async{
                if(_cameraPosition==null){
                  widget.okTap!(address,country,widget.position!.latitude.toString(),widget.position!.longitude.toString());
                  Get.back();
                }
                else{
                  //plackmark= await placemarkFromCoordinates(_cameraPosition!.target.latitude, _cameraPosition!.target.longitude);
                  //address="${plackmark!.first.subLocality} ${plackmark!.first.locality}";
                  print("address"+address);
                  widget.okTap!(address,country,_cameraPosition!.target.latitude.toString(),_cameraPosition!.target.longitude.toString(),);
                  Get.back();
                }

              },

              style: flatButtonStyle,
              child: Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                Text(AppData().language!.ok, textAlign: TextAlign.center, style: openSansBold.copyWith(
                  color: textBtnColor,
                  fontSize: Dimensions.fontSizeDefault,
                )),
              ]),
            ),
          ),


        ],
      ),
    );
  }
  void _setMarker() async {
    Uint8List destinationImageData = await convertAssetToUnit8List(
      Images.icon,
    );
    plackmark= await placemarkFromCoordinates(_position.latitude, _position.longitude);
    address="${plackmark!.first.subLocality} ${plackmark!.first.locality}";
    _markers.add(Marker(
      markerId: MarkerId('marker'),
      position: LatLng(_position.latitude,_position.longitude),
      //icon: BitmapDescriptor.fromBytes(destinationImageData),
    ));

    setState(() {});
  }

  Future<Uint8List> convertAssetToUnit8List(String imagePath, {int width = 50}) async {
    ByteData data = await rootBundle.load(imagePath);
    Codec codec = await instantiateImageCodec(data.buffer.asUint8List(), targetWidth: width);
    FrameInfo fi = await codec.getNextFrame();
    return (await fi.image.toByteData(format: ImageByteFormat.png))!.buffer.asUint8List();
  }
}
