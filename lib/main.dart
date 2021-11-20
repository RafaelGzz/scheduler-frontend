import 'package:flutter/material.dart';
import 'package:oktoast/oktoast.dart';
import 'package:scheduler_frontend/pages/admin_page.dart';
import 'package:scheduler_frontend/pages/home/home_page.dart';
import 'package:scheduler_frontend/pages/login_page.dart';
import 'package:scheduler_frontend/pages/nurses_page/nurses_page.dart';
import 'package:scheduler_frontend/pages/ptos_page.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      builder: (context, child) => OKToast(child: child!),
      debugShowCheckedModeBanner: false,
      title: 'Scheduler',
      initialRoute: 'home',
      routes: {
        'home': (BuildContext context) => const HomePage(),
        'login': (BuildContext context) => LoginPage(),
        'adminPage': (BuildContext context) => AdminPage(),
        'nursesPage': (BuildContext context) => const NursesPage(),
      },
    );
  }
}
