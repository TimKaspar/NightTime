import 'package:battery_plus/battery_plus.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:nighttime/data.dart';
import 'package:nighttime/time.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  final Future<FirebaseApp> _fbApp = Firebase.initializeApp();

  runApp(
    FutureBuilder(
      future: _fbApp,
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return Text('Initialization Error');
        } else if (snapshot.hasData) {
          return MyApp();
        } else {
          return Center(
            child: CircularProgressIndicator(),
          );
        }
      },
    ),
  );
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

    Timestamp toSleep = Timestamp.now();
    Timestamp wakeUp = Timestamp.now();

    CollectionReference collection =
        FirebaseFirestore.instance.collection("time");

    battery.onBatteryStateChanged.listen((BatteryState state) {
      if (_batteryState == null) {
        _batteryState = state;
      } else if (_batteryState != state) {
        print("CHANGE: " + state.toString());
        _batteryState = state;
        if(Time.toSleep.length == Time.wakeUp.length){
          Time.toSleep.add(DateTime.now());
        } else if(Time.toSleep.length - 1 == Time.wakeUp.length){
          Time.wakeUp.add(DateTime.now());
        }

        //TODO create
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
                        collection.add({"toSleep": toSleep, "wakeUp": wakeUp});
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
