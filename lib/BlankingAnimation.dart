import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';

import 'ThirdPage.dart';

class BlankingAnimation extends StatelessWidget {
  /// Page Title

  /// second page constructor
  const BlankingAnimation({
    Key key,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Blanking Animation"),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text('Second Page'),
            PulsingWidget(
                child: RaisedButton(
              onPressed: () {},
              child: Text('Go Third Page'),
            ))
          ],
        ),
      ),
    );
  }
}

class PulsingWidget extends StatefulWidget {
  final Tween<double> tween;
  final Widget child;
  final Duration duration;

  const PulsingWidget({@required this.child, this.duration, this.tween})
      : assert(child != null);
  _PulsingWidget createState() => _PulsingWidget();
}

class _PulsingWidget extends State<PulsingWidget>
    with SingleTickerProviderStateMixin {
  AnimationController _animationController;
  Duration _duration;
  Tween<double> _tween;

  Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _tween = widget.tween ?? Tween(begin: 0.25, end: 1.0);
    _duration = widget.duration ?? Duration(milliseconds: 1500);
    _animationController = AnimationController(
      vsync: this,
      duration: _duration,
    );
    final CurvedAnimation curve = CurvedAnimation(
      parent: _animationController,
      curve: Curves.linear,
    );
    _animation = _tween.animate(curve);
    _animation.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        _animationController.reverse();
      } else if (status == AnimationStatus.dismissed) {
        _animationController.forward();
      }
    });
    _animationController.forward();
  }

  @override
  Widget build(BuildContext context) {
    return FadeTransition(
      opacity: _animation,
      child: widget.child,
    );
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }
}
