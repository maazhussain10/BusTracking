import 'package:flutter/material.dart';

const kHintTextStyle = TextStyle(
  color: Color(0xFF707070),
  fontFamily: 'OpenSans',
);

const kLabelStyle = TextStyle(
  color: Color(0xFF000000),
  fontWeight: FontWeight.bold,
  fontFamily: 'OpenSans',
);

final kBoxDecorationStyle = BoxDecoration(
  color: Color(0xFFFFFFFF),
  borderRadius: BorderRadius.circular(10.0),
  boxShadow: [
    BoxShadow(
      color: Colors.black12,
      blurRadius: 6.0,
      offset: Offset(0, 2),
    ),
  ],
);