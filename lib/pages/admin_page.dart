import 'package:flutter/material.dart';
import 'package:scheduler_frontend/pages/admin_pto_page.dart';
import 'package:scheduler_frontend/pages/nurses_page/nurses_page.dart';
import 'package:scheduler_frontend/pages/ptos_page.dart';

class AdminPage extends StatefulWidget {
  AdminPage({Key? key}) : super(key: key);
  int _selectedIndex = 0;

  @override
  State<AdminPage> createState() => _AdminPageState();
}

class _AdminPageState extends State<AdminPage> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    final controller = PageController(initialPage: widget._selectedIndex);

    return Scaffold(
      body: SafeArea(
        child: Row(
          children: [
            sideMenu(controller, size),
            pageView(controller),
          ],
        ),
      ),
    );
  }

  Padding sideMenu(PageController controller, Size size) {
    return Padding(
      padding: const EdgeInsets.only(
          top: 20.0, bottom: 20.0, left: 20.0, right: 5.0),
      child: Material(
        borderRadius: BorderRadius.circular(20),
        elevation: 5,
        child: ClipRRect(
          borderRadius: BorderRadius.circular(20),
          child: NavigationRail(
            selectedIndex: widget._selectedIndex,
            onDestinationSelected: (int index) {
              setState(() {
                widget._selectedIndex = index;
                controller.jumpToPage(widget._selectedIndex);
              });
            },
            trailing: exitButton(),
            extended: true,
            selectedIconTheme:
                const IconThemeData(color: Color(0xff0A66BF), size: 30),
            selectedLabelTextStyle: const TextStyle(
              color: Color(0xff0A66BF),
              // fontSize: 20,
              fontSize: 17,
            ),
            unselectedIconTheme: const IconThemeData(size: 30),
            unselectedLabelTextStyle:
                const TextStyle(fontSize: 17, fontWeight: FontWeight.w300),
            minExtendedWidth: size.width * 0.18,
            groupAlignment: 0,
            destinations: const [
              NavigationRailDestination(
                icon: Icon(Icons.local_hospital_outlined),
                selectedIcon: Icon(Icons.local_hospital),
                label: Text("Enfermeros"),
              ),
              NavigationRailDestination(
                icon: Icon(Icons.timelapse_outlined),
                selectedIcon: Icon(Icons.timelapse),
                label: Text("Peticiones"),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Expanded pageView(PageController controller) {
    return Expanded(
      child: PageView(
        physics: NeverScrollableScrollPhysics(),
        controller: controller,
        children: const [NursesPage(), AdminPtoPage()],
      ),
    );
  }

  Widget exitButton() {
    return InkWell(
      onTap: () => Navigator.pushReplacementNamed(context, "home"),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 20.0),
        child: Row(
          children: const [
            SizedBox(
              width: 20,
            ),
            Icon(
              Icons.exit_to_app,
              color: Colors.red,
              size: 30,
            ),
            SizedBox(
              width: 20,
            ),
            Text(
              "Salir",
              style: TextStyle(
                  color: Colors.red, fontSize: 17, fontWeight: FontWeight.w600),
            ),
            SizedBox(
              width: 20,
            ),
          ],
        ),
      ),
    );
  }
}
