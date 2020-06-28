import 'dart:async';


import 'package:timekeeper/settings.dart';
import 'package:flutter/material.dart';
import 'package:percent_indicator/percent_indicator.dart';
import 'package:timekeeper/timer.dart';
import 'package:timekeeper/timermodel.dart';



class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final defaultPadding = 5.0;
  final CountDownTimer timer = CountDownTimer();

  @override
  Widget build(BuildContext context) {
    final List<PopupMenuItem<String>> menuItems = List<PopupMenuItem<String>>();
    menuItems.add(PopupMenuItem(value: 'settings', child: Text('Settings')));

    void gotoMySettings(BuildContext context) {
      Navigator.push(
          context, MaterialPageRoute(builder: (context) => MySettings()));
    }

    timer.startTask();

    return Scaffold(
      appBar: AppBar(
        shape: ContinuousRectangleBorder(
            borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(80),
            )
        ),
        actions: <Widget>[
          PopupMenuButton<String>(
            itemBuilder: (BuildContext context) {
              return menuItems.toList();
            },
            onSelected: (s) {
              if (s == 'settings') {
                gotoMySettings(context);
              }
            },
          ),

        ],
        title: Text(
          "TimeU",
          textAlign: TextAlign.center,
          style: TextStyle(

              fontStyle: FontStyle.italic, fontWeight: FontWeight.bold),
        ),
      ),
      body: LayoutBuilder(
          builder: (BuildContext context, BoxConstraints constraints) {
            final double availableWidth = constraints.maxWidth;
            return Column(
              children: <Widget>[
                Row(
                  children: <Widget>[
                    Padding(padding: EdgeInsets.all(defaultPadding)),
                    Expanded(
                        child: RaisedButton(
                          onPressed: () => timer.startTask(),
                          color: Colors.pink[900],
                          splashColor: Colors.green[500],
                          child: Text(
                            "Task",
                            style: TextStyle(
                              color: Colors.white,
                            ),
                          ),
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                              side: BorderSide(color: Colors.black)),
                        )),
                    Padding(padding: EdgeInsets.all(defaultPadding)),
                    Expanded(
                        child: RaisedButton(
                          onPressed: () => timer.startBreak(true),
                          color: Colors.green[900],
                          splashColor: Colors.red[700],
                          child: Text(
                            "Short Break",
                            style: TextStyle(
                              color: Colors.white,
                            ),
                          ),
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                              side: BorderSide(color: Colors.black)),
                        )),
                    Padding(padding: EdgeInsets.all(defaultPadding)),
                    Expanded(
                        child: RaisedButton(
                          splashColor: Colors.orange[900],
                          onPressed: () => timer.startBreak(false),
                          color: Colors.blue,
                          child: Text(
                            "Long Break",
                            style: TextStyle(
                              color: Colors.white,
                            ),
                          ),
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                              side: BorderSide(color: Colors.black)),
                        )),
                    Padding(padding: EdgeInsets.all(defaultPadding)),
                  ],
                ),
                Expanded(
                  child: StreamBuilder(
                      initialData: TimerModel('00:00', 1),
                      stream: timer.stream(),
                      builder: (BuildContext context, AsyncSnapshot snapshot) {
                        TimerModel timer = (snapshot.data == '00:00')
                            ? TimerModel('00:00', 1)
                            : snapshot.data;
                        return Container(
                          child: CircularPercentIndicator(
                            radius: availableWidth / 2,
                            lineWidth: 10.0,
                            percent: timer.percent,
                            center: Text(timer.time,
                                style: Theme.of(context).textTheme.headline3),
                            progressColor: Colors.deepPurple[900],
                          ),
                        );
                      }),
                ),
                Row(
                  children: <Widget>[
                    Expanded(
                        child: RaisedButton(
                          elevation: 10.0,
                          splashColor: Colors.yellow,
                          onPressed: () => timer.startTimer(),
                          color: Colors.teal[900],
                          child: Text(
                            "Start",
                            style: TextStyle(
                              color: Colors.white,
                            ),
                          ),
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                              side: BorderSide(color: Colors.black)),
                        )),
                    Padding(padding: EdgeInsets.all(defaultPadding)),
                    Expanded(
                        child: RaisedButton(
                          elevation: 25.0,
                          onPressed: () => timer.stopTask(),
                          color: Colors.black,
                          splashColor: Colors.red[300],
                          child: Text(
                            "Stop",
                            style: TextStyle(
                              color: Colors.white,
                            ),
                          ),
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                              side: BorderSide(color: Colors.black)),
                        )),
                    Padding(padding: EdgeInsets.all(defaultPadding)),
                  ],
                ),
              ],
            );
          }),
    );
  }

  void emptyMethod() {}
}
