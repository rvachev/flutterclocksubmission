import 'package:flutter/material.dart';
import 'package:rvachev_clock/screens/mainscreen.dart';

void main() => runApp(MaterialApp(
  debugShowCheckedModeBanner: false,
  routes: {
    "/": (context) => MainScreen()
  },
  builder: (context, child){
    return MediaQuery(
      child: child,
      data: MediaQuery.of(context).copyWith(textScaleFactor: 1.0)
    );
  },
));