import 'package:farmer_digital/controllers/menu_controller.dart';
import 'package:farmer_digital/responsive.dart';
import 'package:farmer_digital/screens/dashboard/dashboard_screen.dart';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'components/side_menu.dart';

class MainScreen extends StatelessWidget {
  const MainScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        key: context.read<MenuController>().scaffoldKey,
        drawer: const SideMenu(),
        bottomNavigationBar: BottomNavigationBar(
          items: const <BottomNavigationBarItem>[
            BottomNavigationBarItem(
              icon: Icon(Icons.home),
              label: 'Milk Fix Price',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.home),
              label: 'EEX Quotes',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.home),
              label: 'ife Quotes',
            ),
          ],
        ),
        body: SafeArea(
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              if (Responsive.isDesktop(context))
                const Expanded(
                  child: SideMenu(),
                ),
              const Expanded(
                flex: 5,
                child: DashboardScreen(),
              )
            ],
          ),
        ));
  }
}
