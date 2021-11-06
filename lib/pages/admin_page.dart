import 'package:flutter/material.dart';

class AdminPage extends StatelessWidget {
  const AdminPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Scaffold(
        body: GridView.count(
      padding: const EdgeInsets.all(50),
      crossAxisCount: 2,
      childAspectRatio: 2,
      children: [
        customButton(context, "Enfermeros", "nurses", Color(0xffADC4FF)),
        customButton(context, "Peticiones", "ptos", Color(0xffADC4FF)),
        customButton(context, "Usuarios", "users", Color(0xffADC4FF)),
        customButton(context, "Salir", "login", Color(0xffE2C8F9)),
      ],
    ));
  }

  Widget customButton(
      BuildContext context, String text, String path, Color color) {
    return Container(
      margin: const EdgeInsets.all(20),
      child: MaterialButton(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        height: 50,
        onPressed: () => Navigator.pushNamed(context, path),
        child: Text(text,
            style: const TextStyle(color: Colors.white, fontSize: 30)),
        color: color,
      ),
    );
  }
}
