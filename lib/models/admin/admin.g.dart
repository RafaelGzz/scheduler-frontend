// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'admin.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Admin _$AdminFromJson(Map<String, dynamic> json) {
  return Admin(
    id: json['_id'] as String?,
    name: json['name'] as String?,
    username: json['username'] as String?,
    password: json['password'] as String?,
  );
}

Map<String, dynamic> _$AdminToJson(Admin instance) => <String, dynamic>{
      '_id': instance.id,
      'username': instance.username,
      'name': instance.name,
      'password': instance.password,
    };
