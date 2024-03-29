import 'package:farmer_digital/screens/dashboard/dashboard_screen.dart';
import 'package:flutter/material.dart';

import 'package:farmer_digital/app_theme.dart';
import 'package:farmer_digital/screens/home/home_screen.dart';
import 'package:farmer_digital/widgets/drawer/drawer_home.dart';
import 'package:farmer_digital/widgets/drawer/drawer_home_controller.dart';

class NavigationHomeScreen extends StatefulWidget {
  bool isAuthenticated;
  NavigationHomeScreen({
    Key? key,
    required this.isAuthenticated,
  }) : super(key: key);

  @override
  _NavigationHomeScreenState createState() => _NavigationHomeScreenState();
}

class _NavigationHomeScreenState extends State<NavigationHomeScreen> {
  Widget? screenView;
  DrawerIndex? drawerIndex;

  @override
  void initState() {
    drawerIndex = DrawerIndex.home;
    screenView = HomeScreen(
      isAuthenticated: true,
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppTheme.nearlyWhite,
      child: SafeArea(
        top: false,
        bottom: false,
        child: Scaffold(
          backgroundColor: AppTheme.nearlyWhite,
          body: DrawerHomeController(
            screenIndex: drawerIndex,
            drawerWidth: MediaQuery.of(context).size.width * 0.75,
            onDrawerCall: (DrawerIndex drawerIndexdata) {
              changeIndex(drawerIndexdata);
              //callback from drawer for replace screen as user need with passing DrawerIndex(Enum index)
            },
            screenView: screenView,
            //we replace screen view as we need on navigate starting screens like MyHomePage, HelpScreen, FeedbackScreen, etc...
          ),
        ),
      ),
    );
  }

  void changeIndex(DrawerIndex drawerIndexdata) {
    if (drawerIndex != drawerIndexdata) {
      drawerIndex = drawerIndexdata;
      if (drawerIndex == DrawerIndex.home) {
        setState(() {
          screenView = DashboardScreen();
        });
      } else if (drawerIndex == DrawerIndex.help) {
        setState(() {});
      } else if (drawerIndex == DrawerIndex.feedBack) {
        setState(() {});
      } else if (drawerIndex == DrawerIndex.share) {
        setState(() {});
      } else {
        //do in your way......
      }
    }
  }
}
