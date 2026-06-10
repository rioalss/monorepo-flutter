// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_UserModel _$UserModelFromJson(Map<String, dynamic> json) => _UserModel(
      id: const SafeStringConverter().fromJson(json['id']),
      firstName: json['firstName'] == null
          ? ''
          : const SafeStringConverter().fromJson(json['firstName']),
      lastName: json['lastName'] == null
          ? ''
          : const SafeStringConverter().fromJson(json['lastName']),
      email: const SafeNullableStringConverter().fromJson(json['email']),
    );

Map<String, dynamic> _$UserModelToJson(_UserModel instance) =>
    <String, dynamic>{
      'id': const SafeStringConverter().toJson(instance.id),
      'firstName': const SafeStringConverter().toJson(instance.firstName),
      'lastName': const SafeStringConverter().toJson(instance.lastName),
      'email': const SafeNullableStringConverter().toJson(instance.email),
    };
