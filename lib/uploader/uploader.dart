import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_uploader/uploader/upload_image_item.dart';
import 'package:flutter_uploader/uploader/upload_button.dart';
import 'package:flutter_uploader/uploader/upload_controller.dart';
import 'package:flutter_uploader/uploader/upload_file_item.dart';
import 'package:image_picker/image_picker.dart';

class Uploader extends StatefulWidget {
  const Uploader({
    Key? key,
    required this.customUpload,
    required this.uploadController,
  }) : super(key: key);
  final Future<String> Function(XFile) customUpload;

  final UploadController uploadController;
  @override
  State<Uploader> createState() => UploaderState();
}

class UploaderState extends State<Uploader> {
  final ImagePicker _picker = ImagePicker();

  _chooseImage() async {
    try {
      var pickRes = await _picker.pickImage(
        source: ImageSource.gallery,
      );
      if (pickRes == null) {
        throw Exception("选择图片异常");
      }
      var uploadFileItem = UploadFileItem(file: pickRes);
      widget.uploadController.addFileItem(uploadFileItem);
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return ListenableBuilder(
        listenable: widget.uploadController,
        builder: (BuildContext context, Widget? child) {
          var fileList = widget.uploadController.data;
          return Wrap(
            spacing: 10,
            runSpacing: 10,
            children: [
              ...List.generate(fileList.length, (index) {
                var fileItem = fileList[index];
                return UploadImageItem(
                  uploadItem: fileItem,
                  idx: index,
                  uploadFile: widget.customUpload,
                  uploadController: widget.uploadController,
                );
              }).toList(),
              !widget.uploadController.isFull
                  ? UploadButton(
                      onTap: _chooseImage,
                    )
                  : Container(),
            ],
          );
        });
  }
}
