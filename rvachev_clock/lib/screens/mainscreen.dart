import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class MainScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => MainScreenState();
}

class MainScreenState extends State<MainScreen>
    with SingleTickerProviderStateMixin {
  DateTime _dateTime;
  Timer _timer;
  int _firsthour, _secondhour, _firstminute, _secondminute;
  double _firsthouralign,
      _secondhouralign,
      _firstminutealign,
      _secondminutealign;
  Curve _firsthourcurve,
      _secondhourcurve,
      _firstminutecurve,
      _secondminutecurve;
  IconData iconmode = Icons.wb_sunny;
  Color bgcolor = Colors.black, fgcolor = Colors.white;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
        backgroundColor: bgcolor,
        body: AnimatedContainer(
            duration: Duration(seconds: 1),
            color: bgcolor,
            child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Stack(children: <Widget>[
              Semantics(
                label: 'Now is ${_dateTime.hour} and ${_dateTime.minute}',
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    AnimatedAlign(
                      child: Text('$_firsthour',
                          style: TextStyle(fontSize: 200, color: fgcolor)),
                      alignment: Alignment(0.0, _firsthouralign),
                      duration: Duration(milliseconds: 800),
                      curve: _firsthourcurve,
                    ),
                    AnimatedAlign(
                        child: Text('$_secondhour',
                            style: TextStyle(fontSize: 200, color: fgcolor)),
                        alignment: Alignment(0.0, _secondhouralign),
                        duration: Duration(milliseconds: 800),
                        curve: _secondhourcurve),
                    VerticalDivider(
                      width: 15,
                      color: fgcolor,
                    ),
                    AnimatedAlign(
                        child: Text('$_firstminute',
                            style: TextStyle(fontSize: 200, color: fgcolor)),
                        alignment: Alignment(0.0, _firstminutealign),
                        duration: Duration(milliseconds: 800),
                        curve: _firstminutecurve),
                    AnimatedAlign(
                        child: Text('$_secondminute',
                            style: TextStyle(fontSize: 200, color: fgcolor)),
                        alignment: Alignment(0.0, _secondminutealign),
                        duration: Duration(milliseconds: 800),
                        curve: _secondminutecurve)
                  ],
                ),
              ),
              Align(
                alignment: Alignment(0.0, 0.0),
                child: AnimatedContainer(
                  duration: Duration(seconds: 1),
                  decoration:
                      BoxDecoration(color: fgcolor, shape: BoxShape.circle),
                  child: IconButton(
                    iconSize: 50.0,
                    icon: Icon(
                      iconmode,
                      color: bgcolor,
                    ),
                    onPressed: () {
                      setState(() {
                        iconmode = iconmode == Icons.brightness_3
                            ? Icons.wb_sunny
                            : Icons.brightness_3;
                        bgcolor =
                            bgcolor == Colors.black ? Colors.white : Colors.black;
                        fgcolor =
                            fgcolor == Colors.black ? Colors.white : Colors.black;
                      });
                    },
                  ),
                ),
              )
            ]),
          ),
        ));
  }

  @override
  void dispose(){
    _timer?.cancel();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    SystemChrome.setPreferredOrientations(
        [DeviceOrientation.landscapeRight, DeviceOrientation.landscapeLeft]);
    updateTime();
    SystemChrome.setEnabledSystemUIOverlays([]);
  }



  updateTime() {
    setState(() {
      _dateTime = DateTime.now();

      _firsthour = _dateTime.hour ~/ 10;
      _secondhour = _dateTime.hour % 10;
      _firstminute = _dateTime.minute ~/ 10;
      _secondminute = _dateTime.minute % 10;

      if (_firsthour == 0) {
        _firsthourcurve = Curves.bounceOut;
      } else {
        _firsthourcurve = Curves.easeIn;
      }
      if (_secondhour == 0) {
        _secondhourcurve = Curves.bounceOut;
      } else {
        _secondhourcurve = Curves.easeIn;
      }
      if (_firstminute == 0) {
        _firstminutecurve = Curves.bounceOut;
      } else {
        _firstminutecurve = Curves.easeIn;
      }
      if (_secondminute == 0) {
        _secondminutecurve = Curves.bounceOut;
      } else {
        _secondminutecurve = Curves.easeIn;
      }

      _secondminutealign = (_secondminute * (2 / 10.0)) - 1;
      _firstminutealign =
          ((_firstminute * (2 / 6.0)) - 1) + (_secondminute * (0.33 / 10.0));
      if (_firsthour != 2) {
        _secondhouralign =
            ((_secondhour * (2 / 10.0)) - 1) + (_firstminute * (0.2 / 5.0));
        _firsthouralign =
            ((_firsthour * (2 / 3.0)) - 1) + (_secondhour * (0.67 / 10.0));
      } else {
        _secondhouralign =
            ((_secondhour * (2 / 4.0)) - 1) + (_firstminute * (0.5 / 5.0));
        _firsthouralign =
            ((_firsthour * (2 / 3.0)) - 1) + (_secondhour * (0.67 / 4.0));
      }

      _timer = Timer(
          Duration(minutes: 1) -
              Duration(seconds: _dateTime.second) -
              Duration(milliseconds: _dateTime.millisecond),
          updateTime);
    });
  }
}
