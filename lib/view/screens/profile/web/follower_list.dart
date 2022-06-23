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
import 'package:knaw_news/view/screens/profile/web/web_follow_profile.dart';

class FollowerList extends StatefulWidget {
  int? userId;
  FollowerList({Key? key,this.userId}) : super(key: key);

  @override
  State<FollowerList> createState() => _FollowerListState();
}

class _FollowerListState extends State<FollowerList> {
  List<FollowDetail>? followDetail=[];
  int offset=0;
  int totalFollowers=0;
  int followerIndex=0;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    WidgetsBinding.instance!.addPostFrameCallback((timeStamp) {
      widget.userId==AppData().userdetail!.usersId?myFollowersList():otherFollowersList();
    });
  }
  @override
  Widget build(BuildContext context) {
    return totalFollowers>0?Container(
      width: MediaQuery.of(context).size.width*0.9,
      child: ListView.builder(
          physics: NeverScrollableScrollPhysics(),
          shrinkWrap: true,
          //padding: EdgeInsetsGeometry.infinity,
          itemCount: followDetail!.length,
          itemBuilder: (context,index){
            return Column(
              children: [
                FollowCard(
                  icon: followDetail![index].followProfilePicture??'',
                  title: followDetail![index].followUserName??'',
                  isFollower: followDetail![index].isFollowingBack=="false"?false:true,
                  isVerified: followDetail![index].userVerified,
                  onTapFollow: (){followerIndex=index;followUser();},
                  onTap: () => Get.to(() => WebFollowProfile(userId: followDetail![index].followedByUserId,)),
                ),
                index+1==followDetail!.length&&totalFollowers>followDetail!.length?InkWell(
                  onTap: (){
                    offset+=10;
                    myFollowersList();
                  },
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: 10,vertical: 5),
                    margin: EdgeInsets.symmetric(vertical: 10),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color: Colors.blueGrey.withOpacity(0.2)
                    ),
                    child: Text("${AppData().language!.loadMore} ▶",style: openSansSemiBold.copyWith(fontSize: Dimensions.fontSizeSmall),),
                  ),
                ):Container(
                  color: Theme.of(context).disabledColor.withOpacity(0.5),
                  width: MediaQuery.of(context).size.width*0.9,
                  margin: index+1==followDetail!.length?EdgeInsets.only(top: 10):EdgeInsets.symmetric(vertical: 10),
                  height: 1,
                ),
              ],
            );
          }
      ),
    ):Center(child: NoDataScreen(text: "No Follower Found",));
  }
  Future<void> myFollowersList() async {
    openLoadingDialog(context, "Loading");
    var response;
    response = await DioService.post('get_my_followers', {
      "offset" : offset,
      "usersId" : widget.userId
    });
    if(response['status']=='success'){
      totalFollowers=response['total_count'];
      var jsonData= response['data'] as List;
      followDetail!.addAll(jsonData.map<FollowDetail>((e) => FollowDetail.fromJson(e)).toList());
      //print(postDetail![0].toJson());
      Navigator.pop(context);
      setState(() {

      });
      //print(followDetail[2].toJson());
    }
    else{
      Navigator.pop(context);
      totalFollowers=-1;
      showCustomSnackBar(response['message']);

    }
  }
  Future<void> otherFollowersList() async {
    openLoadingDialog(context, "Loading");
    var response;
    response = await DioService.post('get_other_followers', {
      "offset" : offset,
      "usersId" : AppData().userdetail!.usersId,
      "otherUsersId" : widget.userId
    });
    if(response['status']=='success'){
      totalFollowers=response['total_count'];
      var jsonData= response['data'] as List;
      followDetail!.addAll(jsonData.map<FollowDetail>((e) => FollowDetail.fromJson(e)).toList());
      //print(postDetail![0].toJson());
      Navigator.pop(context);
      setState(() {

      });
      //print(followDetail[2].toJson());
    }
    else{
      Navigator.pop(context);
      totalFollowers=-1;
      showCustomSnackBar(response['message']);

    }
  }
  Future<void> followUser() async {
    openLoadingDialog(context, "Loading");
    var response;
    response = await DioService.post('follow_user', {
      "followingToUser" : followDetail![followerIndex].followedByUserId,
      "followedByUser" : AppData().userdetail!.usersId
    });
    if(response['status']=='success'){
      //print(postDetail![0].toJson());
      followDetail![followerIndex].isFollowingBack=='false'?followDetail![followerIndex].isFollowingBack='true':followDetail![followerIndex].isFollowingBack='false';
      Navigator.pop(context);
      setState(() {

      });
      showCustomSnackBar(response['data']);
      //print(followDetail[2].toJson());
    }
    else{
      Navigator.pop(context);
      showCustomSnackBar(response['message']);

    }
  }
}


