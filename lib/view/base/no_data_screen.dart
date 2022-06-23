
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:knaw_news/util/dimensions.dart';
import 'package:knaw_news/util/images.dart';
import 'package:knaw_news/util/styles.dart';

class NoDataScreen extends StatelessWidget {
  final bool isCart;
  final String text;
  final bool isAddress;
  NoDataScreen({this.text="", this.isCart = false,this.isAddress=false});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(Dimensions.PADDING_SIZE_LARGE),
      child: Column(mainAxisAlignment: MainAxisAlignment.center, crossAxisAlignment: CrossAxisAlignment.stretch, children: [

        Image.asset(
          isCart ? Images.empty_cart : text==""?Images.empty_news_box:Images.no_data,
          width: MediaQuery.of(context).size.height*0.22, height: MediaQuery.of(context).size.height*0.22,
        ),
        SizedBox(height: MediaQuery.of(context).size.height*0.03),

        // Text(
        //   isCart ? 'cart_is_empty'.tr : text,
        //   style: openSansBold.copyWith(fontSize: MediaQuery.of(context).size.height*0.0175, color: Theme.of(context).disabledColor),
        //   textAlign: TextAlign.center,
        // ),
      ]),
    );
  }
}
