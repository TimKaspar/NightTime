import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import 'database/Time.dart';
import 'database/database.dart';

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

Future<Map<String, DateTime>> getDates() async {
  final database =
      await $FloorFloorDB.databaseBuilder('app_database.db').build();
  final timeDAO = database.timeDAO;

  List<Time> timeList = await timeDAO.findAllTime();
  print("RECEIVED LIST: "+timeList.toString());
  Map<String, DateTime> dateMap = {};
  int totalEntries = 0;

  int totalToSleep = 0;
  int totalSleepTime = 0;
  int totalWakeUp = 0;

  for (Time time in timeList) {
    DateTime toSleepDate = DateTime.parse(time.toSleep);
    DateTime wakeUpDate = DateTime.parse(time.wakeUp);

    totalSleepTime += toSleepDate.difference(wakeUpDate).inMilliseconds;
    totalEntries++;

    totalToSleep += toSleepDate.millisecondsSinceEpoch;
    totalWakeUp += wakeUpDate.millisecondsSinceEpoch;
  }
  print("total wakeup: "+ totalWakeUp.toString());
  print("total tosleep: "+ totalToSleep.toString());

  DateTime avgSleepTime = DateTime.fromMillisecondsSinceEpoch(int.parse((totalSleepTime / totalEntries).round().toString()));
  DateTime avgWakeUp = DateTime.fromMillisecondsSinceEpoch(int.parse((totalWakeUp / totalEntries).round().toString()));
  DateTime avgToSleep = DateTime.fromMillisecondsSinceEpoch(int.parse((totalToSleep / totalEntries).round().toString()));

  print("avg time: "+avgToSleep.toString());
  print("avg wakeup: "+avgWakeUp.toString());
  print("avg tosleep: "+avgSleepTime.toString());

  dateMap.putIfAbsent("sleepTime", () => avgSleepTime);
  dateMap.putIfAbsent("wakeUp", () => avgWakeUp);
  dateMap.putIfAbsent("toSleep", () => avgToSleep);

  return dateMap;
}
