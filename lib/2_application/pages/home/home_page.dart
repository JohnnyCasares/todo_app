import 'package:flutter/material.dart';
import 'package:todo_app/2_application/core/adaptive_layout.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: AdatptiveLayout(
          pane1: Container(color: Colors.red),
          pane2: Container(color: Colors.black),
        ),
      ),
    );
  }
}
