import 'dart:io';
import 'package:path_provider/path_provider.dart';

class DirFile{
  Future<void> createFile(String text) async {
    final directory = await getApplicationDocumentsDirectory();
    final file = File('${directory.path}/login.txt');
    await file.writeAsString(text);
  }

  Future<dynamic> readFile() async {
    try {
      final directory = await getApplicationDocumentsDirectory();
      final file = File('${directory.path}/login.txt');
      var text = await file.readAsString();
      return text;
    } catch (e) {
      print(e);
      return 'null';
    }
  }

  createDir() async {
    final docDir = await getApplicationDocumentsDirectory();
    final file = File('${docDir.path}/login.txt');
    if (await file.exists()) {
      return;
    }
    else
    createFile('0');
  }
}
