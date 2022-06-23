import 'package:json_annotation/json_annotation.dart';
part 'notification_model.g.dart';

@JsonSerializable(includeIfNull: false)
class NotificationModel{
  @JsonKey(name: 'yesterday_notifications',)
  List<NotificationDetail>? yesterdayNotifications;
  @JsonKey(name: 'this_week_notifications',)
  List<NotificationDetail>? thisWeekNotifications;

  NotificationModel({this.yesterdayNotifications,this.thisWeekNotifications});
  Map<String, dynamic> toJson() => _$NotificationModelToJson(this);
  factory NotificationModel.fromJson(json) => _$NotificationModelFromJson(json);

}

@JsonSerializable(includeIfNull: false)
class NotificationDetail{
  @JsonKey(name: 'notification_id',)
  int? notificationId;
  @JsonKey(name: 'sender_users_id',)
  int? senderUsersId;
  @JsonKey(name: 'receiver_users_id',)
  int? receiverUsersId;
  @JsonKey(name: 'notification_type',)
  String? notificationType;
  String? message;
  @JsonKey(name: 'news_post_id',)
  int? newsPostId;
  String? datetime;
  @JsonKey(name: 'sender_user_name',)
  String? senderUsername;
  @JsonKey(name: 'is_following_back',)
  bool? isFollowingBack;
  @JsonKey(name: 'sender_user_profile_picture',)
  String? senderUserProfilePicture;
  @JsonKey(name: 'news_post_picture',)
  String? newsPostPicture;
  @JsonKey(name: 'days_ago',)
  String? daysAgo;
  @JsonKey(name: 'user_is_verified',)
  bool? userVerified;

  NotificationDetail({this.notificationId,this.senderUsersId,this.receiverUsersId,this.notificationType,
  this.message,this.newsPostId,this.datetime,this.senderUsername,this.isFollowingBack,this.senderUserProfilePicture,
    this.newsPostPicture,this.daysAgo,this.userVerified
  });
  Map<String, dynamic> toJson() => _$NotificationDetailToJson(this);
  factory NotificationDetail.fromJson(json) => _$NotificationDetailFromJson(json);
}