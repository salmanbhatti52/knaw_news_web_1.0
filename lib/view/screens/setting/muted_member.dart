import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:knaw_news/mixin/data.dart';
import 'package:knaw_news/model/mute_model.dart';
import 'package:knaw_news/services/dio_service.dart';
import 'package:knaw_news/util/dimensions.dart';
import 'package:knaw_news/util/images.dart';
import 'package:knaw_news/util/styles.dart';
import 'package:knaw_news/view/base/custom_snackbar.dart';
import 'package:knaw_news/view/base/loading_dialog.dart';
import 'package:knaw_news/view/base/no_data_screen.dart';
import 'package:knaw_news/view/screens/menu/appbar_with_back.dart';
import 'package:knaw_news/view/screens/setting/widget/member_card.dart';

class MutedMember extends StatefulWidget {
  const MutedMember({Key? key}) : super(key: key);

  @override
  State<MutedMember> createState() => _MutedMemberState();
}

class _MutedMemberState extends State<MutedMember> {
  List<MutedMemberDetail>? mutedMemberDetail;
  int offset=0;
  int totalMember=0;
  int? selectedIndex;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    WidgetsBinding.instance!.addPostFrameCallback((timeStamp) {
      mutedMembersList();
    });
  }
  @override
  Widget build(BuildContext context) {
    return GetPlatform.isDesktop?totalMember>0?Container(
      width: MediaQuery.of(context).size.width*0.2,
      child: ListView.builder(
          physics: NeverScrollableScrollPhysics(),
          shrinkWrap: true,
          itemCount: mutedMemberDetail!.length,
          itemBuilder: (context,index){
            return Column(
              children: [
                MuteMemberCard(mutedMemberDetail: mutedMemberDetail![index],onTapSuffix: (){
                  selectedIndex=index;
                  unMuteMember();
                },),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 5.0),
                  child: Container(
                    color: Theme.of(context).disabledColor.withOpacity(0.5),
                    width: MediaQuery.of(context).size.width*0.85,
                    height: 1,
                  ),
                ),
              ],

            );

          }
      ),
    ):
    Center(child: NoDataScreen(text: "No Muted Member Exist",)):
    Scaffold(
      appBar: AppBarWithBack(title: AppData().language!.mutedMembers,isTitle: true,isSuffix: false,),
      //backgroundColor:Get.isDarkMode ? Colors.black : Colors.white,
      body: SafeArea(child: Scrollbar(
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          padding: const EdgeInsets.all(Dimensions.PADDING_SIZE_SMALL),
          child: Center(
            child: totalMember>0?Container(
              width: MediaQuery.of(context).size.width*0.9,
              child: ListView.builder(
                  physics: NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  //padding: EdgeInsetsGeometry.infinity,
                  itemCount: mutedMemberDetail!.length,
                  itemBuilder: (context,index){
                    return Column(
                      children: [
                        MuteMemberCard(mutedMemberDetail: mutedMemberDetail![index],onTapSuffix: (){
                          selectedIndex=index;
                          unMuteMember();
                        },),
                        index+1==mutedMemberDetail!.length&&totalMember>mutedMemberDetail!.length?InkWell(
                          onTap: (){
                            offset+=10;
                            mutedMembersList();
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
                          margin: index+1==mutedMemberDetail!.length?EdgeInsets.only(top: 10):EdgeInsets.symmetric(vertical: 10),
                          height: 1,
                        ),
                      ],

                    );

                  }
              ),
            ):Center(child: NoDataScreen(text: "No Muted Member Exist",)),
          ),
        ),
      ),),
    );
  }
  void mutedMembersList() async{
    openLoadingDialog(context, "Loading");
    var response;
    response = await DioService.post('get_muted_members', {
      "offset" : offset,
      "userId": AppData().userdetail!.usersId
    });
    if(response['status']=='success'){
      totalMember=response['total_count'];
      var jsonData= response['data'] as List;
      mutedMemberDetail!.addAll(jsonData.map<MutedMemberDetail>((e) => MutedMemberDetail.fromJson(e)).toList());
      setState(() {

      });
      print(mutedMemberDetail!.first.toJson());
      Navigator.pop(context);
    }
    else{
      totalMember=0;
      setState(() {

      });
      Navigator.pop(context);
      showCustomSnackBar(response['message']);
    }

  }
  void unMuteMember() async{
    openLoadingDialog(context, "Loading");
    var response;
    response = await DioService.post('unmute_member', {
      "muteUsersId": mutedMemberDetail![selectedIndex??0].mutedMemberId,
      "usersId": AppData().userdetail!.usersId

    });
    if(response['status']=='success'){

      mutedMemberDetail!.removeAt(selectedIndex??0);
      totalMember-=1;
      setState(() {

      });
      Navigator.pop(context);
      showCustomSnackBar(response['data'],isError: false);
    }
    else{
      setState(() {

      });
      Navigator.pop(context);
      showCustomSnackBar(response['message']);
    }

  }
}
