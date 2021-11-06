import 'package:json_annotation/json_annotation.dart';
part 'admin.g.dart';

@JsonSerializable()
class Admin {
  @JsonKey(name: "_id")
  String? id;
  String? username;
  String? name;
  String? password;

  Admin({
    this.id,
    this.name,
    this.username,
    this.password,
  });

  Map<String, dynamic> toJson() => _$AdminToJson(this);

  factory Admin.fromJson(Map<String, dynamic> json) => _$AdminFromJson(json);
}
