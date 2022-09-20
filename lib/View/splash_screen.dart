import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:dio/dio.dart' as dio;
import 'dart:io';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  TextEditingController _controller = TextEditingController();
  Image? fileImage;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Websockets'),
      ),
      body: const Center(
        child: SizedBox(),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          imagePick();
        },
        child: const Icon(Icons.upload_file),
      ),
    );
  }

  imagePick() async {
    var image = await ImagePicker().pickImage(source: ImageSource.gallery);

    String fileName = image!.path.split('/').last;
    dio.FormData formData = dio.FormData.fromMap({
      "myFile": await dio.MultipartFile.fromFile(
        image.path,
        filename: fileName,
      ),
      "type": "image/png"
    });

    dio.Response response = await dio.Dio().post("http://10.0.2.2:8080/upload",
        data: formData,
        options: dio.Options(headers: {
          'Content-Type': 'multipart/form-data',
          'accept': '*/*',
        }, method: 'POST', responseType: dio.ResponseType.json));
    print(response.statusCode);
    return response;
  }
}
