import 'dart:convert';






class FileModelServer {
  final String name;
  final String description;
  final String file;
  FileModelServer({
    required this.name,
    required this.description,
    required this.file,
  });

  
  

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'name': name,
      'description': description,
      'files': file,
    };
  }

  factory FileModelServer.fromMap(Map<String,dynamic> map){
    return FileModelServer(
      name: map['name'] ?? '',
      description: map['description'] ?? '',
      file: map['files'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory FileModelServer.fromJson(String source) => FileModelServer.fromMap(json.decode(source));
}
