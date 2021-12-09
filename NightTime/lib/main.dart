import 'package:battery_plus/battery_plus.dart';
import 'package:flutter/material.dart';
import 'package:nighttime/data.dart';
import 'package:nighttime/database/database.dart';

import 'database/Time.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'NightTime',
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  bool isSwitched = false;

  @override
  Widget build(BuildContext context) {
    var battery = Battery();
    var _batteryState;

    battery.onBatteryStateChanged.listen((BatteryState state) {
      print(state);
      if (_batteryState == null) {
        _batteryState = state;
      } else if (_batteryState != state) {
        print("CHANGE: " + state.toString());
        _batteryState = state;
        executeInsert();
      } else {
        print(state);
      }
    });

    return Scaffold(
      appBar: AppBar(
        title: Text("NightTime"),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Padding(
              padding: EdgeInsets.fromLTRB(0, 200, 0, 0),
              child: Transform.scale(
                scale: 2.5,
                child: Switch(
                    value: isSwitched,
                    onChanged: (value) {
                      setState(() {
                        isSwitched = value;
                      });
                    }),
              ),
            ),
            Padding(
                padding: EdgeInsets.fromLTRB(0, 0, 0, 200),
                child: Status(isSwitched))
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          executeInsert();
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => DataDisplayPage()),
          );
        },
      ),
    );
  }
}

class Status extends StatelessWidget {
  bool isSwitched;

  Status(this.isSwitched);

  @override
  Widget build(BuildContext context) {
    return Builder(builder: (context) {
      if (isSwitched == true) {
        return Text("Application is running");
      } else {
        return Text("Application is not running");
      }
    });
  }
}

Future<void> executeInsert() async {
  final now = DateTime.now();
  final id = await getIdForInsert();
  await dbInsert(id, now, now);
}

Future<Stream<Time?>> dbInsert(
    int id, DateTime toSleep, DateTime wakeUp) async {
  print("INSERTING------------------------------INSERTING");
  final database =
      await $FloorFloorDB.databaseBuilder('app_database.db').build();
  final timeDAO = database.timeDAO;

  String toSleepStr = toSleep.toString();
  String wakeUpStr = wakeUp.toString();

  final time = Time(id, toSleepStr, wakeUpStr);
  print("INSERTING: " + time.toString());
  await timeDAO.insertTime(time);

  final result = await timeDAO.findTimeById(id);

  result.forEach((element) {
    print("SUCCESFULLY INSERTED: " + element.toString());
  });

  return result;
}

Future<int> getIdForInsert() async {
  final database =
      await $FloorFloorDB.databaseBuilder('app_database.db').build();
  final timeDAO = database.timeDAO;

  final List timeList = await timeDAO.findAllTime();
  final length = timeList.length;
  return length + 1;
}
