import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class Data extends StatelessWidget {
  DateTime toSleep;
  DateTime sleepTime;
  DateTime wakeUp;

  Data(this.toSleep, this.sleepTime, this.wakeUp);

  @override
  Widget build(BuildContext context) {
    String formattedToSleep = DateFormat('kk:mm').format(toSleep);
    String formattedSleepTime = DateFormat('kk:mm').format(sleepTime);
    String formattedWakeUp = DateFormat('kk:mm').format(wakeUp);

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
                Text("Avg. Einschlaf-Zeit",
                  style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),),
                Text(formattedToSleep.toString()),
                Padding(
                    padding: EdgeInsets.only(top: 40),
                    child: Text("Avg. Schlaf-Zeit", style: TextStyle(
                        fontSize: 15, fontWeight: FontWeight.bold))),
                Text(formattedSleepTime.toString()),
                Padding(
                    padding: EdgeInsets.only(top: 40),
                    child: Text("Avg. Aufwach-Zeit", style: TextStyle(
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
