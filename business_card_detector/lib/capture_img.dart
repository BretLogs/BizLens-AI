import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:http/http.dart' as http;

class ImageUploader extends StatefulWidget {
  const ImageUploader({super.key});

  @override
  _ImageUploaderState createState() => _ImageUploaderState();
}

class _ImageUploaderState extends State<ImageUploader> {
  File? _image;

  final ImagePicker _picker = ImagePicker();

  Future<void> _captureImage() async {
    final XFile? pickedFile = await _picker.pickImage(source: ImageSource.camera);

    if (pickedFile != null) {
      setState(() {
        _image = File(pickedFile.path);
      });
    }
  }

  Future<void> _uploadImage() async {
    if (_image == null) return;

    // Replace with your Flask API endpoint
    String apiUrl = 'http://127.0.0.1:5000/process-image';

    // Create multipart request
    http.MultipartRequest request = http.MultipartRequest('POST', Uri.parse(apiUrl));
    request.files.add(await http.MultipartFile.fromPath('image', _image!.path));
    print('waiting for response....');

    // Send request
    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      http.Response responseBody = await http.Response.fromStream(response);
      var data = json.decode(responseBody.body);
      print('Response: $data');
    } else {
      print('Failed to upload image. Status Code: ${response.statusCode}');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Upload Image')),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          _image == null ? const Text('No image selected') : Image.file(_image!, height: 200),
          ElevatedButton(
            onPressed: _captureImage,
            child: const Text('Capture Image'),
          ),
          ElevatedButton(
            onPressed: _uploadImage,
            child: const Text('Upload Image'),
          ),
        ],
      ),
    );
  }
}
