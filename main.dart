import 'package:flutter/material.dart';
import 'package:camera/camera.dart';
import 'package:logger/logger.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData.dark(),
      home: const CameraScreen(),
    );
  }
}

class CameraScreen extends StatefulWidget {
  const CameraScreen({super.key});

  @override
  CameraScreenState createState() => CameraScreenState();
}

class CameraScreenState extends State<CameraScreen> {
  CameraController? controller;
  Future<void>? initializeControllerFuture;
  final Logger _logger = Logger();

  @override
  void initState() {
    super.initState();
    initializeCamera();
  }

  Future<void> initializeCamera() async {
    try {
      final cameras = await availableCameras();
      if (cameras.isEmpty) {
        throw CameraException('Camera not available', 'Make sure your device has a functioning camera and try again.');
      }
      final firstCamera = cameras.first;
      controller = CameraController(firstCamera, ResolutionPreset.high);
      initializeControllerFuture = controller!.initialize();
      setState(() {});
    } catch (e, stacktrace) {
      _logger.e('Camera initialization error', error: e, stackTrace: stacktrace);
    }
  }

  @override
  void dispose() {
    controller?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(title: const Text('Camera')),
      body: FutureBuilder<void>(
        future: initializeControllerFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            if (controller != null && controller!.value.isInitialized) {
              final aspectRatio = controller!.value.aspectRatio;
              var w = size.width;
              var h = size.width/aspectRatio;
              if(h > size.height) {
                h = size.height;
                w = size.height*aspectRatio;
              }
              return Center(
                child: SizedBox(
                  width: w,
                  height: h,
                  child: CameraPreview(controller!),
                ),
              );
            } else {
              return const Center(
                child: Text('Error: No camera initialized'),
                );
            }
          } else if (snapshot.hasError) {
            return Center(
              child: Text('Error: ${snapshot.error}'),
              );
          } else {
            return const Center(
              child: CircularProgressIndicator(),
              );
          }
        },
      ),
    );
  }
}