import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';
import 'dart:io';

class ImageUploadPage extends StatefulWidget {
  @override
  ImageUploadPageState createState() => ImageUploadPageState();
}

class ImageUploadPageState extends State<ImageUploadPage> {
  final picker = ImagePicker();
  File? _image;

  Future<void> _getImage() async {
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() {
        _image = File(pickedFile.path);
      });
    }
  }

  Future<void> _uploadImage() async {
    if (_image == null) {
      print('No se ha seleccionado una imagen.');
      return;
    }

    // var request = http.MultipartRequest('POST', Uri.parse('http://192.168.0.129/upload'));
    var request = http.MultipartRequest('POST', Uri.parse('https://proxipymemovilapp-production.up.railway.app/upload'));
    request.files.add(await http.MultipartFile.fromPath('image', _image!.path));

    try {
      var response = await request.send();
      if (response.statusCode == 200) {
        print('Imagen subida exitosamente');
      } else {
        print('Error al subir la imagen: ${response.statusCode}');
      }
    } catch (e) {
      print('Error al subir la imagen: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Subir Imagen a Cloudinary'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            _image == null
                ? Text('Selecciona una imagen')
                : Image.file(_image!),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: _getImage,
              child: Text('Seleccionar Imagen'),
            ),
            ElevatedButton(
              onPressed: _uploadImage,
              child: Text('Subir Imagen'),
            ),
          ],
        ),
      ),
    );
  }
}
