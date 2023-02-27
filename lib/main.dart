import 'dart:io';
import 'package:auto_sync/constants/global_variables.dart';
import 'package:auto_sync/database/files_db.dart';
import 'package:auto_sync/features/file_upload/services/file_upload_services.dart';
import 'package:sqflite/sqflite.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:path_provider/path_provider.dart';
import 'package:workmanager/workmanager.dart';
import 'features/home/screens/home_screen.dart';

FileUploadServices services = FileUploadServices();


void callbackDispatcher() async
{
          WidgetsFlutterBinding.ensureInitialized();
  Workmanager().executeTask((taskName,input) async {
    switch(taskName)
    {
      case 'backUp':
        try{
          await openDatabase('files.db');
          print('Task Started');
          
          
          final file = await FilesDatabase.instance.readAllFiles();
          

          services.autoSyncFile(files: file);
          
        }
        catch(e){
          print(e.toString());
        }
        
        

        
    }
    return Future.value(true);
  },
  );
}




void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Workmanager().initialize(callbackDispatcher,
  isInDebugMode: true
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  


  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        scaffoldBackgroundColor: GlobalVariables.backgroundColor,
        colorScheme: const ColorScheme.light(
          primary: GlobalVariables.secondaryColor
        ),
        appBarTheme: const AppBarTheme(
          
          elevation: 0,
          iconTheme: IconThemeData(color: Colors.black)
        )
      ),
      home: const HomeScreen(),
    );
  }
}
  
