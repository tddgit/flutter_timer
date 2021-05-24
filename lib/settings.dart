import 'package:flutter/material.dart';
import 'package:flutter_timer/widgets.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SettingsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Settings"),
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
  TextStyle textStyle = TextStyle(fontSize: 24);

  late TextEditingController txtWork = TextEditingController(
    text: workTime.toString(),
  );
  late TextEditingController txtShort = TextEditingController(
    text: shortBreak.toString(),
  );
  late TextEditingController txtLong = TextEditingController(
    text: longBreak.toString(),
  );

  static const String WORKTIME = "workTime";
  static const String SHORTBREAK = "shortBreak";
  static const String LONGBREAK = "longBreak";

  late int workTime = 30;
  late int shortBreak = 5;
  late int longBreak = 20;

  // late SharedPreferences prefs;

  _SettingsState() {
    readSettings();
  }

  // void setIntialSharedPreferences() async {
  //   prefs = await SharedPreferences.getInstance();
  //   prefs.setInt(WORKTIME, workTime);
  //   prefs.setInt(SHORTBREAK, shortBreak);
  //   prefs.setInt(LONGBREAK, longBreak);
  // }

  @override
  void initState() {
    TextEditingController txtWork = TextEditingController();
    TextEditingController txtLong = TextEditingController();
    TextEditingController txtShort = TextEditingController();
    readSettings();
    super.initState();
  }

  void readSettings() async {
    SharedPreferences.setMockInitialValues({});
    var prefs = await SharedPreferences.getInstance();
    int? workTime = prefs.getInt(WORKTIME);
    if (workTime == null) {
      await prefs.setInt(WORKTIME, 30);
    }
    int? shortBreak = prefs.getInt(SHORTBREAK);
    if (shortBreak == null) {
      await prefs.setInt(SHORTBREAK, 5);
    }
    int? longBreak = prefs.getInt(LONGBREAK);
    if (longBreak == null) {
      await prefs.setInt(LONGBREAK, 20);
    }

    setState(
      () {
        txtWork.text = workTime.toString();
        txtShort.text = shortBreak.toString();
        txtLong.text = longBreak.toString();
      },
    );
  }

  void updateSettings(String key, int value) async {
    // SharedPreferences.setMockInitialValues({});
    var prefs = await SharedPreferences.getInstance();
    switch (key) {
      case WORKTIME:
        {
          int? workTime = prefs.getInt(WORKTIME);
          workTime = (workTime == null) ? 0 : workTime;
          workTime += value;
          if (workTime >= 1 && workTime <= 180) {
            prefs.setInt(WORKTIME, workTime);
            setState(
              () {
                txtWork.text = workTime.toString();
              },
            );
          }
        }
        break;
      case SHORTBREAK:
        {
          int? short = prefs.getInt(SHORTBREAK);
          short = (short == null) ? 0 : short;
          short += value;
          if (short >= 1 && short <= 180) {
            prefs.setInt(SHORTBREAK, short);
            setState(
              () {
                txtShort.text = short.toString();
              },
            );
          }
        }
        break;
      case LONGBREAK:
        {
          int? long = prefs.getInt(LONGBREAK);
          long = (long == null) ? 0 : long;
          long += value;
          if (long >= 1 && long <= 180) {
            prefs.setInt(LONGBREAK, long);
            setState(
              () {
                txtLong.text = long.toString();
              },
            );
          }
        }
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        child: GridView.count(
            crossAxisCount: 3,
            scrollDirection: Axis.vertical,
            childAspectRatio: 3,
            crossAxisSpacing: 10,
            mainAxisSpacing: 10,
            children: <Widget>[
              Text("Work", style: textStyle),
              Text(""),
              Text(""),
              SettingsButton(
                Color(0xff009688),
                "-",
                -1,
                WORKTIME,
                updateSettings,
              ),
              TextField(
                style: textStyle,
                textAlign: TextAlign.center,
                keyboardType: TextInputType.number,
                controller: txtWork,
              ),
              SettingsButton(
                Color(0xff009688),
                "+",
                1,
                WORKTIME,
                updateSettings,
              ),
              Text("Short", style: textStyle),
              Text(""),
              Text(""),
              SettingsButton(
                Color(0xff009688),
                "-",
                -1,
                SHORTBREAK,
                updateSettings,
              ),
              TextField(
                style: textStyle,
                textAlign: TextAlign.center,
                keyboardType: TextInputType.number,
                controller: txtShort,
              ),
              SettingsButton(
                Color(0xff009688),
                "+",
                1,
                SHORTBREAK,
                updateSettings,
              ),
              Text("Long", style: textStyle),
              Text(""),
              Text(""),
              SettingsButton(
                Color(0xff009688),
                "-",
                -1,
                LONGBREAK,
                updateSettings,
              ),
              TextField(
                style: textStyle,
                textAlign: TextAlign.center,
                keyboardType: TextInputType.number,
                controller: txtLong,
              ),
              SettingsButton(
                Color(0xff009688),
                "+",
                1,
                LONGBREAK,
                updateSettings,
              ),
            ],
            padding: const EdgeInsets.all(20.0)));
  }
}
