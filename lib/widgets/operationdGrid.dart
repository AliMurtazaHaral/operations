import 'package:flutter/material.dart';

import 'operationWidget.dart';

class OperationGridWidget extends StatefulWidget {
  final List<String> numbersList;

  OperationGridWidget({required this.numbersList});

  @override
  _OperationGridWidgetState createState() => _OperationGridWidgetState();
}

class _OperationGridWidgetState extends State<OperationGridWidget>
    with TickerProviderStateMixin {
  late List<AnimationController> _controllers;

  @override
  void initState() {
    super.initState();
    _controllers = List.generate(
      widget.numbersList.length,
          (index) => AnimationController(
        vsync: this,
        duration: Duration(milliseconds: 500),
      ),
    );

    for (int i = _controllers.length - 1; i >= 0; i--) {
      int rowIndex = i ~/ 2;
      Future.delayed(
        Duration(
          milliseconds: 500 * (widget.numbersList.length ~/ 2 - rowIndex) + 300,
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
          widget.numbersList.length ~/ 2,
              (rowIndex) {
            return Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: List.generate(
                2,
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
                        child: NumberWidget(number: widget.numbersList[index]),
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

