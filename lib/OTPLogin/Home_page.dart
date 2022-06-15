import 'package:flutter/material.dart';

class Home_page extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
     appBar: AppBar(title: Text("Home Page")),
      body: Center(
        child: Text(
          'Home Page',
          style: TextStyle(
            fontWeight: FontWeight.w300, // light
            fontStyle: FontStyle.italic, // italic
          ),

        ),
      ),
    );
  }
}
