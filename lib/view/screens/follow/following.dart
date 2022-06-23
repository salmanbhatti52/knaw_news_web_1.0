import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/src/extension_navigation.dart';
import 'package:knaw_news/mixin/data.dart';
import 'package:knaw_news/model/follow_model.dart';
import 'package:knaw_news/services/dio_service.dart';
import 'package:knaw_news/util/dimensions.dart';
import 'package:knaw_news/util/images.dart';
import 'package:knaw_news/util/styles.dart';
import 'package:knaw_news/view/base/custom_snackbar.dart';
import 'package:knaw_news/view/base/loading_dialog.dart';
import 'package:knaw_news/view/base/no_data_screen.dart';
import 'package:knaw_news/view/screens/follow/widget/follow_card.dart';
import 'package:knaw_news/view/screens/menu/appbar_with_back.dart';
import 'package:knaw_news/view/screens/profile/follow_profile.dart';

class Following extends StatefulWidget {
  int? userId;
  Following({Key? key,this.userId}) : super(key: key);

  @override
  State<Following> createState() => _FollowingState();
}

class _FollowingState extends State<Following> {
  ScrollController scrollController=ScrollController();
  List<FollowDetail>? followDetail=[];
  int offset=0;
  int totalFollowers=0;
  int followerIndex=0;
  bool isLoading=true;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    scrollController.addListener(_handleScroll);
    WidgetsBinding.instance!.addPostFrameCallback((timeStamp) {
      widget.userId==AppData().userdetail!.usersId?myFollowingList():otherFollowingList();
    });
  }
  void _handleScroll() {
    if(scrollController.position.pixels >= scrollController.position.maxScrollExtent){
      print("max scroll");
      if(totalFollowers>followDetail!.length&&!isLoading) {
        offset+=10;
        widget.userId==AppData().userdetail!.usersId?myFollowingList():otherFollowingList();
        isLoading=true;
      }
      else{
        print("Follower not avilable");
      }

    }
    else{
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarWithBack(title: "Following",isTitle: true,isSuffix: false,),
      body: SafeArea(
        child: totalFollowers>0?Align(
          alignment: Alignment.topCenter,
          child: Container(
            width: MediaQuery.of(context).size.width*0.9,
            child: ListView.builder(
                controller: scrollController,
                physics: BouncingScrollPhysics(),
                shrinkWrap: true,
                //padding: EdgeInsetsGeometry.infinity,
                itemCount: followDetail!.length,
                itemBuilder: (context,index){
                  return Column(
                    children: [
                      FollowCard(
                        icon: followDetail![index].followProfilePicture??'',
                        title: followDetail![index].followUserName??'',
                        isFollower: widget.userId==AppData().userdetail!.usersId?true:followDetail![index].isFollowingBack == "true"?false:true,
                        isVerified: followDetail![index].userVerified,
                        onTapFollow: (){followerIndex=index;followUser();},
                        onTap: () => Get.to(() => FollowProfile(userId: followDetail![index].followingToUserId,)),
                      ),
                      Container(
                        color: Theme.of(context).disabledColor.withOpacity(0.5),
                        width: MediaQuery.of(context).size.width*0.9,
                        margin: EdgeInsets.symmetric(vertical: 7),
                        height: 1.5,
                      ),
                    ],
                  );
                }
            ),
          ),
        ):Center(child: NoDataScreen(text: "No Following Found",)),),
    );
  }
  Future<void> myFollowingList() async {
    openLoadingDialog(context, "Loading");
    var response;
    response = await DioService.post('get_my_following', {
      "offset" : offset,
      "usersId" : AppData().userdetail!.usersId
    });
    if(response['status']=='success'){
      totalFollowers=response['total_count'];
      var jsonData= response['data'] as List;
      followDetail!.addAll(jsonData.map<FollowDetail>((e) => FollowDetail.fromJson(e)).toList());
      //print(postDetail![0].toJson());
      isLoading=false;
      Navigator.pop(context);
      setState(() {

      });
      //print(followDetail[2].toJson());
    }
    else{
      Navigator.pop(context);
      totalFollowers=-1;
      //showCustomSnackBar(response['message']);

    }
  }
  Future<void> otherFollowingList() async {
    openLoadingDialog(context, "Loading");
    var response;
    response = await DioService.post('get_other_following', {
      "offset" : offset,
      "usersId" : AppData().userdetail!.usersId,
      "otherUsersId" : widget.userId

    });
    if(response['status']=='success'){
      totalFollowers=response['total_count'];
      var jsonData= response['data'] as List;
      followDetail!.addAll(jsonData.map<FollowDetail>((e) => FollowDetail.fromJson(e)).toList());
      //print(postDetail![0].toJson());
      isLoading=false;
      Navigator.pop(context);
      setState(() {

      });
      //print(followDetail[2].toJson());
    }
    else{
      Navigator.pop(context);
      totalFollowers=-1;
      //showCustomSnackBar(response['message']);

    }
  }
  Future<void> followUser() async {
    openLoadingDialog(context, "Loading");
    var response;
    response = await DioService.post('follow_user', {
      "followingToUser" : followDetail![followerIndex].followingToUserId,
      "followedByUser" : AppData().userdetail!.usersId
    });
    if(response['status']=='success'){
      //print(postDetail![0].toJson());
      Navigator.pop(context);
      widget.userId==AppData().userdetail!.usersId?followDetail!.removeAt(followerIndex):followDetail![followerIndex].isFollowingBack=="true"?followDetail![followerIndex].isFollowingBack="false":followDetail![followerIndex].isFollowingBack="true";
      totalFollowers=followDetail!.length;
      setState(() {

      });
      //showCustomSnackBar(response['data']);
      //print(followDetail[2].toJson());
    }
    else{
      Navigator.pop(context);
      totalFollowers=-1;
      //showCustomSnackBar(response['message']);

    }
  }
}
