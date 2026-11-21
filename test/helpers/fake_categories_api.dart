import 'package:kairo/features/activities/data/categories_api.dart';
import 'package:kairo/features/activities/data/models/activity_category.dart';

class FakeCategoriesApi implements CategoriesApi {
  FakeCategoriesApi({this.categories = const [], this.listError});

  final List<ActivityCategory> categories;
  final Exception? listError;

  @override
  Future<List<ActivityCategory>> list() async {
    final error = listError;
    if (error != null) {
      throw error;
    }
    return categories;
  }
}
