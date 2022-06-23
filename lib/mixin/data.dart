import 'package:hive_flutter/adapters.dart';

import 'auth_mixin.dart';

/// Export All Models;

class AppData with AuthData {
  AppData._();
  static  bool? _isInitiated;
  static Future initiate() async {
    await Hive.initFlutter();
    // Hive.registerAdapter(ImageModelAdapter());
    await AuthData.initiate();
    _isInitiated = true;
  }
  factory AppData() {
    if (_isInitiated!) {
      return AppData._();
    } else {
      throw 'AppData has not been initialized';
    }
  }
}
