import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class UserImagePicker extends StatefulWidget {

 UserImagePicker(this.imagePickFn);

  final void Function(File pickedImage) imagePickFn;
  

  @override
  _UserImagePickerState createState() => _UserImagePickerState();
}

class _UserImagePickerState extends State<UserImagePicker> {
  

  File _pickedImage;
  
  void _pickImage() async {
    final pickedImageFile = await ImagePicker.pickImage(source: ImageSource.gallery);
    setState(() {
      _pickedImage = pickedImageFile;
    });
    widget.imagePickFn(pickedImageFile);
  }
  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.bottomRight,
      children: <Widget>[
        CircleAvatar(
          radius: 50,
          backgroundImage: _pickedImage != null ? FileImage(_pickedImage) : null,
          backgroundColor: Colors.blue,
          child: GestureDetector(
            onTap: () {
              _pickImage();
            },
          ),
        ),
        Padding(
          padding: EdgeInsets.all(8.0),
          child: Icon(
            Icons.add_circle,
            size: 18.0,
            color: Colors.white60,
          ),
        ),
      ],
    );
  }
}
