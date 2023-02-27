import 'dart:convert';
import 'dart:io';
import 'package:auto_sync/common_widgets/custom_text_button.dart';
import 'package:auto_sync/common_widgets/custom_text_field.dart';
import 'package:auto_sync/features/file_upload/services/file_upload_services.dart';
import 'package:auto_sync/utils.dart';
import 'package:flutter/material.dart';
import 'package:dotted_border/dotted_border.dart';


class FileUploadScreen extends StatefulWidget {
  const FileUploadScreen({super.key});

  @override
  State<FileUploadScreen> createState() => _FileUploadScreenState();
}

class _FileUploadScreenState extends State<FileUploadScreen> {
  bool hasInternet = false;
  final _formKey = GlobalKey<FormState>();
  File file = File("");
  final TextEditingController _textNameController = TextEditingController();
  final TextEditingController _textDesController = TextEditingController();
  final FileUploadServices services = FileUploadServices();

  Future<bool> checkConnection() async
  {
    hasInternet = await services.checkConnectivity(context: context);
    return hasInternet;
  }


  void uploadFiles() {
    if(_formKey.currentState!.validate() && file != null)
    {
      services.uploadFiles(
      context: context,
      name: _textNameController.text,
      description: _textDesController.text,
      file: file,
    );
    }
    
  }

  

  void selectFiles() async {
    var res = await pickFiles();
    setState(() {
      file = res;
    });
  }

  void storeFilesLocally() {
    final fileData = base64Encode(file.readAsBytesSync());
    print(fileData);
    if(_formKey.currentState!.validate())
    {
      services.storeFile(context: context, name: _textNameController.text, description: _textDesController.text, fileUrl: fileData);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar(),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: SafeArea(
          child: Form(
            key: _formKey,
            child: ListView(
              children: [
                const SizedBox(
                  height: 20,
                ),
                CustomTextField(
                    controller: _textNameController, hintText: 'Folder Name'),
                    const SizedBox(
                  height: 20,
                ),
                CustomTextField(
                    controller: _textDesController, hintText: 'Description'),
                    const SizedBox(
                  height: 20,
                ),
                GestureDetector(
                  onTap: selectFiles,
                  child: DottedBorder(
                    child: Container(
                      width: double.infinity,
                      height: 150,
                      decoration:
                          BoxDecoration(borderRadius: BorderRadius.circular(10)),
                      child: Column(
                        children: const [
                          Icon(
                            Icons.folder_open,
                            size: 50,
                          ),
                          Text('Select Images to upload'),
                        ],
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                CustomButton(text: 'Upload',fontSize: 24, onTap: () async {
                  await checkConnection() ? uploadFiles()  : storeFilesLocally(); 
                })
              ],
            ),
          ),
        ),
      ),
    );
  }

   _buildAppBar() => 
     PreferredSize(
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
              Expanded(
                child: Container(
                  height: 42,
                  margin: const EdgeInsets.only(left: 15),
                  child: Image.asset('assets/logo.png')
                ),
              ),
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
}
