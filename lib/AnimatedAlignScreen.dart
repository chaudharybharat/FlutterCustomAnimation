import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AnimatedAlignScreen extends StatefulWidget {
  _AnimatedAlignScreenState createState() => _AnimatedAlignScreenState();
}

class _AnimatedAlignScreenState extends State<AnimatedAlignScreen> {
  double opacityLevel = 0.0;
  var owl_url =
      'https://raw.githubusercontent.com/flutter/website/master/src/images/owl.jpg';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
      child: Column(children: <Widget>[
        Image.network(owl_url),
        TextButton(
          child: Text(
            'Show details',
            style: TextStyle(color: Colors.blueAccent),
          ),
          onPressed: () => setState(() {
            if (opacityLevel == 0.0) {
              opacityLevel = 1.0;
            } else {
              opacityLevel = 0.0;
            }
          }),
        ),
        AnimatedOpacity(
          duration: Duration(seconds: 3),
          opacity: opacityLevel,
          child: Column(
            children: <Widget>[
              Text('Type: Owl'),
              Text('Age: 39'),
              Text('Employment: None'),
            ],
          ),
        )
      ]),
    ));
  }
}
