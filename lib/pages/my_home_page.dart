import 'package:chat_app/widget/my_drawer.dart';
import 'package:flutter/material.dart';

class MyHomePage extends StatelessWidget {
  MyHomePage({super.key});
  static const String route = 'Home';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: MyDrawer(),
      appBar: AppBar(
      
        centerTitle: true,
        title: const Text('Home'),
      ),
    );
  }
}
