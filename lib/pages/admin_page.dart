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
        customButton(context, "Enfermeros", "nursesPage", Color(0xffADC4FF)),
        customButton(context, "Peticiones", "ptosPage", Color(0xffADC4FF)),
        customButton(context, "Usuarios", "users", Color(0xffADC4FF)),
        customButton(context, "Salir", "login", Color(0xffE2C8F9),
            replace: true),
      ],
    ));
  }

  Widget customButton(
      BuildContext context, String text, String path, Color color,
      {bool replace = false}) {
    return Container(
      margin: const EdgeInsets.all(20),
      child: MaterialButton(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        height: 50,
        onPressed: () => !replace
            ? Navigator.pushNamed(context, path)
            : Navigator.pushReplacementNamed(context, path),
        child: Text(text,
            style: const TextStyle(
                color: Colors.white,
                fontSize: 30,
                fontWeight: FontWeight.w300)),
        color: color,
      ),
    );
  }
}
