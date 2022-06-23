

import 'package:knaw_news/util/dimensions.dart';
import 'package:flutter/material.dart';

final openSansLight = TextStyle(
  fontFamily: 'OpenSans',
  fontWeight: FontWeight.w300,
  fontSize: Dimensions.fontSizeDefault,
);

final openSansRegular = TextStyle(
  fontFamily: 'OpenSans',
  fontWeight: FontWeight.w400,
  fontSize: Dimensions.fontSizeDefault,
);

final openSansMedium = TextStyle(
  fontFamily: 'OpenSans',
  fontWeight: FontWeight.w500,
  fontSize: Dimensions.fontSizeDefault,
);

final openSansSemiBold = TextStyle(
  fontFamily: 'OpenSans',
  fontWeight: FontWeight.w600,
  fontSize: Dimensions.fontSizeDefault,
);
final openSansBold = TextStyle(
  fontFamily: 'OpenSans',
  fontWeight: FontWeight.w700,
  fontSize: Dimensions.fontSizeDefault,
);

final openSansExtraBold = TextStyle(
  fontFamily: 'OpenSans',
  fontWeight: FontWeight.w900,
  fontSize: Dimensions.fontSizeLarge,
);
const textBlack= Colors.black;
const textColor= Color(0X99131212);
const textBtnColor= Colors.white;

final ButtonStyle flatButtonStyle = TextButton.styleFrom(
  backgroundColor:Colors.amber,
  padding: EdgeInsets.zero,
  shape: RoundedRectangleBorder(
    borderRadius: BorderRadius.circular(5),
  ),
);
final ButtonStyle webFlatButtonStyle = TextButton.styleFrom(
  backgroundColor:Colors.amber,
  padding: EdgeInsets.zero,
  shape: RoundedRectangleBorder(
    borderRadius: BorderRadius.circular(3),
  ),
);






final divider = Divider(height: 10,thickness: 10);
