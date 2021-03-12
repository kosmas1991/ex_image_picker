import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  PickedFile imageFile;
  final picker = ImagePicker();
  _openGallery(BuildContext context) async{
    final pickedFile = await picker.getImage(source: ImageSource.gallery);
    setState(() {
      imageFile = pickedFile;
    });
    Navigator.of(context).pop();
  }

  _openCamera(BuildContext context) async{
    final pickedFile = await picker.getImage(source: ImageSource.camera);
    setState(() {
      imageFile = pickedFile;
    });
    Navigator.of(context).pop();
  }

  Future<void> showChoiceDialog(BuildContext context) {
    return showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Upload from'),
          content: SingleChildScrollView(
            child: ListBody(
              children: [
                GestureDetector(
                  child: Text('Gallery', style: TextStyle(fontSize: 20),),
                  onTap: () {
                    _openGallery(context);
                  },
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 12.0),
                  child: GestureDetector(
                    child: Text('Camera', style: TextStyle(fontSize: 20),),
                    onTap: () {
                      _openCamera(context);
                    },
                  ),
                )
              ],
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Image Picker'),
      ),
      body: Container(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              chooseWidget(),
              //Text('No image selected', style: TextStyle(fontSize: 20),),
              Container(
                decoration: BoxDecoration(
                    color: Colors.grey.shade300,
                    shape: BoxShape.rectangle,
                    borderRadius: BorderRadius.circular(40.0)),
                child: TextButton(
                    onPressed: () {
                      showChoiceDialog(context);
                    },
                    child: Text(
                      'Upload image',
                      style: TextStyle(fontSize: 20),
                    )),
              )
            ],
          ),
        ),
      ),
    );
  }
  Widget chooseWidget(){
    if (imageFile == null) {
      return Text('No image selected', style: TextStyle(fontSize: 20));
    } else {
      File selected = File(imageFile.path);
      return Image.file(selected,height: 400,width: 400,);
    }
  }
}
