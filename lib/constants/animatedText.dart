import 'package:flutter/material.dart';

class AnimatedText extends StatefulWidget {
  @override
  _AnimatedTextState createState() => _AnimatedTextState();
}

class _AnimatedTextState extends State<AnimatedText>
    with TickerProviderStateMixin {
  late AnimationController _controller1;
  late AnimationController _controller2;
  late Animation<double> _animation1;
  late Animation<double> _animation2;

  @override
  void initState() {
    super.initState();

    _controller1 = AnimationController(
      duration: Duration(seconds: 1),
      vsync: this,
    );

    _controller2 = AnimationController(
      duration: Duration(seconds: 1),
      vsync: this,
    );

    _animation1 = Tween<double>(begin: -1.0, end: 0.0).animate(
      CurvedAnimation(
        parent: _controller1,
        curve: Curves.easeInOut,
      ),
    );

    _animation2 = Tween<double>(begin: -1.0, end: 0.0).animate(
      CurvedAnimation(
        parent: _controller2,
        curve: Curves.easeInOut,
      ),
    );

    _controller1.forward();
    _controller2.forward();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        TweenAnimationBuilder(
          tween: Tween(begin: -1.0, end: 0.0),
          duration: Duration(seconds: 1),
          builder: (context, value, child) {
            return Transform.translate(
              offset: Offset(value * MediaQuery.of(context).size.width, 0),
              child: Text(
                "Choose the Prime Numbers",
                style: TextStyle(
                  fontSize: MediaQuery.of(context).size.width * 0.05,
                  fontWeight: FontWeight.w800,
                  color: Colors.white,
                ),
              ),
            );
          },
        ),
        TweenAnimationBuilder(
          tween: Tween(begin: -1.0, end: 0.0),
          duration: Duration(seconds: 1),
          builder: (context, value, child) {
            return Transform.translate(
              offset: Offset(value * MediaQuery.of(context).size.width, 0),
              child: Text(
                "(40 pts)",
                style: TextStyle(
                  fontSize: MediaQuery.of(context).size.width * 0.05,
                  fontWeight: FontWeight.w800,
                  color: Color(0xFFFFD700),
                ),
              ),
            );
          },
        ),
      ],
    );
  }

  @override
  void dispose() {
    _controller1.dispose();
    _controller2.dispose();
    super.dispose();
  }
}
