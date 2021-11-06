import 'package:flutter/material.dart';

class HeaderContent extends StatefulWidget {
  const HeaderContent({Key? key}) : super(key: key);

  @override
  _HeaderContentState createState() => _HeaderContentState();
}

class _HeaderContentState extends State<HeaderContent> {
  @override
  Widget build(BuildContext context) {
    Widget _nurseCodeTile() {
      return const Padding(
        padding: EdgeInsets.only(left: 50),
        child: ListTile(
          leading: Icon(
            Icons.local_hospital,
            size: 40,
            color: Colors.blue,
          ),
          title: Text(
            "1234",
            style: TextStyle(
              fontSize: 30,
              fontWeight: FontWeight.w300,
            ),
          ),
        ),
      );
    }

    return Expanded(
      child: Row(
        children: [
          Expanded(
            child: ListView.builder(
              itemBuilder: (context, index) => _nurseCodeTile(),
              itemCount: 20,
            ),
          ),
          Expanded(
            flex: 2,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  "Nombre: Fulanita de tal",
                  style: TextStyle(fontSize: 27),
                ),
                const Divider(),
                const Text(
                  "Horario: 10 a 20",
                  style: TextStyle(fontSize: 27),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 40),
                  child: MaterialButton(
                    minWidth: 400,
                    padding: const EdgeInsets.all(20),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10)),
                    color: Colors.blue,
                    onPressed: () {
                      FocusScope.of(context).requestFocus(FocusNode());
                    },
                    child: const Text(
                      "Ingresar",
                      style: TextStyle(fontSize: 20, color: Colors.white),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
