import 'package:flutter/material.dart';
import 'package:auto_sync/models/file_model_sqflite.dart';

class FileCardWidget extends StatelessWidget {
  final FileModelSqflite file;
  final int index;
  const FileCardWidget({
    Key? key,
    required this.file,
    required this.index,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      color : Colors.lightBlue,
      child: Container(
        constraints: BoxConstraints(minHeight: 40),
        padding: EdgeInsets.all(8.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(file.name),
            SizedBox(height: 10,),
            Text(file.description),
            SizedBox(height: 10,),
            Text(file.fileUrl),
          ],
        ),
      ),
    );
  }
}
