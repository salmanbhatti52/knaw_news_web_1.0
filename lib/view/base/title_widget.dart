
import 'package:flutter/material.dart';
import 'package:get/utils.dart';
import 'package:knaw_news/util/dimensions.dart';
import 'package:knaw_news/util/styles.dart';

class TitleWidget extends StatelessWidget {
  final String title;
  final Function onTap;
  TitleWidget({this.title="", required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
      Text(title, style: openSansExtraBold.copyWith(fontSize: Dimensions.fontSizeExtraLarge)),
      // (onTap != null && !ResponsiveHelper.isDesktop(context)) ? InkWell(
      //   onTap: onTap,
      //   child: Padding(
      //     padding: EdgeInsets.fromLTRB(10, 5, 0, 5),
      //     child: Text(
      //       'view_all'.tr,
      //       style: robotoMedium.copyWith(fontSize: Dimensions.fontSizeSmall, color: Theme.of(context).primaryColor),
      //     ),
      //   ),
      // ) : SizedBox(),
    ]);
  }
}
