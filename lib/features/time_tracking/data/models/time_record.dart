import 'package:freezed_annotation/freezed_annotation.dart';

part 'time_record.freezed.dart';
part 'time_record.g.dart';

@freezed
abstract class TimeRecord with _$TimeRecord {
  const factory TimeRecord({
    required String id,
    @JsonKey(name: 'categoria_id') required String categoryId,
    @JsonKey(name: 'inicio') required DateTime start,
    @JsonKey(name: 'fin') required DateTime end,
    @JsonKey(name: 'origen') required String origin,
    @JsonKey(name: 'actividad_id') String? activityId,
    @JsonKey(name: 'nota') String? note,
  }) = _TimeRecord;

  const TimeRecord._();

  factory TimeRecord.fromJson(Map<String, dynamic> json) =>
      _$TimeRecordFromJson(json);

  Duration get duration => end.difference(start);
}
