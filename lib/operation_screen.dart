import 'package:flutter/material.dart';
import 'package:operations/widgets/currentValueWidget.dart';
import 'package:operations/widgets/customAppBar.dart';
import 'package:operations/widgets/operationdGrid.dart';
import 'package:operations/widgets/resultValueWidget.dart';

import 'constants/animatedImagesWidget.dart';
import 'constants/animatedText.dart';

class OperationScreen extends StatefulWidget {
  List<String> numbersList = [
    "+",
    "-",
    "*",
    "/"
  ];
  List<String> sign = [
    "=",
  ];
  OperationScreen({Key? key}) : super(key: key);

  @override
  State<OperationScreen> createState() => _OperationScreenState();
}

class _OperationScreenState extends State<OperationScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
            height: MediaQuery.of(context).size.height,
            child: Image.asset('assets/images/bg_image.jpeg', fit: BoxFit.fill),
          ),
          SingleChildScrollView(
            child: Column(
              children: [
                CustomAppBar(),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.03,
                ),
                AnimatedText(),
                CurrentValueWidget(numbersList: widget.sign),
                AnimatedImagesWidget(),
                ResultGridWidget(numbersList: widget.sign),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.01,
                ),
                OperationGridWidget(numbersList: widget.numbersList)
              ],
            ),
          ),
        ],
      ),
    );
  }
}
