import 'package:kairo/features/time_tracking/data/models/time_record.dart';
import 'package:kairo/features/time_tracking/data/models/time_record_input.dart';
import 'package:kairo/features/time_tracking/data/time_records_api.dart';

class FakeTimeRecordsApi implements TimeRecordsApi {
  FakeTimeRecordsApi({
    List<TimeRecord> records = const [],
    this.listError,
    this.saveError,
  }) : _records = [...records];

  final List<TimeRecord> _records;
  final Exception? listError;
  final Exception? saveError;
  final Map<String, TimeRecordInput> updated = {};
  final List<TimeRecordInput> created = [];

  @override
  Future<List<TimeRecord>> list() async {
    final error = listError;
    if (error != null) {
      throw error;
    }
    return [..._records];
  }

  @override
  Future<TimeRecord> create(TimeRecordInput input) async {
    final error = saveError;
    if (error != null) {
      throw error;
    }
    created.add(input);
    final record = TimeRecord(
      id: 'manual-${created.length}',
      categoryId: input.categoryId,
      activityId: input.activityId,
      start: input.start,
      end: input.end,
      origin: 'manual',
      note: input.note,
    );
    _records.add(record);
    return record;
  }

  @override
  Future<TimeRecord> update(String id, TimeRecordInput input) async {
    final error = saveError;
    if (error != null) {
      throw error;
    }
    updated[id] = input;
    final index = _records.indexWhere((record) => record.id == id);
    final saved = _records[index].copyWith(
      categoryId: input.categoryId,
      activityId: input.activityId,
      start: input.start,
      end: input.end,
      note: input.note,
    );
    _records[index] = saved;
    return saved;
  }
}
