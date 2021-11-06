import 'package:flutter/material.dart';
import 'package:oktoast/oktoast.dart';
import 'package:scheduler_frontend/pages/admin_page.dart';
import 'package:scheduler_frontend/pages/home_page.dart';
import 'package:scheduler_frontend/pages/login_page.dart';
import 'package:scheduler_frontend/pages/nurses_page.dart';
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
      initialRoute: 'login',
      routes: {
        'home': (BuildContext context) => const HomePage(),
        'login': (BuildContext context) => const LoginPage(),
        'adminPage': (BuildContext context) => const AdminPage(),
        'nursesPage': (BuildContext context) => const NursesPage(),
        'ptosPage': (BuildContext context) => const PtosPage()
      },
    );
  }
}
