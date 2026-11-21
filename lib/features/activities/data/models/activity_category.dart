import 'package:freezed_annotation/freezed_annotation.dart';

part 'activity_category.freezed.dart';
part 'activity_category.g.dart';

@freezed
abstract class ActivityCategory with _$ActivityCategory {
  const factory ActivityCategory({
    required String id,
    @JsonKey(name: 'nombre') required String name,
    @JsonKey(name: 'ambito') required String scope,
    @JsonKey(name: 'del_sistema') required bool system,
  }) = _ActivityCategory;

  factory ActivityCategory.fromJson(Map<String, dynamic> json) =>
      _$ActivityCategoryFromJson(json);
}
