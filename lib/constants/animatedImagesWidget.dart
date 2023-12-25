import 'package:flutter/material.dart';

class AnimatedImagesWidget extends StatefulWidget {
  @override
  _AnimatedImagesWidgetState createState() => _AnimatedImagesWidgetState();
}

class _AnimatedImagesWidgetState extends State<AnimatedImagesWidget>
    with TickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 200),
    );
    _animation = Tween<double>(begin: 0, end: 1).animate(_controller);
    _controller.forward();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(right: MediaQuery.of(context).size.width * 0.05),
      child: Align(
        alignment: Alignment.topRight,
        child: FadeTransition(
          opacity: _animation,
          child: Stack(
            children: [
              Image.asset(
                "assets/images/suggest_image.png",
                height: MediaQuery.of(context).size.height * 0.13,
                width: MediaQuery.of(context).size.width * 0.13,
              ),
              Positioned(
                top: MediaQuery.of(context).size.width * 0.195,
                left: MediaQuery.of(context).size.height * 0.008,
                child: IntrinsicWidth(
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.horizontal(
                        left: Radius.circular(
                            MediaQuery.of(context).size.width * 0.05),
                        right: Radius.circular(
                            MediaQuery.of(context).size.width * 0.05),
                      ),
                      color: Color(0xFFE3DDDA),
                    ),
                    child: Padding(
                      padding: EdgeInsets.symmetric(
                          horizontal: MediaQuery.of(context).size.width * 0.01),
                      child: Row(
                        children: [
                          Image.asset(
                            "assets/images/coin_imag.png",
                            height: MediaQuery.of(context).size.height * 0.03,
                            width: MediaQuery.of(context).size.width * 0.03,
                          ),
                          Text(
                            "200",
                            style: TextStyle(
                              fontSize:
                                  MediaQuery.of(context).size.width * 0.03,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}
