// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'auth_session_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_AuthSessionModel _$AuthSessionModelFromJson(Map<String, dynamic> json) =>
    _AuthSessionModel(
      accessToken: const SafeStringConverter().fromJson(json['accessToken']),
      refreshToken: const SafeStringConverter().fromJson(json['refreshToken']),
      userId: const SafeStringConverter().fromJson(json['id']),
    );

Map<String, dynamic> _$AuthSessionModelToJson(_AuthSessionModel instance) =>
    <String, dynamic>{
      'accessToken': const SafeStringConverter().toJson(instance.accessToken),
      'refreshToken': const SafeStringConverter().toJson(instance.refreshToken),
      'id': const SafeStringConverter().toJson(instance.userId),
    };
