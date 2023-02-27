import 'dart:io';

import 'package:auto_sync/constants/error_handling.dart';
import 'package:auto_sync/database/files_db.dart';
import 'package:auto_sync/models/file_model_server.dart';
import 'package:auto_sync/models/file_model_sqflite.dart';
import 'package:auto_sync/utils.dart';
import 'package:cloudinary_public/cloudinary_public.dart';
import 'package:path_provider/path_provider.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:internet_connection_checker/internet_connection_checker.dart';
import '../../../constants/global_variables.dart';

class FileUploadServices {
  void uploadFiles({
    required BuildContext context,
    required String name,
    required String description,
    required File file,
  }) async {
    
    try{
      final cloudinary = CloudinaryPublic('do8dmh60d', 'bpqp67hy');
      String fileUrl;
      print(file.uri.toString());
      // CloudinaryResponse response = await cloudinary
      //       .uploadFile(CloudinaryFile.fromFile(file.path));
      CloudinaryResponse response = await cloudinary.uploadFile(CloudinaryFile.fromFile(file.path,folder: name));

      fileUrl = response.secureUrl;
      FileModelServer files = FileModelServer(
        name: name,
        description: description,
        file: fileUrl,
      );

      http.Response res = await http.post(
        Uri.parse('$uri/api/upload'),
        headers: {
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: files.toJson(),
      );

      httpErrorHandler(
          response: res,
          context: context,
          onSuccess: () {
            showSnackBar(context, 'Files uploaded Successfully');
            Navigator.pop(context);
          });
    }
    catch(e)
    {
      showSnackBar(context, e.toString());
    }
  }
  

  void storeFile({
    required BuildContext context,
    required String name,
    required String description,
    required String fileUrl,
  }) async {
    final file = FileModelSqflite(name: name, description: description, fileUrl: fileUrl);
    try{
      await FilesDatabase.instance.create(file);
      showSnackBar(context, 'No Internet Connection file Stored Locally');
      Navigator.of(context).pop();
    }

    catch(e)
    {
      showSnackBar(context, e.toString());
    }
    
    
    
  }

  // Future<List<FileModelSqflite>> getFilesToSync() async{
  //   return await FilesDatabase.instance.readAllFiles();
  // }

  void autoSyncFile({
    required List<FileModelSqflite> files
  }) async {
    try {
      print('Auto-sync Started');
      final cloudinary = CloudinaryPublic('do8dmh60d', 'bpqp67hy');
      List<String> fileUrls = [];

      File file = File(files[0].fileUrl.toString());
      
        print(file.path);
        print('Uploading');
        
           CloudinaryResponse response = await cloudinary.uploadFile(CloudinaryFile.fromFile(file.path,folder: files[0].name));
            print('Uploaded to cloudinary');
             fileUrls.add(response.secureUrl);
        
       
          
      
     
      print(fileUrls[0]);
      for (int i = 0; i < fileUrls.length; i++) {
        print('Uploading to node.js');
          FileModelServer file = FileModelServer(
        name: 'BackUp of ${DateTime.now().toString()}',
        description: 'All of the backup-files of ${DateTime.now().toString()}',
        file: fileUrls[i],
      );
            http.Response res = await http.post(
        Uri.parse('$uri/api/upload'),
        headers: {
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: file.toJson(),
      );
          
        // Hive.box<FileModel>('files').delete(files[i].name);
      }

      

      
      print('File backup success');
      
    } catch (e) {
      print(e.toString());
    }
  }


  Future<bool> checkConnectivity({required BuildContext context}) async {
    var hasInternet = await InternetConnectionChecker().hasConnection;
    return hasInternet;
  }

  
}
