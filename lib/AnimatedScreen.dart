import 'dart:math';

import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';

import 'ThirdPage.dart';

class AnimatedScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return AnimatedScreenState();
  }

  /// Page Title

}

class AnimatedScreenState extends State<AnimatedScreen> {
  /// second page constructor
  final Image ufo = Image.asset('assets/ufo.jpeg');
  bool _bigger = false;

  Color color;
  double borderRadius;
  double margin;
  var _duration = Duration(milliseconds: 400);
  @override
  void initState() {
    super.initState();
    color = Colors.deepPurple;
    borderRadius = randomBorderRadius();
    margin = randomMargin();
  }

  @override
  Widget build(BuildContext context) {
    final args = ModalRoute.of(context).settings.arguments;
    return Scaffold(
      appBar: AppBar(
        title: Text(args ?? "Animated Container"),
      ),
      body: SingleChildScrollView(
          child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            AnimatedContainer(
              decoration: BoxDecoration(
                  gradient: RadialGradient(
                      colors: [Colors.purple, Colors.transparent],
                      stops: [_bigger ? 0.2 : 0.5, 1.0])),
              duration: Duration(seconds: 2),
              height: _bigger ? 500 : 200,
              width: _bigger ? 500 : 200,
              child: ufo,
              // curve: SineCurve(),
            ),
            SizedBox(height: 10),
            RaisedButton(
              child: Text("click here"),
              onPressed: () {
                setState(() {
                  _bigger = !_bigger;
                });
              },
            ),
            SizedBox(
              height: 10,
            ),
            SizedBox(
              width: 128,
              height: 128,
              child: AnimatedContainer(
                margin: EdgeInsets.all(margin),
                decoration: BoxDecoration(
                  color: color,
                  borderRadius: BorderRadius.circular(borderRadius),
                ),
                duration: _duration,
              ),
            ),
            ElevatedButton(
              child: Text('change'),
              onPressed: () => change(),
            ),
            SizedBox(
              height: 30,
            ),
          ],
        ),
      )),
    );
  }

  void change() {
    setState(() {
      color = randomColor();
      borderRadius = randomBorderRadius();
      margin = randomMargin();
    });
  }

  double randomBorderRadius() {
    return Random().nextDouble() * 64;
  }

  double randomMargin() {
    return Random().nextDouble() * 64;
  }

  Color randomColor() {
    return Color(0xFFFFFFFF & Random().nextInt(0xFFFFFFFF));
  }
}

class SineCurve extends Curve {
  final double count;

  SineCurve({this.count = 1});

  @override
  double transformInternal(double t) {
    return sin(count * 2 * pi * t) * 0.5 + 0.5;
  }
}
