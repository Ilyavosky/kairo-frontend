import 'package:freezed_annotation/freezed_annotation.dart';

part 'time_record_input.freezed.dart';
part 'time_record_input.g.dart';

@freezed
abstract class TimeRecordInput with _$TimeRecordInput {
  const factory TimeRecordInput({
    @JsonKey(name: 'categoria_id') required String categoryId,
    @JsonKey(name: 'inicio') required DateTime start,
    @JsonKey(name: 'fin') required DateTime end,
    @JsonKey(name: 'actividad_id') String? activityId,
    @JsonKey(name: 'nota') String? note,
  }) = _TimeRecordInput;

  factory TimeRecordInput.fromJson(Map<String, dynamic> json) =>
      _$TimeRecordInputFromJson(json);
}
