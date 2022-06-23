// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'mute_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MutedMemberDetail _$MutedMemberDetailFromJson(Map<String, dynamic> json) =>
    MutedMemberDetail(
      muteId: json['muted_member_id'] as int?,
      mutedById: json['muted_by'] as int?,
      mutedMemberId: json['muted_member'] as int?,
      mutedMemberUserName: json['user_name'] as String?,
      mutedMemberProfilePicture: json['profile_picture'] as String?,
      status: json['status'] as String?,
      userVerified: json['user_is_verified'] as bool?,
    );

Map<String, dynamic> _$MutedMemberDetailToJson(MutedMemberDetail instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('muted_member_id', instance.muteId);
  writeNotNull('muted_member', instance.mutedMemberId);
  writeNotNull('muted_by', instance.mutedById);
  writeNotNull('status', instance.status);
  writeNotNull('user_name', instance.mutedMemberUserName);
  writeNotNull('profile_picture', instance.mutedMemberProfilePicture);
  writeNotNull('user_is_verified', instance.userVerified);
  return val;
}
