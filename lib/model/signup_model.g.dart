// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'signup_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class ProfileAdapter extends TypeAdapter<Profile> {
  @override
  final int typeId = 129;

  @override
  Profile read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Profile(
      tempPasswordFlag: fields[1] as String?,
      status: fields[2] as String?,
      data: fields[3] as UserDetail?,
    );
  }

  @override
  void write(BinaryWriter writer, Profile obj) {
    writer
      ..writeByte(3)
      ..writeByte(1)
      ..write(obj.tempPasswordFlag)
      ..writeByte(2)
      ..write(obj.status)
      ..writeByte(3)
      ..write(obj.data);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ProfileAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

class UserDetailAdapter extends TypeAdapter<UserDetail> {
  @override
  final int typeId = 130;

  @override
  UserDetail read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return UserDetail(
      usersId: fields[1] as int?,
      userName: fields[2] as String?,
      email: fields[3] as String?,
      password: fields[4] as String?,
      confirmPassword: fields[5] as String?,
      accountType: fields[6] as String?,
      profilePicture: fields[7] as String?,
      socialAccType: fields[8] as String?,
      googleAccessToken: fields[9] as String?,
      facebookId: fields[10] as String?,
      description: fields[11] as String?,
      newsRadius: fields[12] as int?,
      notificationStatus: fields[13] as String?,
      dateAdded: fields[14] as String?,
      status: fields[15] as String?,
      rolesId: fields[16] as int?,
      updatedAt: fields[17] as String?,
      verifyCode: fields[18] as String?,
      address: fields[19] as String,
      country: fields[20] as String,
      latitude: fields[21] as double,
      longitude: fields[22] as double,
      userVerified: fields[23] as bool,
    );
  }

  @override
  void write(BinaryWriter writer, UserDetail obj) {
    writer
      ..writeByte(23)
      ..writeByte(1)
      ..write(obj.usersId)
      ..writeByte(2)
      ..write(obj.userName)
      ..writeByte(3)
      ..write(obj.email)
      ..writeByte(4)
      ..write(obj.password)
      ..writeByte(5)
      ..write(obj.confirmPassword)
      ..writeByte(6)
      ..write(obj.accountType)
      ..writeByte(7)
      ..write(obj.profilePicture)
      ..writeByte(8)
      ..write(obj.socialAccType)
      ..writeByte(9)
      ..write(obj.googleAccessToken)
      ..writeByte(10)
      ..write(obj.facebookId)
      ..writeByte(11)
      ..write(obj.description)
      ..writeByte(12)
      ..write(obj.newsRadius)
      ..writeByte(13)
      ..write(obj.notificationStatus)
      ..writeByte(14)
      ..write(obj.dateAdded)
      ..writeByte(15)
      ..write(obj.status)
      ..writeByte(16)
      ..write(obj.rolesId)
      ..writeByte(17)
      ..write(obj.updatedAt)
      ..writeByte(18)
      ..write(obj.verifyCode)
      ..writeByte(19)
      ..write(obj.address)
      ..writeByte(20)
      ..write(obj.country)
      ..writeByte(21)
      ..write(obj.latitude)
      ..writeByte(22)
      ..write(obj.longitude)
      ..writeByte(23)
      ..write(obj.userVerified);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is UserDetailAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

class UserLocationAdapter extends TypeAdapter<UserLocation> {
  @override
  final int typeId = 131;

  @override
  UserLocation read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return UserLocation();
  }

  @override
  void write(BinaryWriter writer, UserLocation obj) {
    writer..writeByte(0);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is UserLocationAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Profile _$ProfileFromJson(Map<String, dynamic> json) => Profile(
      userName: json['userName'] as String?,
      userEmail: json['userEmail'] as String?,
      userPassword: json['userPassword'] as String?,
      confirmPassword: json['confirmPassword'] as String?,
      tempPasswordFlag: json['temp_password_flag'] as String?,
      status: json['status'] as String?,
      data: json['data'] == null ? null : UserDetail.fromJson(json['data']),
    )..oneSignalId = json['oneSignalId'] as String?;

Map<String, dynamic> _$ProfileToJson(Profile instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('userName', instance.userName);
  writeNotNull('userEmail', instance.userEmail);
  writeNotNull('confirmPassword', instance.confirmPassword);
  writeNotNull('userPassword', instance.userPassword);
  writeNotNull('oneSignalId', instance.oneSignalId);
  writeNotNull('temp_password_flag', instance.tempPasswordFlag);
  writeNotNull('status', instance.status);
  writeNotNull('data', instance.data);
  return val;
}

UserDetail _$UserDetailFromJson(Map<String, dynamic> json) => UserDetail(
      usersId: json['users_id'] as int?,
      userName: json['user_name'] as String?,
      email: json['email'] as String?,
      password: json['password'] as String?,
      confirmPassword: json['confirm_password'] as String?,
      accountType: json['account_type'] as String?,
      profilePicture: json['profile_picture'] as String?,
      socialAccType: json['social_acc_type'] as String?,
      googleAccessToken: json['google_access_token'] as String?,
      facebookId: json['facebook_id'] as String?,
      description: json['description'] as String?,
      newsRadius: json['news_radius'] as int? ?? 0,
      notificationStatus: json['notification_status'] as String?,
      dateAdded: json['date_added'] as String?,
      status: json['status'] as String?,
      rolesId: json['roles_id'] as int?,
      updatedAt: json['updated_at'] as String?,
      verifyCode: json['verify_code'] as String?,
      joinedSince: json['joined_since'] as String? ?? "",
      totalFollowers: json['total_followers'] as int? ?? 0,
      totalPostCount: json['total_post_count'] as int? ?? 0,
      totalFollowing: json['total_following'] as int? ?? 0,
      totalComments: json['total_comments'] as int? ?? 0,
      totalViews: json['total_views'] as int? ?? 0,
      playerId: json['one_signal_id'] as String?,
      isFollowed: json['is_followed'] as bool? ?? false,
      isMuted: json['is_muted'] as bool? ?? false,
      address: json['address'] as String? ?? "",
      country: json['country'] as String? ?? "",
      latitude: (json['latitude'] as num?)?.toDouble() ?? 0,
      longitude: (json['longitude'] as num?)?.toDouble() ?? 0,
      userVerified: json['user_is_verified'] as bool? ?? false,
    );

Map<String, dynamic> _$UserDetailToJson(UserDetail instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('users_id', instance.usersId);
  writeNotNull('user_name', instance.userName);
  writeNotNull('email', instance.email);
  writeNotNull('password', instance.password);
  writeNotNull('confirm_password', instance.confirmPassword);
  writeNotNull('account_type', instance.accountType);
  writeNotNull('profile_picture', instance.profilePicture);
  writeNotNull('social_acc_type', instance.socialAccType);
  writeNotNull('google_access_token', instance.googleAccessToken);
  writeNotNull('facebook_id', instance.facebookId);
  writeNotNull('description', instance.description);
  writeNotNull('news_radius', instance.newsRadius);
  writeNotNull('notification_status', instance.notificationStatus);
  writeNotNull('date_added', instance.dateAdded);
  writeNotNull('status', instance.status);
  writeNotNull('roles_id', instance.rolesId);
  writeNotNull('updated_at', instance.updatedAt);
  writeNotNull('verify_code', instance.verifyCode);
  val['address'] = instance.address;
  val['country'] = instance.country;
  val['latitude'] = instance.latitude;
  val['longitude'] = instance.longitude;
  val['user_is_verified'] = instance.userVerified;
  val['joined_since'] = instance.joinedSince;
  val['total_followers'] = instance.totalFollowers;
  val['total_post_count'] = instance.totalPostCount;
  val['total_following'] = instance.totalFollowing;
  val['total_views'] = instance.totalViews;
  val['total_comments'] = instance.totalComments;
  writeNotNull('one_signal_id', instance.playerId);
  val['is_followed'] = instance.isFollowed;
  val['is_muted'] = instance.isMuted;
  return val;
}

UserLocation _$UserLocationFromJson(Map<String, dynamic> json) => UserLocation(
      address: json['address'] as String? ?? "Multan",
      country: json['country'] as String? ?? "Pakistan",
      latitude: (json['latitude'] as num?)?.toDouble() ?? 30.239829,
      longitude: (json['longitude'] as num?)?.toDouble() ?? 71.4853763,
    );

Map<String, dynamic> _$UserLocationToJson(UserLocation instance) =>
    <String, dynamic>{
      'address': instance.address,
      'country': instance.country,
      'latitude': instance.latitude,
      'longitude': instance.longitude,
    };
