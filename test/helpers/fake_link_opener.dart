import 'package:kairo/features/telegram/data/link_opener.dart';

class FakeLinkOpener implements LinkOpener {
  final List<Uri> opened = [];

  @override
  Future<bool> open(Uri uri) async {
    opened.add(uri);
    return true;
  }
}
