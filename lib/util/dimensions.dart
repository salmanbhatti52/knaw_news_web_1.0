import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class Dimensions {
  static double fontSizeExtraSmall = GetPlatform.isDesktop?14:10;
  static double fontSizeSmall = GetPlatform.isDesktop?16:12;
  static double fontSizeDefault = GetPlatform.isDesktop?18:14;
  static double fontSizeLarge = GetPlatform.isDesktop?20:16;
  static double fontSizeExtraLarge = GetPlatform.isDesktop?22:18;
  static double fontSizeOverLarge = GetPlatform.isDesktop?28:24;

  static const double PADDING_SIZE_EXTRA_SMALL = 5.0;
  static const double PADDING_SIZE_SMALL = 10.0;
  static const double PADDING_SIZE_DEFAULT = 15.0;
  static const double PADDING_SIZE_LARGE = 20.0;
  static const double PADDING_SIZE_EXTRA_LARGE = 25.0;

  static const double RADIUS_SMALL = 5.0;
  static const double RADIUS_DEFAULT = 10.0;
  static const double RADIUS_LARGE = 15.0;
  static const double RADIUS_EXTRA_LARGE = 20.0;

  static const double WEB_MAX_WIDTH = 1170;
}
