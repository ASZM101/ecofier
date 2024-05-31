import 'dart:async';
import 'dart:io';
import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:logger/logger.dart';
import 'main.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  final cameras = await availableCameras();
  final firstCamera = cameras.first;

  runApp(CameraScreen(camera: firstCamera));
}

class CameraScreen extends StatefulWidget {
  final CameraDescription camera;

  const CameraScreen({super.key, required this.camera});

  @override
  CameraScreenState createState() => CameraScreenState();
}

class CameraScreenState extends State<CameraScreen> {
  late CameraController controller;
  late Future<void> initializeControllerFuture;
  final logger = Logger();

  @override
  void initState() {
    super.initState();
    controller = CameraController(
      widget.camera,
      ResolutionPreset.medium,
    );
    initializeControllerFuture = controller.initialize().catchError((e) {
      logger.e('Camera initialization error: $e');
    });
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  void takePicture() {
    initializeControllerFuture.then((_) {
      controller.takePicture().then((image) {
        if (!mounted) return;
        navigateToAnalyzer(image.path);
      }).catchError((e) {
        logger.e(e.toString());
      });
    }).catchError((e) {
      logger.e(e.toString());
    });
  }

  void navigateToAnalyzer(String imagePath) {
    if (!mounted) return;
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => Scaffold(
          appBar: AppBar(title: const Text('Analyzer')),
          body: Center(
            child: Image.file(File(imagePath)),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      themeMode: ThemeMode.light,
      theme: GlobalThemeData.lightThemeData,
      darkTheme: GlobalThemeData.darkThemeData,
      home: Scaffold(
        body: OrientationBuilder(
          builder: (context, orientation) {
            return FutureBuilder<void>(
              future: initializeControllerFuture,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.done) {
                  var aspectRatio = controller.value.aspectRatio;
                  if (orientation == Orientation.portrait) {
                    aspectRatio = 1 / aspectRatio;
                  }
                  return Center(
                    child: AspectRatio(
                      aspectRatio: aspectRatio,
                      child: CameraPreview(controller),
                    )
                  );
                } else {
                  return const Center(child: CircularProgressIndicator());
                }
              },
            );
          },
        ),
        floatingActionButton: FloatingActionButton(
            child: const Icon(Icons.camera_alt),
            onPressed: () {
              takePicture();
            },
          ),
      ),
    );
  }
}