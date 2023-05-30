import 'package:flutter/material.dart';

const colorBackground = Color.fromARGB(255, 247, 235, 235);
const colorWhiteBackground = Color(0xFFFFFFFF);
const primaryText = Color.fromARGB(255, 172, 20, 20);
const colorPrimary = Color(0xFF15558D);
const colorSurface = Color(0xFFFCF1F1);
const colorHighlight = Color(0xFFFFD2D2);
const colorPrimaryVariant = Color(0xFF15558D);
const colorOnHighlight = Color(0xFF000000);
const colorOnBackground = Color(0xFF15558D);
const colorBoxOutline = Color(0x7815558D);
const colorLink = Color(0xFF531C1C);
const colorOnSurface = Color(0xFF585858);
const colorCodeRed = Color(0xFFDE1F1F);
const colorGrayBtn = Color(0xFFC4C4C4);
const colorShadow = Color(0xFF653030);

TextStyle genTxt = TextStyle(
  fontFamily: 'PTSans',
  color: primaryText,
  fontStyle: FontStyle.normal,
  letterSpacing: 0.5,
  fontWeight: FontWeight.normal,
  fontSize: 10,
);

TextStyle appBarText = TextStyle(
  fontFamily: 'Roboto',
  color: primaryText,
  fontStyle: FontStyle.normal,
  letterSpacing: 0.8,
  fontWeight: FontWeight.bold,
  fontSize: 25,
  height: 0.5,
);
InputDecoration inputDecor = InputDecoration(
  contentPadding: EdgeInsets.fromLTRB(10, 3, 10, 3),
  floatingLabelStyle: genTxt.copyWith(fontSize: 16),
  hintStyle: genTxt.copyWith(fontSize: 16),
  errorStyle: genTxt.copyWith(height: 0),
  floatingLabelBehavior: FloatingLabelBehavior.always,
  counterStyle: genTxt.copyWith(fontSize: 8),
  enabledBorder: OutlineInputBorder(
    borderSide: BorderSide(
      color: Colors.blue,
      width: 1.0,
    ),
  ),
  errorBorder: OutlineInputBorder(
    borderSide: BorderSide(
      color: Colors.red,
      width: 1.0,
    ),
  ),
  focusedErrorBorder: OutlineInputBorder(
    borderSide: BorderSide(
      color: Colors.red,
      width: 1.0,
    ),
  ),
  disabledBorder: OutlineInputBorder(
    borderSide: BorderSide(
      color: Colors.blue,
      width: 1.0,
    ),
  ),
  focusedBorder: OutlineInputBorder(
    borderSide: BorderSide(
      color: colorBoxOutline,
      width: 2.0,
    ),
  ),
);
