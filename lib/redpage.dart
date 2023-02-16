import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';

class Redpage extends StatefulWidget {
  const Redpage({super.key});

  @override
  State<Redpage> createState() => _RedpageState();
}

class _RedpageState extends State<Redpage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Container(
        color: Colors.red,
        height: double.infinity,
        width: double.infinity,
        child: Text(" i am red page"),
      ),
    );
  }
}