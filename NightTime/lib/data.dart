import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
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
                Builder(
                  builder: (BuildContext context) {
                    Map<String, String> map = calculator();
                    String? toSleep = map["toSleep"];

                    if (toSleep == null || toSleep == "") {
                      return Text("Noch keine Daten vorhanden");
                    } else {
                      return Text(toSleep);
                    }
                  },
                ),
                Padding(
                  padding: EdgeInsets.only(top: 40),
                  child: Text("Avg. Schlaf-Zeit",
                      style:
                          TextStyle(fontSize: 15, fontWeight: FontWeight.bold)),
                ),
                Builder(
                  builder: (BuildContext context) {
                    Map<String, String> map = calculator();
                    String? sleepTime = map["sleepTime"];

                    if (sleepTime == null || sleepTime == "") {
                      return Text("Noch keine Daten vorhanden");
                    } else {
                      return Text(sleepTime);
                    }
                  },
                ),
                Padding(
                    padding: EdgeInsets.only(top: 40),
                    child: Text("Avg. Aufwach-Zeit",
                        style: TextStyle(
                            fontSize: 15, fontWeight: FontWeight.bold))),
                Builder(
                  builder: (BuildContext context) {
                    Map<String, String> map = calculator();
                    String? wakeUp = map["wakeUp"];

                    if (wakeUp == null || wakeUp == "") {
                      return Text("Noch keine Daten vorhanden");
                    } else {
                      return Text(wakeUp);
                    }
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

extension on Duration {
  String format() => '$this'.split('.')[0].padLeft(8, '0');
}

Map<String, String> calculator() {
  int totalToSleep = 0;
  int totalWakeUp = 0;
  DateTime avgToSleep;
  DateTime avgWakeUp;
  Duration avgSleepTime;
  String formattedToSleep = "";
  String formattedWakeUp = "";
  String formattedSleepTime = "";

  for (DateTime time in Time.toSleep) {
    totalToSleep += time.millisecondsSinceEpoch;
  }
  for (DateTime time in Time.wakeUp) {
    totalWakeUp += time.millisecondsSinceEpoch;
  }

  if (totalToSleep > 0) {
    int divToSleep = (totalToSleep / Time.toSleep.length).round();
    int divWakeUp = (totalWakeUp / Time.wakeUp.length).round();

    avgToSleep = DateTime.fromMillisecondsSinceEpoch(divToSleep);
    avgWakeUp = DateTime.fromMillisecondsSinceEpoch(divWakeUp);
    avgSleepTime = avgToSleep.difference(avgWakeUp);

    formattedToSleep = DateFormat('kk:mm').format(avgToSleep);
    formattedWakeUp = DateFormat('kk:mm').format(avgToSleep);
    formattedSleepTime = avgSleepTime.format();
  }
  Map<String, String> map = {};
  map.putIfAbsent("toSleep", () => formattedToSleep);
  map.putIfAbsent("wakeUp", () => formattedWakeUp);
  map.putIfAbsent("sleepTime", () => formattedSleepTime);

  return map;
}
