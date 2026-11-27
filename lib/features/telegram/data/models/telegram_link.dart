import 'package:freezed_annotation/freezed_annotation.dart';

part 'telegram_link.freezed.dart';
part 'telegram_link.g.dart';

@freezed
abstract class TelegramLink with _$TelegramLink {
  const factory TelegramLink({
    @JsonKey(name: 'codigo') required String code,
    @JsonKey(name: 'comando') required String command,
    @JsonKey(name: 'expira_en') required DateTime expiresAt,
  }) = _TelegramLink;

  factory TelegramLink.fromJson(Map<String, dynamic> json) =>
      _$TelegramLinkFromJson(json);
}
