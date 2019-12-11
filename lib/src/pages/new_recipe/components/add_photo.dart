import 'dart:io';
import 'package:flutter/material.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/widgets.dart';
import 'package:image_picker/image_picker.dart';
import 'package:zero_waste_cookbook/utils/singletons/translator.dart';

class AddPhoto extends StatefulWidget {
  final String photoPath;

  AddPhoto({Key key, @required this.photoPath}) : super(key: key);

  createState() => _AddPhotoState(this.photoPath);
}

class _AddPhotoState extends State<AddPhoto> {
  File _imageFile;
  String _imageFileURL;
  String imageName;

  _AddPhotoState(String photoPath) {
    imageName = photoPath;
  }

  Future<void> _pickImage(ImageSource source) async {
    File selected = await ImagePicker.pickImage(
        source: source, maxWidth: 800, maxHeight: 450);
    setState(() {
      _imageFile = selected;
    });
    if (selected != null) {
      uploadFile();
    }
  }

  /// Remove image
  void _clear() {
    setState(() => _imageFile = null);
  }

  @override
  Widget build(BuildContext context) => Column(
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              IconButton(
                icon: Icon(
                  Icons.camera,
                  color: Colors.grey,
                ),
                onPressed: () => _pickImage(ImageSource.camera),
                splashColor: Colors.transparent,
                highlightColor: Colors.transparent,
                alignment: Alignment.topRight,
              ),
              Text(
                Translator.instance.translations['from_camera'],
                style: TextStyle(
                  color: Colors.grey,
                ),
              ),
              IconButton(
                icon: Icon(
                  Icons.photo_album,
                  color: Colors.grey,
                ),
                onPressed: () => _pickImage(ImageSource.gallery),
                splashColor: Colors.transparent,
                highlightColor: Colors.transparent,
                alignment: Alignment.topRight,
              ),
              Text(
                Translator.instance.translations['from_gallery'],
                style: TextStyle(
                  color: Colors.grey,
                ),
              ),
            ],
          ),
          if (_imageFile != null) ...[
            Image.file(_imageFile),
            Row(
              children: <Widget>[
                FlatButton(
                  child: Icon(Icons.clear, color: Colors.red),
                  onPressed: _clear,
                )
              ],
            ),
          ]
        ],
      );

  Future uploadFile() async {
    StorageReference storageReference =
        FirebaseStorage.instance.ref().child(imageName);

    StorageUploadTask uploadTask = storageReference.putFile(_imageFile);

    await uploadTask.onComplete;

    storageReference.getDownloadURL().then((fileURL) {
      setState(() {
        _imageFileURL = fileURL;
      });
    });
  }
}
