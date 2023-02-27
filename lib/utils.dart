import 'dart:io';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';


void showSnackBar(BuildContext context,String text)
{
  ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(text)));
}



Future<File> pickFiles() async {
  File file = File("");

  try {
    var result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['pdf', 'svg', 'jpg', 'png', 'doc', 'docx'],
      allowMultiple: false
    );
    if(result != null && result.files.isNotEmpty)
    {
      file = File(result.files.single.path!);
    }
  } catch (e) {
    debugPrint(e.toString());
  }

  return file;
}


