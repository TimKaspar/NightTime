import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class DataDisplayPage extends StatefulWidget {
  @override
  _DataDisplayPageState createState() => _DataDisplayPageState();
}

class _DataDisplayPageState extends State<DataDisplayPage> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("NightTime"),
      ),
      body: Center(
        child: Padding(
          padding: EdgeInsets.all(100),
          child: Container(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Text(
                  "Avg. Einschlaf-Zeit",
                  style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                ),
                Text("data"),
                Padding(
                    padding: EdgeInsets.only(top: 40),
                    child: Text("Avg. Schlaf-Zeit",
                        style: TextStyle(
                            fontSize: 15, fontWeight: FontWeight.bold))),
                Text("data"),
                Padding(
                    padding: EdgeInsets.only(top: 40),
                    child: Text("Avg. Aufwach-Zeit",
                        style: TextStyle(
                            fontSize: 15, fontWeight: FontWeight.bold))),
                Text("data"),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
