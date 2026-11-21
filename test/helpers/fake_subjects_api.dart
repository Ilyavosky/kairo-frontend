import 'package:kairo/features/subjects/data/models/subject.dart';
import 'package:kairo/features/subjects/data/models/subject_input.dart';
import 'package:kairo/features/subjects/data/subjects_api.dart';

class FakeSubjectsApi implements SubjectsApi {
  FakeSubjectsApi({List<Subject> subjects = const [], this.listError})
    : _subjects = [...subjects];

  final List<Subject> _subjects;
  final Exception? listError;
  final List<String> archivedIds = [];
  var _nextId = 1;

  @override
  Future<List<Subject>> listActive() async {
    final error = listError;
    if (error != null) {
      throw error;
    }
    return [
      for (final subject in _subjects)
        if (subject.active) subject,
    ];
  }

  @override
  Future<Subject> get(String id) async {
    return _subjects.firstWhere((subject) => subject.id == id);
  }

  @override
  Future<Subject> create(SubjectInput input) async {
    final subject = Subject(
      id: 'nueva-${_nextId++}',
      name: input.name,
      period: input.period,
      active: true,
      teacher: input.teacher,
      code: input.code,
    );
    _subjects.add(subject);
    return subject;
  }

  @override
  Future<Subject> update(String id, SubjectInput input) async {
    final index = _subjects.indexWhere((subject) => subject.id == id);
    final updated = _subjects[index].copyWith(
      name: input.name,
      period: input.period,
      teacher: input.teacher,
      code: input.code,
    );
    _subjects[index] = updated;
    return updated;
  }

  @override
  Future<Subject> archive(String id) async {
    archivedIds.add(id);
    final index = _subjects.indexWhere((subject) => subject.id == id);
    final archived = _subjects[index].copyWith(active: false);
    _subjects[index] = archived;
    return archived;
  }
}
