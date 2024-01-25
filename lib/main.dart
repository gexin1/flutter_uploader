import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_uploader/uploader/upload_controller.dart';
import 'package:flutter_uploader/uploader/uploader.dart';
import 'package:image_picker/image_picker.dart';

void main() {
  runApp(MainApp());
}

class MainApp extends StatelessWidget {
  MainApp({super.key});

  final UploadController _controller = UploadController(maxCount: 2);

  Future<String> uploadFile(XFile file) async {
    var url = "url";
    await Future.delayed(const Duration(seconds: 2));
    return Future(() => url + Random().nextInt(10).toString());
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(),
        body: Container(
            padding: const EdgeInsets.all(20),
            child: Column(
              children: [
                Uploader(
                  customUpload: uploadFile,
                  uploadController: _controller,
                ),
                ElevatedButton(
                  onPressed: () {
                    if (_controller.isDone) {
                      print(_controller.urls);
                    }
                  },
                  child: const Text("get data"),
                ),
              ],
            )),
      ),
    );
  }
}
