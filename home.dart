import 'package:flutter/material.dart';
import 'main.dart';

void main() async {
  runApp(const Home());
}

class Home extends StatelessWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      themeMode: ThemeMode.light,
      theme: GlobalThemeData.lightThemeData,
      darkTheme: GlobalThemeData.darkThemeData,
      home: Scaffold(
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Welcome to Ecofier',
                style: Theme.of(context).textTheme.displayLarge!.copyWith(
                  color: GlobalThemeData.lightThemeData.colorScheme.primary,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}