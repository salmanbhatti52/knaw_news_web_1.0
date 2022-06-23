// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'follow_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

FollowDetail _$FollowDetailFromJson(Map<String, dynamic> json) => FollowDetail(
      followId: json['follow_id'] as int?,
      followingToUserId: json['following_to_user'] as int?,
      followedByUserId: json['followed_by_user'] as int?,
      status: json['status'] as String?,
      followUserName: json['user_name'] as String?,
      followProfilePicture: json['profile_picture'] as String?,
      isFollowingBack: json['is_following_back'] as String?,
      userVerified: json['user_is_verified'] as bool?,
    );

Map<String, dynamic> _$FollowDetailToJson(FollowDetail instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('follow_id', instance.followId);
  writeNotNull('following_to_user', instance.followingToUserId);
  writeNotNull('followed_by_user', instance.followedByUserId);
  writeNotNull('status', instance.status);
  writeNotNull('user_name', instance.followUserName);
  writeNotNull('is_following_back', instance.isFollowingBack);
  writeNotNull('profile_picture', instance.followProfilePicture);
  writeNotNull('user_is_verified', instance.userVerified);
  return val;
}
