import 'package:kairo/features/time_tracking/data/models/time_record.dart';
import 'package:kairo/features/time_tracking/data/models/time_record_input.dart';
import 'package:kairo/features/time_tracking/data/time_records_api.dart';

class FakeTimeRecordsApi implements TimeRecordsApi {
  FakeTimeRecordsApi({List<TimeRecord> records = const [], this.listError})
    : _records = [...records];

  final List<TimeRecord> _records;
  final Exception? listError;
  final Map<String, TimeRecordInput> updated = {};

  @override
  Future<List<TimeRecord>> list() async {
    final error = listError;
    if (error != null) {
      throw error;
    }
    return [..._records];
  }

  @override
  Future<TimeRecord> update(String id, TimeRecordInput input) async {
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
