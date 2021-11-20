import 'package:flutter/material.dart';
import 'package:scheduler_frontend/services/admin_service.dart';
import 'package:oktoast/oktoast.dart' as OKToast;

class LoginPage extends StatelessWidget {
  LoginPage({Key? key}) : super(key: key);
  AdminService as = AdminService();
  TextEditingController userController = TextEditingController();
  TextEditingController passController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Scaffold(
      body: SingleChildScrollView(
        child: SizedBox(
          height: size.height,
          width: size.width,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              loginCard(size, context),
            ],
          ),
        ),
      ),
    );
  }

  Widget loginCard(Size size, BuildContext context) {
    return Material(
      elevation: 10,
      child: Container(
        margin: const EdgeInsets.all(20),
        height: size.height / 1.8,
        width: size.width / 3.5,
        child: Expanded(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              const FittedBox(
                child: Text(
                  "Inicia Sesión",
                  style: TextStyle(
                      fontSize: 30,
                      color: Color(0xff0A66BF),
                      fontWeight: FontWeight.w300),
                ),
              ),
              Column(
                children: [
                  userInput(),
                  const SizedBox(height: 20),
                  passInput(),
                ],
              ),
              loginButton(context)
            ],
          ),
        ),
      ),
    );
  }

  Container passInput() {
    return Container(
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10), color: Colors.grey[200]),
      child: TextField(
        autocorrect: false,
        obscureText: true,
        controller: passController,
        decoration: const InputDecoration(
          contentPadding: EdgeInsets.symmetric(horizontal: 20),
          hintText: "Contraseña",
          focusedBorder: InputBorder.none,
          border: InputBorder.none,
        ),
      ),
    );
  }

  Container userInput() {
    return Container(
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10), color: Colors.grey[200]),
      child: TextField(
        autocorrect: false,
        controller: userController,
        decoration: const InputDecoration(
          contentPadding: EdgeInsets.symmetric(horizontal: 20),
          hintText: "Usuario",
          focusedBorder: InputBorder.none,
          border: InputBorder.none,
        ),
      ),
    );
  }

  Widget loginButton(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: MaterialButton(
            padding: const EdgeInsets.symmetric(vertical: 15),
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
            onPressed: () async {
              if (await as.login(userController.text, passController.text)) {
                Navigator.pushReplacementNamed(context, 'adminPage');
              } else {
                OKToast.showToast("Datos incorrectos aha pebdehki");
              }
            },
            color: const Color(0xff0A66BF),
            child: const Text(
              "Ingresar",
              style: TextStyle(color: Colors.white),
            ),
          ),
        ),
      ],
    );
  }
}
