import 'dart:io';
import 'package:flutter/material.dart';
import 'package:gallery/gallery.dart';


class FullScreenImg extends StatelessWidget {
  const FullScreenImg({Key? key, this.image, required this.tagForHero}): super(key: key);
  final dynamic image;
  final int tagForHero;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
      ),
      backgroundColor: Colors.transparent,
      body: ValueListenableBuilder(
          valueListenable: database,
          builder: (context, List data, _) {
            return Padding(
              padding: const EdgeInsets.only(left: 20, right: 20),
              child: Center(
                child: Hero(
                    tag: tagForHero,
                    child: Image.file(File(image.toString()))),
              ),
            );
          }),
    );
  }
}