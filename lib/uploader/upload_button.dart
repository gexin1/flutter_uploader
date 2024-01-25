import 'package:flutter/material.dart';

class UploadButton extends StatelessWidget {
  const UploadButton({Key? key, this.onTap}) : super(key: key);

  final void Function()? onTap;
  @override
  Widget build(BuildContext context) {
    double imageWidth = 100;
    return InkWell(
      onTap: onTap,
      child: Container(
        width: imageWidth,
        height: imageWidth,
        decoration: BoxDecoration(
          color: Colors.black,
          borderRadius: BorderRadius.circular(8),
        ),
        child: const Center(
          child: Icon(
            Icons.camera_alt_rounded,
            color: Colors.white,
            size: 36,
          ),
        ),
      ),
    );
  }
}
