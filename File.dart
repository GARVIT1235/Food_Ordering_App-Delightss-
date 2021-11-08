import 'dart:io';
import 'package:path_provider/path_provider.dart';

class DirFile {
  Future<void> createFile(String text) async {
    final directory = await getApplicationDocumentsDirectory();
    final file = File('${directory.path}/login/login.txt');
    await file.writeAsString(text);
  }

  Future<String> get readFile async {
    try {
      final directory = await getApplicationDocumentsDirectory();
      final file = File('${directory.path}/login/login.txt');
      String text = await file.readAsString();
      return text;
    } catch (e) {
      print(e);
      return 'null';
    }
  }

  createDir() async {
    final docDir = await getApplicationDocumentsDirectory();
    final file = Directory('${docDir.path}/login').create(recursive: true);
    final fle = File('$file/login.txt');
    if (fle.existsSync()) return;
    createFile('0');
  }
}
