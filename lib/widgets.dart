import 'package:flutter/material.dart';

typedef CallBackSetting = void Function(String, int);

class ProductivityButton extends StatelessWidget {
  @required
  late final Color color;
  @required
  late final String text;
  @required
  late final double size;
  @required
  late final VoidCallback onPressed;

  ProductivityButton(
      {required this.color,
      required this.text,
      required this.size,
      required this.onPressed});

  Widget build(BuildContext context) {
    return MaterialButton(
      child: Text(
        this.text,
        style: TextStyle(
          color: Colors.white,
        ),
      ),
      onPressed: this.onPressed,
      color: this.color,
      minWidth: this.size,
    );
  }
}

class SettingsButton extends StatelessWidget {
  late final Color color;
  late final String text;
  late final int value;

  late final String setting;
  late final CallBackSetting callback;

  SettingsButton(
      this.color, this.text, this.value, this.setting, this.callback);

  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      child: Text(
        this.text,
        style: TextStyle(color: Colors.white),
      ),
      onPressed: () => this.callback(this.setting, this.value),
      color: this.color,
    );
  }
}
