import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';

class Greenpage extends StatefulWidget {
  const Greenpage({super.key});

  @override
  State<Greenpage> createState() => _GreenpageState();
}

class _GreenpageState extends State<Greenpage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Container(
        color: Colors.green,
        height: double.infinity,
        width: double.infinity,
        child: Text(" i am green page"),
      ),
    );
  }
}