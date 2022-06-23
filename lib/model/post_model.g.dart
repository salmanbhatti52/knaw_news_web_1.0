// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'post_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Post _$PostFromJson(Map<String, dynamic> json) => Post()
  ..status = json['status'] as String?
  ..totalPosts = json['total_posts'] as int?
  ..data = json['data'] == null ? null : PostDetail.fromJson(json['data']);

Map<String, dynamic> _$PostToJson(Post instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('status', instance.status);
  writeNotNull('total_posts', instance.totalPosts);
  writeNotNull('data', instance.data);
  return val;
}

BookmarkDetail _$BookmarkDetailFromJson(Map<String, dynamic> json) =>
    BookmarkDetail(
      bookmarkId: json['bookmark_id'] as int?,
      newsPostId: json['news_post_id'] as int?,
      usersId: json['users_id'] as int?,
      bookmarkDatetime: json['bookmark_datetime'] as String?,
      updatedAt: json['updated_at'] as String?,
      bookmarkedPostDetails: json['bookmarked_post_details'] == null
          ? null
          : PostDetail.fromJson(json['bookmarked_post_details']),
    );

Map<String, dynamic> _$BookmarkDetailToJson(BookmarkDetail instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('bookmark_id', instance.bookmarkId);
  writeNotNull('news_post_id', instance.newsPostId);
  writeNotNull('users_id', instance.usersId);
  writeNotNull('bookmark_datetime', instance.bookmarkDatetime);
  writeNotNull('updated_at', instance.updatedAt);
  writeNotNull('bookmarked_post_details', instance.bookmarkedPostDetails);
  return val;
}

RecentDetail _$RecentDetailFromJson(Map<String, dynamic> json) => RecentDetail(
      usersId: json['users_id'] as int?,
      recentSearchId: json['recent_search_id'] as int?,
      newsPostId: json['news_post_id'] as int?,
      postDetail: json['post_details'] == null
          ? null
          : PostDetail.fromJson(json['post_details']),
    );

Map<String, dynamic> _$RecentDetailToJson(RecentDetail instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('recent_search_id', instance.recentSearchId);
  writeNotNull('news_post_id', instance.newsPostId);
  writeNotNull('users_id', instance.usersId);
  writeNotNull('post_details', instance.postDetail);
  return val;
}

PostDetail _$PostDetailFromJson(Map<String, dynamic> json) => PostDetail(
      usersId: json['users_id'] as int?,
      userName: json['user_name'] as String?,
      newsPostId: json['news_post_id'] as int?,
      title: json['title'] as String?,
      description: json['description'] as String?,
      category: json['category'] as String?,
      externalLink: json['external_link'] as String?,
      location: json['location'] as String?,
      country: json['country'] as String?,
      latitude: (json['latitude'] as num?)?.toDouble(),
      longitude: (json['longitude'] as num?)?.toDouble(),
      categoryTag: json['category_tag'] as String?,
      postPicture: json['post_picture'] as String?,
      happyReactions: json['happy_reactions'] as int?,
      postalCode: json['postalCode'] as String?,
      sadReactions: json['sad_reactions'] as int?,
      eventNewsStartDate: json['event_news_start_date'] as String?,
      eventNewsEndDate: json['event_news_end_date'] as String?,
      createdAt: json['created_datetime'] as String?,
      updatedAt: json['updated_at'] as String?,
      status: json['status'] as String?,
      timeAgo: json['time_ago'] as String?,
      postUserName: json['post_user_name'] as String?,
      postUserProfilePicture: json['post_user_profile_picture'] as String?,
      isBookmarked: json['is_bookmarked'] as String?,
      isViewed: json['is_viewed'] as bool?,
      isHappyReacted: json['is_happy_reacted'] as bool?,
      isSadReacted: json['is_sad_reacted'] as bool?,
      totalViews: json['total_views'] as int?,
      totalComments: json['total_comments'] as int?,
      userVerified: json['user_is_verified'] as bool? ?? false,
    );

Map<String, dynamic> _$PostDetailToJson(PostDetail instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('news_post_id', instance.newsPostId);
  writeNotNull('users_id', instance.usersId);
  writeNotNull('title', instance.title);
  writeNotNull('description', instance.description);
  writeNotNull('category', instance.category);
  writeNotNull('external_link', instance.externalLink);
  writeNotNull('postalCode', instance.postalCode);
  writeNotNull('location', instance.location);
  writeNotNull('country', instance.country);
  writeNotNull('longitude', instance.longitude);
  writeNotNull('latitude', instance.latitude);
  writeNotNull('category_tag', instance.categoryTag);
  writeNotNull('post_picture', instance.postPicture);
  writeNotNull('happy_reactions', instance.happyReactions);
  writeNotNull('sad_reactions', instance.sadReactions);
  writeNotNull('total_views', instance.totalViews);
  writeNotNull('total_comments', instance.totalComments);
  writeNotNull('event_news_start_date', instance.eventNewsStartDate);
  writeNotNull('event_news_end_date', instance.eventNewsEndDate);
  writeNotNull('created_datetime', instance.createdAt);
  writeNotNull('updated_at', instance.updatedAt);
  writeNotNull('status', instance.status);
  writeNotNull('user_name', instance.userName);
  writeNotNull('time_ago', instance.timeAgo);
  writeNotNull('post_user_name', instance.postUserName);
  writeNotNull('post_user_profile_picture', instance.postUserProfilePicture);
  writeNotNull('is_bookmarked', instance.isBookmarked);
  writeNotNull('is_viewed', instance.isViewed);
  writeNotNull('is_happy_reacted', instance.isHappyReacted);
  writeNotNull('is_sad_reacted', instance.isSadReacted);
  val['user_is_verified'] = instance.userVerified;
  return val;
}
