import 'dart:convert';

import 'package:excel/excel.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String? _output;

  Future<void> _pickAndOpenExcelFile() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      withData: true,
      allowedExtensions: ['xlsx', 'xls', 'csv'],
    );

    if (result != null) {
      var bytes = result.files.first.bytes!;
      var excel = Excel.decodeBytes(bytes);
      for (var table in excel.tables.keys) {
        for (var row in excel.tables[table]!.rows) {
          setState(() {
            print(jsonDecode(row.toString()));
            print('-------------------');
            _output = row.join(' | '); // 这只是一个简单的示例，您可以根据需要进行修改。
          });
        }
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Excel File Picker'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            ElevatedButton(
              onPressed: _pickAndOpenExcelFile,
              child: Text('选择并打开 Excel 文件'),
            ),
            if (_output != null) Text(_output!),
          ],
        ),
      ),
    );
  }
}
