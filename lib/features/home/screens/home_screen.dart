import 'package:auto_sync/database/files_db.dart';
import 'package:auto_sync/features/file_upload/screens/file_upload_screen.dart';
import 'package:auto_sync/features/file_upload/widget/files_container.dart';
import 'package:auto_sync/models/file_model_sqflite.dart';

import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:workmanager/workmanager.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});
  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late List<FileModelSqflite> files = [];
  bool isLoading = false;

  @override
  void dispose() {
    FilesDatabase.instance.close();

    super.dispose();
  }

  Future refreshFiles() async {
    setState(() => isLoading = true);

    files = await FilesDatabase.instance.readAllFiles();

    setState(() => isLoading = false);
  }

  @override
  void initState() {
    super.initState();
    refreshFiles();
    Workmanager().registerPeriodicTask(
      "backUp",
      "backUp",
      frequency: const Duration(minutes: 15),
      constraints: Constraints(networkType: NetworkType.connected),
    );
    
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromRGBO(226, 248, 242, 1),
      appBar: _buildAppBar(),
      body: SafeArea(
        child: isLoading
            ? const CircularProgressIndicator()
            : files.isEmpty
                ? const Text('No Files to sync')
                : buildFiles(),
      ),
      floatingActionButton: FloatingActionButton.extended(
          onPressed: () {
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (ctx) => const FileUploadScreen(),
              ),
            );
          },
          label: const Icon(Icons.add)),
    );
  }

  _buildAppBar() => PreferredSize(
        preferredSize: const Size.fromHeight(60),
        child: AppBar(
          flexibleSpace: Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  Color.fromARGB(255, 194, 255, 255),
                  Color.fromARGB(255, 158, 226, 226)
                ],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
            ),
          ),
          title: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(height: 42, child: Image.asset('assets/logo.png')),
              Container(
                margin: const EdgeInsets.only(left: 15),
                child: const Text(
                  'Auto-sync',
                  style: TextStyle(color: Colors.black, fontSize: 24),
                ),
              )
            ],
          ),
          centerTitle: true,
        ),
      );

  Widget buildFiles() => ListView.builder(
        itemCount: files.length,
        itemBuilder: ((context, index) {
          final file = files[index];
          return GestureDetector(
            child: Container(
              width: MediaQuery.of(context).size.width,
              padding:
                  const EdgeInsets.symmetric(horizontal: 10, vertical: 5.0),
              child: FileCardWidget(file: file, index: index),
            ),
          );
        }),
      );
}
