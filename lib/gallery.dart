

import 'dart:io';
import 'package:flutter/material.dart';
import 'package:gallery/full_screen.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';

 //changes in UI //
ValueNotifier<List> database = ValueNotifier([]);

class Gallery extends StatelessWidget {
  const Gallery({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      floatingActionButton: FloatingActionButton(
        backgroundColor: const Color.fromARGB(255, 58, 2, 2),

        onPressed: () async {
          final image =
              await ImagePicker().pickImage(source: ImageSource.camera);
          if (image == null) {
            return;
          } else {
//############# identifly the path ################
            Directory? directory = await getExternalStorageDirectory();
            File imagepath = File(image.path);
            await imagepath.copy('${directory!.path}/${DateTime.now()}.jpg');
            getitems(directory);
          }
        },
        child: const Icon(Icons.camera_alt_outlined),
      ),
      appBar: AppBar(
        centerTitle: true,
        title: const Text('My Gallery'),
      ),
      body: ValueListenableBuilder(
        valueListenable: database,
        builder: (context, List data, anything) {
          return GridView.builder(
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 3,
              mainAxisSpacing: 8,
              crossAxisSpacing: 8,
              ),
              itemCount: database.value.length,
            itemBuilder: (context,int index){
              return InkWell(
                  onTap: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (ctx) => FullScreenImg(
                            image: data[index], tagForHero: index),
                      ),
                    );
                  },
                  child: Hero(
                    tag: index,
                    child: Padding(
                      padding: const EdgeInsets.all(3.0),
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(5),
                          image: DecorationImage(
                            fit: BoxFit.fill,
                            image: FileImage(
                              File(
                                data[index],
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
             );
            },
          );
        },
      ),
    );
  }
}

// ########### add the path of image to database ########### //

getitems(Directory directory) async {
        //store image path//
  final listDir = await directory.list().toList();
  database.value.clear();
  for (var i = 0; i < listDir.length; i++) {
    if (listDir[i].path.substring(
            (listDir[i].path.length - 4), (listDir[i].path.length)) ==
        '.jpg') {
      database.value.add(listDir[i].path);
      database.notifyListeners();
    }
  }
}