import 'dart:io';
import 'package:flutter/material.dart';
import 'package:gallery/gallery.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    super.initState();
    Directory directory = Directory.fromUri(Uri.parse(
        '/storage/emulated/0/Android/data/com.example.custom_gallery/files'));
    getitems(directory);
  }
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Gallery(),
    );
  }
}