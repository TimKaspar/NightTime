import 'package:battery_plus/battery_plus.dart';
import 'package:flutter/material.dart';
import 'package:nighttime/data.dart';
import 'package:nighttime/time.dart';

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
  var battery = Battery();
  var _batteryState;

  bool isSwitched = false;


  @override
  void initState() {
    super.initState();
    battery.onBatteryStateChanged.listen((BatteryState state) {
      if(_batteryState != BatteryState.full && isSwitched == true) {
        if (_batteryState == null) {
          _batteryState = state;
        } else if (_batteryState != state) {
          print("CHANGE: " + state.toString());
          _batteryState = state;
          if (Time.toSleep.length == Time.wakeUp.length) {
            Time.toSleep.add(DateTime.now());
          } else if (Time.toSleep.length - 1 == Time.wakeUp.length) {
            Time.wakeUp.add(DateTime.now());
          }
          print("toSleep: "+Time.toSleep.toString());
          print("wakeUp: "+Time.wakeUp.toString());
        } else {
          print(state);
        }
      }
    });
  }

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
