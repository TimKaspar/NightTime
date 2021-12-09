import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class DataDisplayPage extends StatefulWidget {
  @override
  _DataDisplayPageState createState() {
    getDates().then((value) {
      return _DataDisplayPageState(value);
    });
    Map<String, DateTime> map = {};
    return _DataDisplayPageState(map);
  }
}

class _DataDisplayPageState extends State<DataDisplayPage> {
  Map<String, DateTime> dateMap;

  _DataDisplayPageState(this.dateMap);

  @override
  Widget build(BuildContext context) {
    DateTime? toSleep = dateMap["toSleep"];
    DateTime? wakeUp = dateMap["wakeUp"];
    DateTime? sleepTime = dateMap["sleepTime"];

    String formattedToSleep = "no Data";
    String formattedSleepTime = "no Data";
    String formattedWakeUp = "no Data";
    if (toSleep != null) {
      formattedToSleep = DateFormat('kk:mm').format(toSleep);
    }
    if (wakeUp != null) {
      formattedWakeUp = DateFormat('kk:mm').format(wakeUp);
    }
    if (sleepTime != null) {
      formattedSleepTime = DateFormat('kk:mm').format(sleepTime);
    }

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
                Text(formattedToSleep.toString()),
                Padding(
                    padding: EdgeInsets.only(top: 40),
                    child: Text("Avg. Schlaf-Zeit",
                        style: TextStyle(
                            fontSize: 15, fontWeight: FontWeight.bold))),
                Text(formattedSleepTime.toString()),
                Padding(
                    padding: EdgeInsets.only(top: 40),
                    child: Text("Avg. Aufwach-Zeit",
                        style: TextStyle(
                            fontSize: 15, fontWeight: FontWeight.bold))),
                Text(formattedWakeUp.toString())
              ],
            ),
          ),
        ),
      ),
    );
  }
}
