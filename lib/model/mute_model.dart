import 'package:json_annotation/json_annotation.dart';
part 'mute_model.g.dart';

@JsonSerializable(includeIfNull: false)
class MutedMemberDetail{
  @JsonKey(name: 'muted_member_id',)
  int? muteId;
  @JsonKey(name: 'muted_member',)
  int? mutedMemberId;
  @JsonKey(name: 'muted_by',)
  int? mutedById;
  String? status;
  @JsonKey(name: 'user_name',)
  String? mutedMemberUserName;
  @JsonKey(name: 'profile_picture',)
  String? mutedMemberProfilePicture;
  @JsonKey(name: 'user_is_verified',)
  bool? userVerified;
  MutedMemberDetail({this.muteId,this.mutedById,this.mutedMemberId,this.mutedMemberUserName,this.mutedMemberProfilePicture,this.status,this.userVerified});

  Map<String, dynamic> toJson() => _$MutedMemberDetailToJson(this);
  factory MutedMemberDetail.fromJson(json) => _$MutedMemberDetailFromJson(json);
}