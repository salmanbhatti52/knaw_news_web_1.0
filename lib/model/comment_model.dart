import 'package:json_annotation/json_annotation.dart';
part 'comment_model.g.dart';

@JsonSerializable(includeIfNull: false)
class CommentDetail{
  @JsonKey(name: 'comment_id',)
  int? commentId;
  @JsonKey(name: 'news_post_id',)
  int? newsPostId;
  @JsonKey(name: 'users_id',)
  int? usersId;
  String? comment;
  @JsonKey(name: 'comment_likes',)
  int? commentLikes;
  @JsonKey(name: 'comment_datetime',)
  String? commentDatetime;
  String? status;
  @JsonKey(name: 'updated_at',)
  String? updatedAt;
  @JsonKey(name: 'comment_user_name',)
  String? commentUserName;
  @JsonKey(name: 'comment_profile_picture',)
  String? commentProfilePicture;
  @JsonKey(name: 'is_comment_liked',)
  String? isCommentLiked;
  @JsonKey(name: 'total_replies',)
  int? totalReplies;
  @JsonKey(name: 'time_ago',)
  String? timeAgo;
  @JsonKey(name: 'user_is_verified',)
  bool? userVerified;
  @JsonKey(name: 'last_reply',)
  ReplyDetail? replyDetail;

  CommentDetail({this.commentId,this.newsPostId,this.usersId,this.comment,this.commentLikes,this.commentDatetime,
  this.status,this.updatedAt,this.commentUserName,this.commentProfilePicture,this.isCommentLiked,this.totalReplies,
    this.timeAgo,this.replyDetail,this.userVerified
  });

  Map<String, dynamic> toJson() => _$CommentDetailToJson(this);
  factory CommentDetail.fromJson(json) => _$CommentDetailFromJson(json);

}

@JsonSerializable(includeIfNull: false)

class ReplyDetail{
  @JsonKey(name: 'reply_id',)
  int? replyId;
  @JsonKey(name: 'comment_id',)
  int? commentId;
  @JsonKey(name: 'users_id',)
  int? usersId;
  String? reply;
  @JsonKey(name: 'reply_likes',)
  int? replyLikes;
  @JsonKey(name: 'reply_time_ago',)
  String? replyTimeAgo;
  @JsonKey(name: 'reply_datetime',)
  String? replyDatetime;
  String? status;
  @JsonKey(name: 'updated_at',)
  String? updatedAt;
  @JsonKey(name: 'reply_user_name',)
  String? replyUserName;
  @JsonKey(name: 'reply_profile_picture',)
  String? replyProfilePicture;
  @JsonKey(name: 'is_reply_liked',)
  String? isReplyLiked;
  @JsonKey(name: 'user_is_verified',)
  bool? userVerified;

  ReplyDetail({this.replyId,this.commentId,this.usersId,this.reply,this.replyLikes,this.replyDatetime,
    this.status,this.updatedAt,this.replyUserName,this.replyProfilePicture,this.isReplyLiked,this.userVerified
  });
  Map<String, dynamic> toJson() => _$ReplyDetailToJson(this);
  factory ReplyDetail.fromJson(json) => _$ReplyDetailFromJson(json);
}