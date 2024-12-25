import 'dart:io';
import 'package:accounts_book/api/pdfapi.dart';
import 'package:flutter/services.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart';
import 'package:path_provider/path_provider.dart';

import '../controller/employess_controller.dart';
import '../model/employee.dart';

class PdfInvoice {
  static Future<File> generate(List<Employee> employee) async {
    final pdf = Document();
    var myTheme = ThemeData.withFont(
      base: Font.ttf(await rootBundle.load("fonts/OpenSans-Regular.ttf")),
      bold: Font.ttf(await rootBundle.load("fonts/OpenSans-Bold.ttf")),
      italic: Font.ttf(await rootBundle.load("fonts/OpenSans-Italic.ttf")),
      boldItalic:
          Font.ttf(await rootBundle.load("fonts/OpenSans-BoldItalic.ttf")),
    );
    final font = await rootBundle.load("fonts/OpenSans-Regular.ttf");
    final ttf = Font.ttf(font);

    pdf.addPage(MultiPage(
        theme: myTheme, build: (context) => [buildTitle(employee, ttf)]));
    return PdfApi.saveDocument(
      name: 'my_invoice.pdf',
      pdf: pdf,
    );
  }

  static Widget buildTitle(List<Employee> employee, Font ttf) {
    // Uint8List fontData = File('OpenSans-Regular.ttf').readAsBytesSync();
    //var data = rootBundle.load("fonts/OpenSans-Regular.ttf");
    // var myFont = Font.ttf(data);
    final headers = [
      'name',
      'salary',
      'designation',
    ];
    final emp = employee.map((item) {
      return [item.name, '${item.salary}', '${item.designation}'];
    }).toList();

    return Table.fromTextArray(
        headers: headers,
        data: emp,
        border: null,
        headerStyle: TextStyle(
          fontWeight: FontWeight.bold,
        ),
        headerDecoration: BoxDecoration(
          color: PdfColors.grey300,
        ),
        cellHeight: 30,
        cellAlignments: {
          0: Alignment.centerLeft,
          1: Alignment.centerRight,
          2: Alignment.centerRight,
        });
  }
}
