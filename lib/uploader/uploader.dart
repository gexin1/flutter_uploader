import 'package:flutter/material.dart';
import 'package:flutter_uploader/uploader/image_item.dart';
import 'package:flutter_uploader/uploader/upload_button.dart';
import 'package:image_picker/image_picker.dart';

class Uploader extends StatefulWidget {
  const Uploader({Key? key}) : super(key: key);

  @override
  _UploaderState createState() => _UploaderState();
}

class _UploaderState extends State<Uploader> {
  final ImagePicker _picker = ImagePicker();
  final List<XFile> fileList = [];
  _chooseImage() async {
    var pickRes = await _picker.pickImage(
      source: ImageSource.gallery,
    );
    if (pickRes == null) {
      print(pickRes);
      throw Exception("选择图片异常");
    }
    setState(() {
      fileList.add(pickRes);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Wrap(
        spacing: 10,
        runSpacing: 10,
        children: [
          ...fileList.map(
            (fileItem) {
              return ImageItem(
                file: fileItem,
              );
            },
          ).toList(),
          UploadButton(
            onTap: _chooseImage,
          )
        ],
      ),
    );
  }
}
