import 'dart:io';
import 'package:flutter/material.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/widgets.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart';


class AddPhoto extends StatefulWidget {
  final String photoPath;
  
//  const AddPhoto(String s, {Key key, this.photoPath}): super (key: key);
  AddPhoto({Key key, @required this.photoPath}) : super (key: key);

  createState() => _AddPhotoState(this.photoPath);
}

class _AddPhotoState extends State<AddPhoto> {

  File _imageFile;
  String _imageFileURL;
  String imageName;

  _AddPhotoState(String photoPath){
    imageName = photoPath;
    print('a: ' + imageName);
    print(photoPath);
  }

  Future<void> _pickImage(ImageSource source) async {
    File selected = await ImagePicker.pickImage(source: source);
    setState(() {
      _imageFile = selected;
    });
  }

  /// Remove image
  void _clear() {
    setState(() => _imageFile = null);
  }

  @override
    Widget build(BuildContext context) => Column(
      children: <Widget>[ Row(
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
          Text('From camera', style: TextStyle(
                color: Colors.grey,
              ),),
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
          Text('From gallery',style: TextStyle(
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
                  child: Icon(Icons.clear, color:Colors.red),
                  onPressed: _clear,
                ),
                FlatButton(
                  child: Icon(Icons.done, color:Colors.green),
                  onPressed: () { uploadFile();}
                ),
              ],
            ),

          ]]);
          
Future uploadFile() async {   
  //  print('File before Uploaded');
   StorageReference storageReference = FirebaseStorage.instance    
       .ref()    
       .child(imageName);    
   StorageUploadTask uploadTask = storageReference.putFile(_imageFile);    
   await uploadTask.onComplete;    
//   print('File Uploaded');  
   storageReference.getDownloadURL().then((fileURL) {    
     setState(() {    
       _imageFileURL = fileURL; 
       print(_imageFileURL);   
     });    
   });    
 }  
}

