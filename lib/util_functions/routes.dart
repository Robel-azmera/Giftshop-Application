import 'package:flutter/material.dart';

class Routes {
  void navigation(BuildContext context, page) {
    Navigator.of(context).push<void>(
        MaterialPageRoute<void>(builder: (BuildContext context) => page));
  }

  // Specially for splash screen
  void pushReplacementNavigation(BuildContext context, page) {
    Navigator.of(context).pushReplacement(
        MaterialPageRoute<void>(builder: (BuildContext context) => page));
  }
}
