// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'about_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AboutModel _$AboutModelFromJson(Map<String, dynamic> json) => AboutModel(
      status: json['status'] as String?,
      data: json['data'] as String?,
      message: json['message'] as String?,
    );

Map<String, dynamic> _$AboutModelToJson(AboutModel instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('status', instance.status);
  writeNotNull('data', instance.data);
  writeNotNull('message', instance.message);
  return val;
}
