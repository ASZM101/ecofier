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
      themeMode: ThemeMode.light,
      theme: GlobalThemeData.lightThemeData,
      darkTheme: GlobalThemeData.darkThemeData,
      home: CameraScreen(camera: camera),
    );
  }
}

class GlobalThemeData {
  static final Color lightFocusColor = Colors.black.withOpacity(0.12);
  static final Color darkFocusColor = Colors.white.withOpacity(0.12);
  static ThemeData lightThemeData = themeData(lightColorScheme, lightFocusColor);
  static ThemeData darkThemeData = themeData(darkColorScheme, darkFocusColor);
  static ThemeData themeData(ColorScheme colorScheme, Color focusColor) {
    return ThemeData(
      colorScheme: colorScheme,
      canvasColor: colorScheme.background,
      scaffoldBackgroundColor: colorScheme.background,
      highlightColor: Colors.transparent,
      focusColor: focusColor,
    );
  }
  static const ColorScheme lightColorScheme = ColorScheme(
    primary: Color.fromARGB(255, 0, 191, 99),
    onPrimary: Colors.white,
    secondary: Color.fromARGB(255, 0, 125, 65),
    onSecondary: Colors.white,
    error: Colors.redAccent,
    onError: Colors.white,
    background: Color.fromARGB(255, 222, 255, 239),
    onBackground: Colors.black,
    surface: Color.fromARGB(255, 126, 217, 87),
    onSurface: Colors.white,
    brightness: Brightness.light,
  );
  static const ColorScheme darkColorScheme = ColorScheme(
    primary: Color.fromARGB(255, 222, 255, 239),
    onPrimary: Colors.black,
    secondary: Color.fromARGB(255, 126, 217, 87),
    onSecondary: Colors.black,
    error: Colors.redAccent,
    onError: Colors.white,
    background: Color.fromARGB(255, 0, 125, 65),
    onBackground: Colors.white,
    surface: Color.fromARGB(255, 0, 191, 99),
    onSurface: Colors.white,
    brightness: Brightness.dark,
  );
}