import 'package:json_annotation/json_annotation.dart';
part 'post_model.g.dart';

@JsonSerializable(includeIfNull: false)
class Post{
  String? status;
  @JsonKey(name: 'total_posts',)
  int? totalPosts;
  PostDetail? data;
}

@JsonSerializable(includeIfNull: false)
class BookmarkDetail{
  @JsonKey(name: 'bookmark_id',)
  int? bookmarkId;
  @JsonKey(name: 'news_post_id',)
  int? newsPostId;
  @JsonKey(name: 'users_id',)
  int? usersId;
  @JsonKey(name: 'bookmark_datetime',)
  String? bookmarkDatetime;
  @JsonKey(name: 'updated_at',)
  String? updatedAt;
  @JsonKey(name: 'bookmarked_post_details',)
  PostDetail? bookmarkedPostDetails;
  BookmarkDetail({this.bookmarkId,this.newsPostId,this.usersId,this.bookmarkDatetime,this.updatedAt,this.bookmarkedPostDetails});

  Map<String, dynamic> toJson() => _$BookmarkDetailToJson(this);
  factory BookmarkDetail.fromJson(json) => _$BookmarkDetailFromJson(json);
}

@JsonSerializable(includeIfNull: false)
class RecentDetail{
  @JsonKey(name: 'recent_search_id',)
  int? recentSearchId;
  @JsonKey(name: 'news_post_id',)
  int? newsPostId;
  @JsonKey(name: 'users_id',)
  int? usersId;
  @JsonKey(name: 'post_details',)
  PostDetail? postDetail;

  RecentDetail({this.usersId,this.recentSearchId,this.newsPostId,this.postDetail});
  Map<String, dynamic> toJson() => _$RecentDetailToJson(this);
  factory RecentDetail.fromJson(json) => _$RecentDetailFromJson(json);
}


@JsonSerializable(includeIfNull: false)
class PostDetail{
  @JsonKey(name: 'news_post_id',)
  int? newsPostId;
  @JsonKey(name: 'users_id',)
  int? usersId;
  String? title;
  String? description;
  String? category;
  @JsonKey(name: 'external_link',)
  String? externalLink;
  String? postalCode;
  String? location;
  String? country;
  double? longitude;
  double? latitude;
  @JsonKey(name: 'category_tag',)
  String? categoryTag;
  @JsonKey(name: 'post_picture',)
  String? postPicture;
  @JsonKey(name: 'happy_reactions',)
  int? happyReactions;
  @JsonKey(name: 'sad_reactions',)
  int? sadReactions;
  @JsonKey(name: 'total_views',)
  int? totalViews;
  @JsonKey(name: 'total_comments',)
  int? totalComments;
  @JsonKey(name: 'event_news_start_date',)
  String? eventNewsStartDate;
  @JsonKey(name: 'event_news_end_date',)
  String? eventNewsEndDate;
  @JsonKey(name: 'created_datetime',)
  String? createdAt;
  @JsonKey(name: 'updated_at',)
  String? updatedAt;
  String? status;
  @JsonKey(name: 'user_name',)
  String? userName;
  @JsonKey(name: 'time_ago',)
  String? timeAgo;
  @JsonKey(name: 'post_user_name',)
  String? postUserName;
  @JsonKey(name: 'post_user_profile_picture',)
  String? postUserProfilePicture;
  @JsonKey(name: 'is_bookmarked',)
  String? isBookmarked;
  @JsonKey(name: 'is_viewed',)
  bool? isViewed;
  @JsonKey(name: 'is_happy_reacted',)
  bool? isHappyReacted;
  @JsonKey(name: 'is_sad_reacted',)
  bool? isSadReacted;
  @JsonKey(name: 'user_is_verified',)
  bool userVerified;


  PostDetail({this.usersId,this.userName,this.newsPostId,this.title,this.description,this.category,this.externalLink,
    this.location,this.country,this.latitude,this.longitude,this.categoryTag,this.postPicture,this.happyReactions,
    this.postalCode,this.sadReactions,this.eventNewsStartDate,this.eventNewsEndDate,this.createdAt,this.updatedAt,
    this.status,this.timeAgo,this.postUserName,this.postUserProfilePicture,this.isBookmarked,this.isViewed,
    this.isHappyReacted, this.isSadReacted,this.totalViews,this.totalComments,this.userVerified=false
  });

  Map<String, dynamic> toJson() => _$PostDetailToJson(this);
  factory PostDetail.fromJson(json) => _$PostDetailFromJson(json);
}