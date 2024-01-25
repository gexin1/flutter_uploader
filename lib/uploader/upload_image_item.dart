import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_uploader/uploader/upload_controller.dart';
import 'package:flutter_uploader/uploader/upload_file_item.dart';
import 'package:image_picker/image_picker.dart';

class UploadImageItem extends StatefulWidget {
  const UploadImageItem({
    Key? key,
    required this.uploadItem,
    required this.idx,
    required this.uploadFile,
    required this.uploadController,
  }) : super(key: key);
  final UploadFileItem uploadItem;

  final int idx;
  final Future<String> Function(XFile) uploadFile;

  final UploadController uploadController;
  @override
  State<UploadImageItem> createState() => _ImageItemState();
}

class _ImageItemState extends State<UploadImageItem> {
  @override
  void dispose() {
    super.dispose();
  }

  @override
  initState() {
    super.initState();
    Future.microtask(() => uploadImage());
  }

  uploadImage() async {
    try {
      widget.uploadController
          .changeStatus(widget.idx, UploadStatusEnum.uploading);
      var result = await widget.uploadFile(widget.uploadItem.file!);
      if (mounted) {
        widget.uploadController.changeUrl(widget.idx, result);
        widget.uploadController.changeStatus(widget.idx, UploadStatusEnum.done);
      }
    } catch (e) {
      if (mounted) {
        widget.uploadController
            .changeStatus(widget.idx, UploadStatusEnum.failed);
      }
    }
  }

  reUpload() async {
    if (widget.uploadItem.status == UploadStatusEnum.failed) {
      await uploadImage();
    }
  }

  removeFile() {
    widget.uploadController.removeFileItem(widget.idx);
  }

  @override
  Widget build(BuildContext context) {
    double imageWidth = 100;

    Widget? statusWidget;
    Widget? imageWidget;
    if (widget.uploadItem.status == UploadStatusEnum.failed) {
      statusWidget = const Icon(
        Icons.refresh_rounded,
        size: 30,
        color: Colors.white,
      );
    } else if (widget.uploadItem.status == UploadStatusEnum.uploading) {
      statusWidget = const SizedBox(
        width: 25,
        height: 25,
        child: CircularProgressIndicator(),
      );
    }
    if (widget.uploadItem.file?.path != null) {
      imageWidget = Image.file(
        File(widget.uploadItem.file!.path),
        fit: BoxFit.cover,
      );
    } else if (widget.uploadItem.url != null) {
      imageWidget = Image.network(
        widget.uploadItem.url!,
        fit: BoxFit.cover,
      );
    } else {
      imageWidget = Container();
    }
    return Container(
      width: imageWidth,
      height: imageWidth,
      decoration: const BoxDecoration(
        color: Color.fromRGBO(231, 233, 236, 1),
      ),
      child: Stack(
        children: [
          SizedBox.expand(
            child: ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: imageWidget,
            ),
          ),
          statusWidget == null
              ? Container()
              : Positioned.fill(
                  child: InkWell(
                    onTap: reUpload,
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8),
                        color: const Color.fromRGBO(0, 0, 0, 0.6),
                      ),
                      child: Center(
                        child: statusWidget,
                      ),
                    ),
                  ),
                ),
          Positioned(
            top: 0,
            right: 0,
            child: InkWell(
              onTap: removeFile,
              child: Container(
                decoration: BoxDecoration(
                  color: const Color.fromRGBO(0, 0, 0, 0.6),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: const Icon(
                  Icons.close_rounded,
                  color: Colors.white,
                  size: 20,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
