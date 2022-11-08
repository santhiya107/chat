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
//File? _image;
//
// final picker=ImagePicker();
//
// Future choiceImage() async{
//  var pickedImage= await picker.getImage(source: ImageSource.gallery);
//    if(pickedImage!=null)
//      {
//        setState(()
//           {
//            _image=File(pickedImage!.path);
//          });
//       }
//     }
    File? _pickedImage;

  void _pickImage() async {
    final pickedImageFile = await ImagePicker().pickImage(
      source: ImageSource.camera,
      imageQuality: 50,
      maxWidth: 150,
    );
    if(pickedImageFile!=null) {
      setState(() {
        _pickedImage = File(pickedImageFile!.path);
      });
    }
    widget.imagePickFn(File(pickedImageFile!.path));
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        CircleAvatar(
          radius: 40,
          backgroundColor: Colors.grey,
          backgroundImage:
          _pickedImage != null ? FileImage(_pickedImage!) : null,
        ),
        TextButton.icon(

          onPressed: _pickImage,
          icon: const Icon(Icons.image),
          label: const Text('Add Image'),
        ),
      ],
    );
  }
}