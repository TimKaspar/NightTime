import 'package:flutter/material.dart';
import 'package:nighttime/data.dart';

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
              child: Transform.scale(scale: 2.5,
                child: Switch(value: isSwitched, onChanged: (value){
                  setState(() {
                    isSwitched = value;
                    //TODO start app
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
          Navigator.push(context,
            MaterialPageRoute(builder: (context) => Data()),
          );
        },

      ),
    );
  }
}

class Status extends StatelessWidget{
  bool isSwitched;


  Status(this.isSwitched);

  @override
  Widget build(BuildContext context) {
    return Builder(builder: (context){
      if(isSwitched == true){
        return Text("Application is running");
      }else{
        return Text("Application is not running");
      }
    });
  }



}
