
import 'package:json_annotation/json_annotation.dart';
part 'about_model.g.dart';

@JsonSerializable(includeIfNull: false)
class AboutModel {

  String? status;
  String? data;
  String? message;
  AboutModel({this.status,this.data,this.message});

  Map<String, dynamic> toJson() => _$AboutModelToJson(this);
  factory AboutModel.fromJson(json) => _$AboutModelFromJson(json);
}