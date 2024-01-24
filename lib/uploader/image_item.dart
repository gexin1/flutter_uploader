import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class ImageItem extends StatelessWidget {
  const ImageItem({Key? key, required this.file}) : super(key: key);
  final XFile file;
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 80,
      height: 80,
      decoration: const BoxDecoration(
        color: Color.fromRGBO(231, 233, 236, 1),
      ),
      child: Image.file(
        File(file.path),
        fit: BoxFit.cover,
      ),
    );
  }
}
