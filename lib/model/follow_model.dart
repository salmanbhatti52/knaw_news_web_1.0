import 'package:json_annotation/json_annotation.dart';
part 'follow_model.g.dart';
@JsonSerializable(includeIfNull: false)
class FollowDetail{
  @JsonKey(name: 'follow_id',)
  int? followId;
  @JsonKey(name: 'following_to_user',)
  int? followingToUserId;
  @JsonKey(name: 'followed_by_user',)
  int? followedByUserId;
  String? status;
  @JsonKey(name: 'user_name',)
  String? followUserName;
  @JsonKey(name: 'is_following_back',)
  String? isFollowingBack;
  @JsonKey(name: 'profile_picture',)
  String? followProfilePicture;
  @JsonKey(name: 'user_is_verified',)
  bool? userVerified;
  FollowDetail({this.followId,this.followingToUserId,this.followedByUserId,this.status,
  this.followUserName,this.followProfilePicture,this.isFollowingBack,this.userVerified
  });

  Map<String, dynamic> toJson() => _$FollowDetailToJson(this);
  factory FollowDetail.fromJson(json) => _$FollowDetailFromJson(json);

}