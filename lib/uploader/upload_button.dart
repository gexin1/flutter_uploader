import 'package:flutter/material.dart';

class UploadButton extends StatelessWidget {
  const UploadButton({Key? key, this.onTap}) : super(key: key);

  final void Function()? onTap;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        width: 80,
        height: 80,
        decoration: const BoxDecoration(
          color: Color.fromRGBO(231, 233, 236, 1),
        ),
        child: const Center(
          child: Icon(
            Icons.camera_alt_rounded,
            color: Color.fromRGBO(220, 222, 224, 1),
            size: 36,
          ),
        ),
      ),
    );
  }
}
