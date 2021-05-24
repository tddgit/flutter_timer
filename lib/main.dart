import 'package:flutter/material.dart';
import 'package:flutter_timer/settings.dart';
import 'package:flutter_timer/timer.dart';
import 'package:flutter_timer/timermodel.dart';
import 'package:flutter_timer/widgets.dart';
import 'package:percent_indicator_nullsafe/percent_indicator_nullsafe.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'My Work Timer',
      theme: ThemeData(
        primarySwatch: Colors.blueGrey,
      ),
      home: TimerHomePage(),
    );
  }
}

class TimerHomePage extends StatelessWidget {
  final double defaultPadding = 5.0;
  final CountDownTimer timer = CountDownTimer();

  void goToSettings(BuildContext context) {
    print('in goToSettings');
    Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => SettingsScreen(),
        ));
  }

  @override
  Widget build(BuildContext context) {
    final List<PopupMenuItem<String>> menuItems = [
      PopupMenuItem(
        value: 'Settings',
        child: Text('Settings'),
      ),
    ];
    return Scaffold(
      appBar: AppBar(
        title: Text("My Work Timer"),
        actions: [
          PopupMenuButton<String>(
            itemBuilder: (BuildContext context) {
              return menuItems.toList();
            },
            onSelected: (s) {
              goToSettings(context);
            },
          )
        ],
      ),
      body: LayoutBuilder(
        builder: (BuildContext context, BoxConstraints constraints) {
          final double availableWidth = constraints.maxWidth;
          return Column(
            children: [
              Row(
                children: [
                  Padding(padding: EdgeInsets.all(defaultPadding)),
                  Expanded(
                    child: ProductivityButton(
                      color: Color(0xff009688),
                      text: "Work",
                      onPressed: timer.startWork,
                      size: 20,
                    ),
                  ),
                  Padding(padding: EdgeInsets.all(defaultPadding)),
                  Expanded(
                    child: ProductivityButton(
                      color: Color(0xff607D8B),
                      text: "Short Break",
                      onPressed: () => timer.startBreak(true),
                      size: 20,
                    ),
                  ),
                  Padding(padding: EdgeInsets.all(defaultPadding)),
                  Expanded(
                    child: ProductivityButton(
                      color: Color(0xff455A64),
                      text: "Long Break",
                      onPressed: () => timer.startBreak(false),
                      size: 20,
                    ),
                  ),
                  Padding(padding: EdgeInsets.all(defaultPadding)),
                ],
              ),
              Expanded(
                child: StreamBuilder(
                  initialData: '00:00',
                  stream: timer.stream(),
                  builder: (BuildContext context, AsyncSnapshot snapshot) {
                    TimerModel timer = (snapshot.data == '00:00')
                        ? TimerModel("00:00", 1)
                        : snapshot.data;
                    return CircularPercentIndicator(
                      diameter: availableWidth / 2,
                      lineWidth: 10.0,
                      percent: timer.percent,
                      center: Text(timer.time),
                      progressColor: Color(0xff009688),
                      // style: Theme.of(context).textTheme.headline4
                    );
                  },
                ),
              ),
              Row(
                children: [
                  Padding(padding: EdgeInsets.all(defaultPadding)),
                  Expanded(
                    child: ProductivityButton(
                      color: Color(0xff212121),
                      text: "Stop",
                      onPressed: timer.stopTimer,
                      size: 20,
                    ),
                  ),
                  Padding(padding: EdgeInsets.all(defaultPadding)),
                  Expanded(
                    child: ProductivityButton(
                      color: Color(0xff009688),
                      text: "Restart",
                      onPressed: timer.startTimer,
                      size: 20,
                    ),
                  ),
                  Padding(padding: EdgeInsets.all(defaultPadding)),
                ],
              ),
              Padding(padding: EdgeInsets.all(defaultPadding * 4)),
            ],
          );
        },
      ),
    );
  }
}
