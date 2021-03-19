import 'package:flutter/material.dart';

class AnimationBuilderScreen extends StatefulWidget {
  @override
  _AnimationBuilderScreenState createState() => _AnimationBuilderScreenState();
}

class _AnimationBuilderScreenState extends State<AnimationBuilderScreen>
    with SingleTickerProviderStateMixin {
  final Image starsBackground = Image.asset(
    'assets/milky-way.jpg',
  );
  final Image ufo = Image.asset('assets/ufo.jpeg');
  AnimationController _animation;

  @override
  void initState() {
    super.initState();
    _animation = AnimationController(
      duration: const Duration(seconds: 5),
      vsync: this,
    )..repeat();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: AlignmentDirectional.center,
      children: <Widget>[
        starsBackground,
        AnimatedBuilder(
          animation: _animation,
          builder: (_, __) {
            return ClipPath(
              clipper: const BeamClipper(),
              child: Container(
                height: 1000,
                decoration: BoxDecoration(
                  gradient: RadialGradient(
                    radius: 1.5,
                    colors: [
                      Colors.yellow,
                      Colors.transparent,
                    ],
                    stops: [0, _animation.value],
                  ),
                ),
              ),
            );
          },
        ),
        ufo,
      ],
    );
  }

  @override
  void dispose() {
    _animation.dispose();
    super.dispose();
  }
}

class BeamClipper extends CustomClipper<Path> {
  const BeamClipper();

  @override
  getClip(Size size) {
    return Path()
      ..lineTo(size.width / 2, size.height / 2)
      ..lineTo(size.width, size.height)
      ..lineTo(0, size.height)
      ..lineTo(size.width / 2, size.height / 2)
      ..close();
  }

  /// Return false always because we always clip the same area.
  @override
  bool shouldReclip(CustomClipper oldClipper) => false;
}
