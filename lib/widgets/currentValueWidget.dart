import 'package:flutter/material.dart';

import 'currentResultWidget.dart';

class CurrentValueWidget extends StatefulWidget {
  final List<String> numbersList;

  CurrentValueWidget({required this.numbersList});

  @override
  _CurrentValueWidgetState createState() => _CurrentValueWidgetState();
}

class _CurrentValueWidgetState extends State<CurrentValueWidget> with TickerProviderStateMixin {
  late List<AnimationController> _controllers;

  @override
  void initState() {
    super.initState();
    _controllers = List.generate(
      widget.numbersList.length,
          (index) => AnimationController(
        vsync: this,
        duration: Duration(milliseconds: 900),
      ),
    );

    for (int i = _controllers.length - 1; i >= 0; i--) {
      int rowIndex = i ;
      Future.delayed(
        Duration(
          milliseconds: 900 * (widget.numbersList.length - rowIndex) + 500,
        ),
            () {
          _controllers[i].forward();
        },
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: MediaQuery.of(context).size.width * 0.027,
      ),
      child: Column(
        children: List.generate(
          widget.numbersList.length,
              (rowIndex) {
            return Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: List.generate(
                1,
                    (colIndex) {
                  int index = rowIndex * 2 + colIndex;
                  return AnimatedBuilder(
                    animation: _controllers[index],
                    builder: (context, child) {
                      return Transform.translate(
                        offset: Offset(
                          -MediaQuery.of(context).size.width +
                              _controllers[index].value *
                                  MediaQuery.of(context).size.width,
                          0.0,
                        ),
                        child: CurrentResultWidget(),
                      );
                    },
                  );
                },
              ),
            );
          },
        ),
      ),
    );
  }

  @override
  void dispose() {
    for (var controller in _controllers) {
      controller.dispose();
    }
    super.dispose();
  }
}

