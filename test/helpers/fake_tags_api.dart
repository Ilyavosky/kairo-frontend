import 'package:kairo/features/tags/data/models/tag.dart';
import 'package:kairo/features/tags/data/tags_api.dart';

class FakeTagsApi implements TagsApi {
  FakeTagsApi({
    List<Tag> tags = const [],
    Map<String, List<String>> assigned = const {},
    this.createError,
  }) : _tags = [...tags],
       _assigned = {
         for (final entry in assigned.entries) entry.key: [...entry.value],
       };

  final List<Tag> _tags;
  final Map<String, List<String>> _assigned;
  final Exception? createError;
  final List<String> createdNames = [];
  final List<(String, String)> assignments = [];
  final List<(String, String)> removals = [];

  @override
  Future<List<Tag>> list() async => [..._tags];

  @override
  Future<List<Tag>> ofActivity(String activityId) async {
    final ids = _assigned[activityId] ?? const [];
    return [
      for (final tag in _tags)
        if (ids.contains(tag.id)) tag,
    ];
  }

  @override
  Future<Tag> create(String name) async {
    createdNames.add(name);
    final error = createError;
    if (error != null) {
      throw error;
    }
    final tag = Tag(id: 'etiqueta-nueva-${createdNames.length}', name: name);
    _tags.add(tag);
    return tag;
  }

  @override
  Future<void> assign(String activityId, String tagId) async {
    assignments.add((activityId, tagId));
    (_assigned[activityId] ??= []).add(tagId);
  }

  @override
  Future<void> remove(String activityId, String tagId) async {
    removals.add((activityId, tagId));
    _assigned[activityId]?.remove(tagId);
  }
}
