import 'package:flutter/material.dart';
import 'package:contador_votos/TelaEnquete.dart';

void main() => runApp(MainApp());

class MainApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Enquete',
      home: MainHomePage(),
    );
  }
}

