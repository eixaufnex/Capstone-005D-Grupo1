import 'package:flutter/material.dart';

class WebMain extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Web Home Page'),
      ),
      body: Center(
        child: Text('This is the Web version of the app! ESTO ES UNA PRUEBA'),
      ),
    );
  }
}