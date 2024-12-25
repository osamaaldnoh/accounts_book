import 'dart:io';

import 'package:path_provider/path_provider.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart';

class PdfApi {
  static Future<File> saveDocument(
      {required String name, required Document pdf}) async {
    late final File file;
    try {
      final bytes = await pdf.save();
      final dir = await getExternalStorageDirectory();

      final String path = '$dir/test_pdf.pdf';
      file = File('${dir!.path}/$name');
      await file.writeAsBytes(bytes);
    } catch (e) {}
    return file;
  }

  // static Future openFile(File file) async {
  //   final url = file.path;
  //   await OpenFile.open(url);
  // }
}
