import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:nighttime/time.dart';

class DataDisplayPage extends StatefulWidget {
  @override
  _DataDisplayPageState createState() => _DataDisplayPageState();
}

class _DataDisplayPageState extends State<DataDisplayPage> {

  @override
  void initState() {
    super.initState();
    calculator();
  }

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

void calculator() {
  int totalToSleep = 0;
  int totalWakeUp = 0;
  DateTime avgToSleep;
  DateTime avgWakeUp;
  Duration avgSleepTime;

  for (DateTime time in Time.toSleep) {
    totalToSleep += time.millisecondsSinceEpoch;
  }
  for (DateTime time in Time.wakeUp) {
    totalWakeUp += time.millisecondsSinceEpoch;
  }
  avgToSleep = DateTime.fromMillisecondsSinceEpoch(int.parse((totalToSleep / Time.toSleep.length).toString()));
  avgWakeUp = DateTime.fromMillisecondsSinceEpoch(int.parse((totalWakeUp / Time.wakeUp.length).toString()));

  avgSleepTime = avgToSleep.difference(avgWakeUp);

  print("Avg wakeup: "+ avgWakeUp.toString());
  print("Avg toSleep: "+ avgToSleep.toString());
  print("Avg sleep time: "+ avgSleepTime.toString());
}
