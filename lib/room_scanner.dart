import 'dart:async';
import 'dart:io';
import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:logger/logger.dart';
import 'theme.dart';
import 'app_bar.dart';
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
    final size = MediaQuery.of(context).size;
    final width = size.width;
    if (!mounted) return;
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => Scaffold(
          appBar: CustomAppBar(c: context),
          body: Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 20),
                child: SizedBox(
                  height: 100,
                  width: width,
                  child: Image.file(File(imagePath), fit: BoxFit.fitWidth),
                ),
              ),
              Column(
                children: [
                  const SizedBox(height: 20),
                  Text(
                    '87%',
                    style: Theme.of(context).textTheme.headlineLarge,
                  ),
                  Text(
                    'sustainable',
                    style: Theme.of(context).textTheme.headlineSmall,
                  ),
                  const SizedBox(height: 20),
                  Text(
                    'Suggestions',
                    style: Theme.of(context).textTheme.headlineMedium,
                  ),
                  const SizedBox(height: 10),
                  Padding(
                    padding: const EdgeInsets.all(10),
                    child: Padding(
                      padding: const EdgeInsets.only(left: 40, right: 40),
                      child: Column(
                        children: [
                          Text('• Reduce clutter\n• Repurpose furniture\n• Give new life to textiles\n• Recycle old throw pillows\n• Add plants\n• Switch to LED light bulbs\n• Open up curtains to allow in natural light\n• Power down electronics', style: Theme.of(context).textTheme.bodySmall),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ],
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
        appBar: CustomAppBar(c: context),
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
                  return Padding(
                    padding: const EdgeInsets.only(top: 40),
                    child: AspectRatio(
                      aspectRatio: aspectRatio,
                      child: CameraPreview(controller),
                    ),
                  );
                } else {
                  return const Center(child: CircularProgressIndicator());
                }
              },
            );
          },
        ),
        floatingActionButton: FloatingActionButton(
          child: const Padding(
            padding: EdgeInsets.all(10),
            child: Icon(Icons.camera_alt),
          ),
          onPressed: () {
            takePicture();
          },
        ),
      ),
    );
  }
}