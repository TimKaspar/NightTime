import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Data extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("NightTime"),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Text("datad"),
            Text("datad")
          ],
        ),
      ),
    );
  }
}