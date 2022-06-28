import 'package:flutter/material.dart';

const kPrimaryColor = Color.fromRGBO(68, 68, 68, 1); // HEX - #444444
const kSecondaryColor = Color.fromRGBO(31, 107, 198, 1); // HEX - #1F6BC6
const kTeritaryColor = Color.fromRGBO(252, 182, 1, 1); //HEX - #FCB601
const kBackgroundColor = Color.fromRGBO(244, 244, 244, 1); // HEX - #F4F4F4
const kWhitishBackgrounColor = Color.fromRGBO(250, 250, 250, 1); //HEX - #FAFAFA

const kPrimaryFromLefttoRightGradientColor = LinearGradient(
  begin: Alignment.centerLeft,
  end: Alignment.centerRight,
  colors: [
    Color.fromRGBO(65, 116, 206, 1),
    Color.fromRGBO(62, 160, 240, 1)
  ], // HEX from #4174CE to #3EA0F0
);

const kPrimaryFromTopToBottomGradientColor = LinearGradient(
  begin: Alignment.topCenter,
  end: Alignment.bottomCenter,
  colors: [
    Color.fromRGBO(65, 116, 206, 1),
    Color.fromRGBO(62, 160, 240, 1)
  ], // HEX from #4174CE to #3EA0F0
);

const kPrimaryFromTopLeftToBottomRightGradientColor = LinearGradient(
  begin: Alignment.topLeft,
  end: Alignment.bottomRight,
  colors: [Color.fromRGBO(65, 116, 206, 1), Color.fromRGBO(62, 160, 240, 1)],
);

const kTextColor = Color.fromRGBO(68, 68, 68, 1); // HEX - #444444

const kAnimationDuration = Duration(milliseconds: 200);
const kSliderAnimationDuration = Duration(milliseconds: 700);
