import 'package:flutter/material.dart';
import 'package:scheduler_frontend/pages/home_page.dart';
import 'package:scheduler_frontend/pages/login_page.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Scheduler',
      initialRoute: 'login',
      routes: {
        'home': (BuildContext context) => const HomePage(),
        'login': (BuildContext context) => const LoginPage()
      },
    );
  }
}
