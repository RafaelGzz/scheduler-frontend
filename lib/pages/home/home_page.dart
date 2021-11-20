import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:scheduler_frontend/pages/home/bloc/home_bloc.dart';
import 'package:scheduler_frontend/pages/home/horizontal_view.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
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
          return BlocProvider(
            create: (_) => HomeBloc(),
            child: HorizontalView(constraints: constraints),
          );

          // if (constraints.maxWidth > 768) {
          // } else {
          //   return _verticalView(constraints);
          // }
        },
      ),
    );
  }

  Widget _verticalView(BoxConstraints constraints) {
    return Column();
  }
}
