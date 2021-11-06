import 'package:flutter/material.dart';
import 'package:scheduler_frontend/pages/home/widgets/header.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blueGrey,
      body: LayoutBuilder(
        builder: (BuildContext context, BoxConstraints constraints) {
          if (constraints.maxWidth > 900) {
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
          child: Container(
            color: Colors.brown,
            height: constraints.maxHeight,
            // padding: const EdgeInsets.only(top: ),
            child: Row(
              children: [
                Expanded(
                  child: Column(),
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
        )
      ],
    );
  }

  Widget _verticalView(BoxConstraints constraints) {
    return Column();
  }
}