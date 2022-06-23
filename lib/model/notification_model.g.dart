// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'notification_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

NotificationModel _$NotificationModelFromJson(Map<String, dynamic> json) =>
    NotificationModel(
      yesterdayNotifications:
          (json['yesterday_notifications'] as List<dynamic>?)
              ?.map((e) => NotificationDetail.fromJson(e))
              .toList(),
      thisWeekNotifications: (json['this_week_notifications'] as List<dynamic>?)
          ?.map((e) => NotificationDetail.fromJson(e))
          .toList(),
    );

Map<String, dynamic> _$NotificationModelToJson(NotificationModel instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('yesterday_notifications', instance.yesterdayNotifications);
  writeNotNull('this_week_notifications', instance.thisWeekNotifications);
  return val;
}

NotificationDetail _$NotificationDetailFromJson(Map<String, dynamic> json) =>
    NotificationDetail(
      notificationId: json['notification_id'] as int?,
      senderUsersId: json['sender_users_id'] as int?,
      receiverUsersId: json['receiver_users_id'] as int?,
      notificationType: json['notification_type'] as String?,
      message: json['message'] as String?,
      newsPostId: json['news_post_id'] as int?,
      datetime: json['datetime'] as String?,
      senderUsername: json['sender_user_name'] as String?,
      isFollowingBack: json['is_following_back'] as bool?,
      senderUserProfilePicture: json['sender_user_profile_picture'] as String?,
      newsPostPicture: json['news_post_picture'] as String?,
      daysAgo: json['days_ago'] as String?,
      userVerified: json['user_is_verified'] as bool?,
    );

Map<String, dynamic> _$NotificationDetailToJson(NotificationDetail instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('notification_id', instance.notificationId);
  writeNotNull('sender_users_id', instance.senderUsersId);
  writeNotNull('receiver_users_id', instance.receiverUsersId);
  writeNotNull('notification_type', instance.notificationType);
  writeNotNull('message', instance.message);
  writeNotNull('news_post_id', instance.newsPostId);
  writeNotNull('datetime', instance.datetime);
  writeNotNull('sender_user_name', instance.senderUsername);
  writeNotNull('is_following_back', instance.isFollowingBack);
  writeNotNull(
      'sender_user_profile_picture', instance.senderUserProfilePicture);
  writeNotNull('news_post_picture', instance.newsPostPicture);
  writeNotNull('days_ago', instance.daysAgo);
  writeNotNull('user_is_verified', instance.userVerified);
  return val;
}
