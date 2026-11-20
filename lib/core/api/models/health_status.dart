import 'package:freezed_annotation/freezed_annotation.dart';

part 'health_status.freezed.dart';
part 'health_status.g.dart';

@freezed
abstract class HealthStatus with _$HealthStatus {
  const factory HealthStatus({required String status}) = _HealthStatus;

  factory HealthStatus.fromJson(Map<String, dynamic> json) =>
      _$HealthStatusFromJson(json);
}
