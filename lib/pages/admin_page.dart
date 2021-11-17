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
        customButton(context, "Enfermeros", "nursesPage", Colors.grey[300]!),
        customButton(context, "Peticiones", "ptosPage", Colors.grey[300]!),
        customButton(context, "Usuarios", "usersPage", Colors.grey[300]!),
        customButton(context, "Salir", "home", const Color(0xff0A66BF),
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
        splashColor: Colors.blue,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        height: 50,
        onPressed: () => !replace
            ? Navigator.pushNamed(context, path)
            : Navigator.pushReplacementNamed(context, path),
        child: Text(text,
            style: TextStyle(
                color: replace ? Colors.white : Colors.black,
                fontSize: 30,
                fontWeight: FontWeight.w300)),
        color: color,
      ),
    );
  }
}
