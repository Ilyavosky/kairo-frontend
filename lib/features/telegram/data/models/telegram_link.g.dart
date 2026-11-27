// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'telegram_link.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_TelegramLink _$TelegramLinkFromJson(Map<String, dynamic> json) =>
    _TelegramLink(
      code: json['codigo'] as String,
      command: json['comando'] as String,
      expiresAt: DateTime.parse(json['expira_en'] as String),
    );

Map<String, dynamic> _$TelegramLinkToJson(_TelegramLink instance) =>
    <String, dynamic>{
      'codigo': instance.code,
      'comando': instance.command,
      'expira_en': instance.expiresAt.toIso8601String(),
    };
