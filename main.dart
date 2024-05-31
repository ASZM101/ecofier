import 'package:flutter/material.dart';
//import 'package:camera/camera.dart';
//import 'room_scanner.dart';
import 'home.dart';
import 'theme.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // final cameras = await availableCameras();
  // final firstCamera = cameras.first;
  // runApp(EcofierApp(camera: firstCamera));
  runApp(const EcofierApp());
}

class EcofierApp extends StatelessWidget {
  const EcofierApp({super.key});

  // final CameraDescription camera;
  // const EcofierApp({super.key, required this.camera});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      themeMode: ThemeMode.light,
      theme: GlobalThemeData.lightThemeData,
      darkTheme: GlobalThemeData.darkThemeData,
      home: const Home(),
      //home: CameraScreen(camera: camera),
    );
  }
}