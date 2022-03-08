import 'package:farmer_digital/screens/dashboard/dashboard_screen.dart';
import 'package:flutter/material.dart';

class HomeList {
  HomeList({
    this.navigateScreen,
    this.imagePath = '',
  });

  Widget? navigateScreen;
  String imagePath;

  static List<HomeList> homeList = [
    HomeList(
      imagePath: 'assets/images/on_boarding_start_screen.png',
      navigateScreen: const DashboardScreen(),
    )
  ];
}
