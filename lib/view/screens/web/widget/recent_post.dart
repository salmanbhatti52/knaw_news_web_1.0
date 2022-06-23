import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/src/extension_navigation.dart';
import 'package:get/get_utils/src/extensions/internacionalization.dart';
import 'package:knaw_news/mixin/data.dart';
import 'package:knaw_news/model/post_model.dart';
import 'package:knaw_news/services/dio_service.dart';
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
import 'package:knaw_news/view/screens/home/home.dart';
import 'package:knaw_news/view/screens/home/widget/full_transition.dart';
import 'package:knaw_news/view/screens/home/widget/small_transition.dart';
import 'package:knaw_news/view/screens/menu/app_bar.dart';
import 'package:knaw_news/view/screens/search/web_search_filter.dart';
import 'package:knaw_news/view/screens/search/widget/search_field.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:knaw_news/view/screens/search/widget/search_filter.dart';

class RecentPost extends StatefulWidget {
  PostDetail postDetail;
  RecentPost({Key? key,required this.postDetail}) : super(key: key);

  @override
  _RecentPostState createState() => _RecentPostState();
}

class _RecentPostState extends State<RecentPost> {
  PostDetail postDetail=PostDetail();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Size size=MediaQuery.of(context).size;
    double mediaWidth=size.width;
    mediaWidth/=2;
    return WillPopScope(
      onWillPop: () async {
        return true;
      },
      child: Scaffold(
        //backgroundColor: Color(0XFFF8F8FA),
        appBar: WebMenuBar(context: context,isAuthenticated: true,isHalf: true,),
        body: Center(
          child: Container(
            width: mediaWidth,
            alignment: Alignment.topCenter,
            child: SingleChildScrollView(
              physics: BouncingScrollPhysics(),
              child: FullTransition(postDetail: widget.postDetail),
            ),
          ),
        ),
      ),
    );
  }
}
