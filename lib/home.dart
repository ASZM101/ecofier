import 'package:flutter/material.dart';
import 'theme.dart';

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
                'Welcome to',
                style: Theme.of(context).textTheme.headlineMedium,
              ),
              Container(
                color: Colors.indigo,
                height: 200,
                width: 200,
                child: Image.asset(
                  'assets/img/logo.png', 
                  fit: BoxFit.cover,
                ),
              ),
              Text(
                'Ecofy Your Room',
                style: Theme.of(context).textTheme.bodyMedium,
              ),
              Text(
                'Help the World',
                style: Theme.of(context).textTheme.bodyMedium,
              ),
            ],
          ),
        ),
      ),
    );
  }
}