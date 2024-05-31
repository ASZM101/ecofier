import 'package:flutter/material.dart';
import 'package:camera/camera.dart';
import 'room_scanner.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final cameras = await availableCameras();
  final firstCamera = cameras.first;
  runApp(EcofierApp(camera: firstCamera));
}

class EcofierApp extends StatelessWidget {
  final CameraDescription camera;
  const EcofierApp({super.key, required this.camera});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Ecofier',
      debugShowCheckedModeBanner: false,
      home: CameraScreen(camera: camera),
    );
  }
}