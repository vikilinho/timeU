import 'package:timekeeper/buttons.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MySettings extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Settings"),
        shape: ContinuousRectangleBorder(
            borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(80),
            )),
      ),
      body: Settings(),
    );
  }
}

class Settings extends StatefulWidget {
  @override
  _SettingsState createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {
  SharedPreferences prefs; //Variable for the sharedpreferences

  //Constants Variables for the sharedPreference
  static const String WORKTIME = "workTime";
  static const String SHORTBREAK = "shortBreak";
  static const String LONGBREAK = "longBreak";
  int workTime;
  int shortBreak;
  int longBreak;

  //First step in reading from the text feed is creating the object 0f the TextEditingController
  TextEditingController txtWork;
  TextEditingController txtShort;
  TextEditingController txtLong;
  @override
  void initState() {
    txtWork = TextEditingController();
    txtShort = TextEditingController();
    txtLong = TextEditingController();
    readSettings();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    //an Async operation return a future object, an object that is to be completed latter. await is use to suspend execution until the futur completes

    TextStyle textStyle = TextStyle(fontSize: 24);

    return Container(
        child: GridView.count(
          crossAxisCount: 3,
          scrollDirection: Axis.vertical,
          childAspectRatio: 3,
          crossAxisSpacing: 10,
          mainAxisSpacing: 10,
          children: <Widget>[
            Text(
              "Work",
              style: textStyle,
            ),
            Text(""),
            Text(""),
            SettingButton((Colors.blueGrey), "-", -1,WORKTIME, updateSetting),
            TextField(
              //Step two is making use of the TextEditingController object in the textField
                controller: txtWork,
                style: textStyle,
                textAlign: TextAlign.center,
                keyboardType: TextInputType.number),
            SettingButton(
                (Colors.indigo),
                "+",
                1, WORKTIME, updateSetting
            ),
            Text("Short", style: textStyle),
            Text(""),
            Text(""),
            SettingButton(
                (Colors.blueGrey),
                "-",
                -1, SHORTBREAK, updateSetting
            ),
            TextField(
                controller: txtShort,
                style: textStyle,
                textAlign: TextAlign.center,
                keyboardType: TextInputType.number),
            SettingButton((Colors.indigo), "+", 1, SHORTBREAK, updateSetting),
            Text(
              "Long",
              style: textStyle,
            ),
            Text(""),
            Text(""),
            SettingButton(
                (Colors.blueGrey),
                "-",
                -1, LONGBREAK, updateSetting
            ),
            TextField(
                controller: txtLong,
                style: textStyle,
                textAlign: TextAlign.center,
                keyboardType: TextInputType.number),
            SettingButton((Colors.indigo), "+", 1, LONGBREAK, updateSetting),
          ],
          padding: const EdgeInsets.all(20.0),
        ));
  }

  readSettings() async {
    prefs = await SharedPreferences.getInstance();
    int workTime = prefs.getInt(WORKTIME);
    if (workTime == null) {
      await prefs.setInt(WORKTIME, int.parse('30'));
    }

    int shortBreak = prefs.getInt(SHORTBREAK);
    if (shortBreak == null) {
      await prefs.setInt(SHORTBREAK, int.parse('5'));
    }

    int longBreak = prefs.getInt(LONGBREAK);
    if (longBreak == null) {
      await prefs.setInt(LONGBREAK, int.parse('20'));
    }
    setState(() {
      txtWork.text = workTime.toString();
      txtShort.text = shortBreak.toString();
      txtLong.text = longBreak.toString();
    });
  }

  void updateSetting(String key, int value) {
    switch (key) {
      case WORKTIME:
        {
          int workTime = prefs.getInt(WORKTIME);
          workTime += value;
          if (workTime >= 1 && workTime <= 180) {
            prefs.setInt(WORKTIME, workTime);
            setState(() {
              txtWork.text = workTime.toString();
            });
          }
        }
        break;
      case SHORTBREAK:
        {
          int short = prefs.getInt(SHORTBREAK);
          short += value;
          if (short >= 1 && short <= 120) {
            prefs.setInt(SHORTBREAK, short);
            setState(() {
              txtShort.text = short.toString();
            });
          }
        }
        break;
      case LONGBREAK:
        {
          int long = prefs.getInt(LONGBREAK);
          long += value;
          if (long >= 1 && long <= 180) {
            prefs.setInt(LONGBREAK, long);
            setState(() {
              txtLong.text = long.toString();
            });
          }
        }
        break;
    }
  }
}
