import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class Spinners extends StatelessWidget {
  // const Spinners({Key? key}) : super(key: key);
  final Color color;
  final double size;

  Spinners({this.color, this.size});

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      child: SpinKitPulse(color: color, size: size),
    );
  }
}
