import 'package:flutter/material.dart';
import 'package:scheduler_frontend/models/nurse/nurse.dart';
import 'package:scheduler_frontend/pages/home/widgets/header.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  Nurse? selectedNurse;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.pushReplacementNamed(context, 'login');
        },
        child: const Icon(Icons.admin_panel_settings),
      ),
      body: LayoutBuilder(
        builder: (BuildContext context, BoxConstraints constraints) {
          if (constraints.maxWidth > 768) {
            return _horizontalView(constraints);
          } else {
            return _verticalView(constraints);
          }
        },
      ),
    );
  }

  Widget _horizontalView(BoxConstraints constraints) {
    double partitionedWidth = constraints.maxWidth * .8;
    double headerViewWidth = partitionedWidth < 900 ? 900 : partitionedWidth;

    // double headerViewWidth = constraints.maxWidth - sideViewWidth;

    // double partitionedHeigth = constraints.maxHeight * .3;
    // // double headerViewHeigth = partitionedHeigth < 200 ? 200 : partitionedHeigth;

    return Stack(
      children: [
        GestureDetector(
          onTap: () {
            FocusScope.of(context).requestFocus(FocusNode());
          },
          child: SizedBox(
            height: constraints.maxHeight,
            // padding: const EdgeInsets.only(top: ),
            child: Row(
              children: [
                if (selectedNurse != null)
                  Expanded(
                    child: Center(child: Text(selectedNurse!.name!)),
                  ),
                Expanded(
                  child: Column(),
                ),
              ],
            ),
          ),
        ),
        Header(
          width: headerViewWidth,
          onNurseSelected: (Nurse nurse) {
            setState(() {
              selectedNurse = nurse;
            });
          },
        )
      ],
    );
  }

  Widget _verticalView(BoxConstraints constraints) {
    return Column();
  }
}
