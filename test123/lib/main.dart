import 'package:flutter/material.dart';
import 'package:test123/data.dart';

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
      routes: {
        "/main" : (context) => MyHomePage(),
        "/data" : (context) => Data()
      },
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
    return Scaffold(
      appBar: AppBar(
        title: Text("NightTime"),
      ),
      body: Column(
        children: [
          Switch(value: isSwitched, onChanged: (value){
            setState(() {
              isSwitched = value;
              //TODO start app
            });
          }),
          Active(isSwitched)
        ],
      )
    );
  }
}

class Active extends StatelessWidget{
  bool isSwitched;


  Active(this.isSwitched);

  @override
  Widget build(BuildContext context) {
    return Builder(builder: (context){
      if(isSwitched == true){
        return Text("true");
      }else{
        return Text("notTrue");
      }
    });
  }



}
