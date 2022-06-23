// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'comment_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CommentDetail _$CommentDetailFromJson(Map<String, dynamic> json) =>
    CommentDetail(
      commentId: json['comment_id'] as int?,
      newsPostId: json['news_post_id'] as int?,
      usersId: json['users_id'] as int?,
      comment: json['comment'] as String?,
      commentLikes: json['comment_likes'] as int?,
      commentDatetime: json['comment_datetime'] as String?,
      status: json['status'] as String?,
      updatedAt: json['updated_at'] as String?,
      commentUserName: json['comment_user_name'] as String?,
      commentProfilePicture: json['comment_profile_picture'] as String?,
      isCommentLiked: json['is_comment_liked'] as String?,
      totalReplies: json['total_replies'] as int?,
      timeAgo: json['time_ago'] as String?,
      replyDetail: json['last_reply'] == null
          ? null
          : ReplyDetail.fromJson(json['last_reply']),
      userVerified: json['user_is_verified'] as bool?,
    );

Map<String, dynamic> _$CommentDetailToJson(CommentDetail instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('comment_id', instance.commentId);
  writeNotNull('news_post_id', instance.newsPostId);
  writeNotNull('users_id', instance.usersId);
  writeNotNull('comment', instance.comment);
  writeNotNull('comment_likes', instance.commentLikes);
  writeNotNull('comment_datetime', instance.commentDatetime);
  writeNotNull('status', instance.status);
  writeNotNull('updated_at', instance.updatedAt);
  writeNotNull('comment_user_name', instance.commentUserName);
  writeNotNull('comment_profile_picture', instance.commentProfilePicture);
  writeNotNull('is_comment_liked', instance.isCommentLiked);
  writeNotNull('total_replies', instance.totalReplies);
  writeNotNull('time_ago', instance.timeAgo);
  writeNotNull('user_is_verified', instance.userVerified);
  writeNotNull('last_reply', instance.replyDetail);
  return val;
}

ReplyDetail _$ReplyDetailFromJson(Map<String, dynamic> json) => ReplyDetail(
      replyId: json['reply_id'] as int?,
      commentId: json['comment_id'] as int?,
      usersId: json['users_id'] as int?,
      reply: json['reply'] as String?,
      replyLikes: json['reply_likes'] as int?,
      replyDatetime: json['reply_datetime'] as String?,
      status: json['status'] as String?,
      updatedAt: json['updated_at'] as String?,
      replyUserName: json['reply_user_name'] as String?,
      replyProfilePicture: json['reply_profile_picture'] as String?,
      isReplyLiked: json['is_reply_liked'] as String?,
      userVerified: json['user_is_verified'] as bool?,
    )..replyTimeAgo = json['reply_time_ago'] as String?;

Map<String, dynamic> _$ReplyDetailToJson(ReplyDetail instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('reply_id', instance.replyId);
  writeNotNull('comment_id', instance.commentId);
  writeNotNull('users_id', instance.usersId);
  writeNotNull('reply', instance.reply);
  writeNotNull('reply_likes', instance.replyLikes);
  writeNotNull('reply_time_ago', instance.replyTimeAgo);
  writeNotNull('reply_datetime', instance.replyDatetime);
  writeNotNull('status', instance.status);
  writeNotNull('updated_at', instance.updatedAt);
  writeNotNull('reply_user_name', instance.replyUserName);
  writeNotNull('reply_profile_picture', instance.replyProfilePicture);
  writeNotNull('is_reply_liked', instance.isReplyLiked);
  writeNotNull('user_is_verified', instance.userVerified);
  return val;
}
