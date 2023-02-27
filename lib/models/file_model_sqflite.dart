import 'dart:convert';

final String tableFiles = 'files';

class FileFields {
  static final List<String> values = [
    id,name,description,fileUrl
  ];

  static final String id = '_id';
  static final String name = 'name';
  static final String description = 'description';
  static final String fileUrl = 'fileUrl';
}

class FileModelSqflite {
  final int? id;
  final String name;
  final String description;
  final String fileUrl;
  FileModelSqflite({
    this.id,
    required this.name,
    required this.description,
    required this.fileUrl,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      FileFields.id: id,
      FileFields.name: name,
      FileFields.description: description,
      FileFields.fileUrl: fileUrl,
    };
  }



  static FileModelSqflite fromMap(Map<String, dynamic> map) {
    return FileModelSqflite(
      id: map[FileFields.id] as int?,
      name: map[FileFields.name] as String,
      description: map[FileFields.description] as String,
      fileUrl: map[FileFields.fileUrl] as String,
    );
  }

  String toJson() => json.encode(toMap());

  // factory FileModelSqflite.fromJson(String source) =>
  //     FileModelSqflite.fromMap(json.decode(source) as Map<String, dynamic>);

  

  FileModelSqflite copyWith({
    int? id,
    String? name,
    String? description,
    String? fileUrl,
  }) {
    return FileModelSqflite(
      id: id ?? this.id,
      name: name ?? this.name,
      description: description ?? this.description,
      fileUrl: fileUrl ?? this.fileUrl,
    );
  }
}
