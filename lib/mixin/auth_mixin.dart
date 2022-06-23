import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:hive/hive.dart';
import 'package:knaw_news/model/language_model.dart';
import 'package:knaw_news/model/signup_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

mixin AuthData {
  static Profile? _profile;
  static UserDetail? _userdetail;
  static UserLocation? _userLocation;
  static Language? _language;
  static String? _accessToken;
  static SharedPreferences? prefs;
  static bool _isGoogleLogin=false;
  static bool _isFacebookLogin=false;

  static Future<void> initiate() async {

    Hive.registerAdapter(ProfileAdapter());
    Hive.registerAdapter(UserDetailAdapter());
    Hive.registerAdapter(UserLocationAdapter());
    Hive.registerAdapter(LanguageAdapter());



    // Uncomment to clear profile
    // Hive.openBox('profiles').then((value) => value.clear());
    final box = await Hive.openLazyBox<Profile>('profiles');
    final box2 = await Hive.openLazyBox<UserDetail>('userDetail');
    final box3 = await Hive.openLazyBox<UserLocation>('userLocation');
    final box4 = await Hive.openLazyBox<Language>('language');


    // Uncomment to clear profile
    // await box.clear();
    prefs = await SharedPreferences.getInstance();

    if (box.isNotEmpty) {
      _profile = await box.getAt(0);
    }
    _accessToken = prefs!.getString('access_token');


    if (box2.isNotEmpty) {
      _userdetail = await box2.getAt(0);
    }
    _accessToken = prefs!.getString('access_token');

    if (box3.isNotEmpty) {
      _userLocation = await box3.getAt(0);
    }
    _accessToken = prefs!.getString('access_token');
    if (box3.isNotEmpty) {
      _language = await box4.getAt(0);
    }
    _accessToken = prefs!.getString('access_token');


  }



  Future<void> signOut() async {
    _profile = null;
    _accessToken = null;
    userdetail=null;
    await FacebookAuth.instance.logOut();
    GoogleSignIn().signOut();
    GoogleSignIn().disconnect();
    SharedPreferences.getInstance().then((value) => value.clear());
    await Hive.lazyBox<UserDetail>('userDetail').clear();
    await Hive.lazyBox<Profile>('profiles').clear();
  }

  Future<void> update() async {
    //Hive.lazyBox<UserDetail>('userDetail').putAt(index, userdetail);
    Hive.lazyBox<UserDetail>('userDetail')
        .putAt(0,userdetail!)
        .then((value) => userdetail!.save());

  }

  Future<void> updateLocation(UserLocation userloc) async {
    Hive.lazyBox<UserLocation>('userLocation').clear().then((value) {
      Hive.lazyBox<UserLocation>('userLocation')
          .add(userloc)
          .then((value) => userloc.save());
    });

  }

  Future<void> updateLanguage() async {
    //Hive.lazyBox<UserDetail>('userDetail').putAt(index, userdetail);
    Hive.lazyBox<Language>('language')
        .putAt(0,language!)
        .then((value) => language!.save());
  }



  UserLocation?  get  userlocation => _userLocation;
  set userlocation(UserLocation? userlocation) {
    _userLocation = userlocation;
    Hive.lazyBox<UserLocation>('userLocation').clear().then((value) {
      Hive.lazyBox<UserLocation>('userLocation')
          .add(userlocation!)
          .then((value) => userlocation.save());
    });
  }

  Profile? get profile => _profile;
  set profile(Profile? prof) {
    _profile = prof;
    Hive.lazyBox<Profile>('profiles').clear().then((value) {
      Hive.lazyBox<Profile>('profiles')
          .add(prof!)
          .then((value) => prof.save());
    });
  }

  Language? get language => _language;
  set language(Language? lang) {
    _language = lang;
    Hive.lazyBox<Language>('language').clear().then((value) {
      Hive.lazyBox<Language>('language')
          .add(lang!)
          .then((value) => lang.save());
    });
  }

  UserDetail?  get  userdetail => _userdetail;
  set userdetail(UserDetail? userdetail) {
    _userdetail = userdetail;
    Hive.lazyBox<UserDetail>('userDetail').clear().then((value) {
      Hive.lazyBox<UserDetail>('userDetail')
          .add(userdetail!)
          .then((value) => userdetail.save());
    });
  }

  bool get isGoogleLogin=> _isGoogleLogin;
    set isGoogleLogin(bool isGoogle){
      _isGoogleLogin=isGoogle;
      SharedPreferences.getInstance().then((value) => value.setBool('loginGoogle', isGoogle));
    }

  bool get isFacebookLogin=> _isFacebookLogin;
  set isFacebookLogin(bool isFacebook){
    _isGoogleLogin=isFacebook;
    SharedPreferences.getInstance().then((value) => value.setBool('loginFacebook', isFacebook));
  }

  String get accessToken => _accessToken??'';
  set accessToken(String token) {
    _accessToken = token;
    SharedPreferences.getInstance().then((value) => value.setString('access_token', token));
  }

  bool get isAuthenticated => _userdetail != null;
  bool get isLanguage => _language != null;
  bool get isLocation => _userLocation != null;
}
