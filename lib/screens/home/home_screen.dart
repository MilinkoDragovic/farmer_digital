import 'package:farmer_digital/models/user.dart';
import 'package:flutter/widgets.dart';

class HomeScreen extends StatefulWidget {
  final User user;

  const HomeScreen({Key? key, required this.user}) : super(key: key);

  @override
  State createState() => _HomeScreen();
}

class _HomeScreen extends State<HomeScreen> {
  late User user;
  @override
  Widget build(BuildContext context) {
    return const Text('Home screen');
  }
}
