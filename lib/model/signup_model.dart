import 'package:hive/hive.dart';
import 'package:json_annotation/json_annotation.dart';
part 'signup_model.g.dart';



@HiveType(typeId: 129)
@JsonSerializable(includeIfNull: false)
class Profile extends HiveObject{

  String? userName;
  String? userEmail;
  String? confirmPassword;
  String? userPassword;
  String? oneSignalId;
  @JsonKey(name: 'temp_password_flag')
  @HiveField(1)
  String? tempPasswordFlag;
  @HiveField(2)
  String? status;
  @HiveField(3)
  UserDetail? data;
  Profile({this.userName,this.userEmail,this.userPassword,this.confirmPassword,this.tempPasswordFlag,this.status,this.data});
  Map<String, dynamic> toJson() => _$ProfileToJson(this);
  factory Profile.fromJson(json) => _$ProfileFromJson(json);

}

@HiveType(typeId: 130)
@JsonSerializable(includeIfNull: false)
class UserDetail extends HiveObject{
  @JsonKey(name: 'users_id',)
  @HiveField(1)
  int? usersId;
  @JsonKey(name: 'user_name',)
  @HiveField(2)
  String? userName;
  @HiveField(3)
  String? email;
  @HiveField(4)
  String? password;
  @JsonKey(name: 'confirm_password',)
  @HiveField(5)
  String? confirmPassword;
  @JsonKey(name: 'account_type',)
  @HiveField(6)
  String? accountType;
  @JsonKey(name: 'profile_picture',)
  @HiveField(7)
  String? profilePicture;
  @JsonKey(name: 'social_acc_type',)
  @HiveField(8)
  String? socialAccType;
  @JsonKey(name: 'google_access_token',)
  @HiveField(9)
  String? googleAccessToken;
  @JsonKey(name: 'facebook_id',)
  @HiveField(10)
  String? facebookId;
  @HiveField(11)
  String? description;
  @JsonKey(name: 'news_radius',)
  @HiveField(12)
  int? newsRadius;
  @JsonKey(name: 'notification_status',)
  @HiveField(13)
  String? notificationStatus;
  @JsonKey(name: 'date_added',)
  @HiveField(14)
  String? dateAdded;
  @HiveField(15)
  String? status;
  @JsonKey(name: 'roles_id',)
  @HiveField(16)
  int? rolesId;
  @JsonKey(name: 'updated_at',)
  @HiveField(17)
  String? updatedAt;
  @JsonKey(name: 'verify_code',)
  @HiveField(18)
  String? verifyCode;
  @HiveField(19)
  String address;
  @HiveField(20)
  String country;
  @HiveField(21)
  double latitude;
  @HiveField(22)
  double longitude;
  @HiveField(23)
  @JsonKey(name: 'user_is_verified',)
  bool userVerified;
  @JsonKey(name: 'joined_since',)
  String joinedSince;
  @JsonKey(name: 'total_followers',)
  int totalFollowers;
  @JsonKey(name: 'total_post_count',)
  int totalPostCount;
  @JsonKey(name: 'total_following',)
  int totalFollowing;
  @JsonKey(name: 'total_views',)
  int totalViews;
  @JsonKey(name: 'total_comments',)
  int totalComments;
  @JsonKey(name: 'one_signal_id',)
  String? playerId;
  @JsonKey(name: 'is_followed',)
  bool isFollowed;
  @JsonKey(name: 'is_muted',)
  bool isMuted;


  UserDetail({
    this.usersId,this.userName,this.email,this.password,this.confirmPassword,this.accountType,
    this.profilePicture,this.socialAccType,this.googleAccessToken,this.facebookId,this.description,
    this.newsRadius=0,this.notificationStatus,this.dateAdded,this.status,this.rolesId,
    this.updatedAt,this.verifyCode,this.joinedSince="",this.totalFollowers=0,this.totalPostCount=0,
    this.totalFollowing=0,this.totalComments=0,this.totalViews=0,this.playerId,this.isFollowed=false,
    this.isMuted=false,this.address="",this.country="",this.latitude=0,this.longitude=0,this.userVerified=false
});
  Map<String, dynamic> toJson() => _$UserDetailToJson(this);
  factory UserDetail.fromJson(json) => _$UserDetailFromJson(json);


}
@HiveType(typeId: 131)
@JsonSerializable(includeIfNull: false)
class UserLocation extends HiveObject{

  String address;
  String country;
  double latitude;
  double longitude;
  UserLocation({this.address="Multan",this.country="Pakistan",this.latitude=30.239829,this.longitude=71.4853763});
  Map<String, dynamic> toJson() => _$UserLocationToJson(this);
  factory UserLocation.fromJson(json) => _$UserLocationFromJson(json);
}