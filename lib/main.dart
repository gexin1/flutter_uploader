import 'package:flutter/material.dart';
import 'package:flutter_uploader/uploader/uploader.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(),
        body: Container(
          padding: const EdgeInsets.all(20),
          child: const Uploader(),
        ),
      ),
    );
  }
}
