import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../constants/constants.dart';
import 'customAppBar.dart';

enum Operation { plus, minus }

class NumberController extends GetxController {
  RxBool isHolding = false.obs;
  RxBool isPrime = false.obs;
  RxInt firstNumber = 4.obs;
  RxInt secondNumber = 4.obs;
  Rx<Operation> operation = Operation.plus.obs;
  RxInt result = 8.obs;

  void calculateResult() {
    result.value = operation.value == Operation.plus
        ? firstNumber.value + secondNumber.value
        : firstNumber.value - secondNumber.value;
  }
}

class CurrentResultWidget extends StatelessWidget {
  final CustomAppBarController appBarController =
  Get.find<CustomAppBarController>();
  final GlobalKey widgetKey = GlobalKey();
  final NumberController controller = NumberController();

  NumberWidget({
    required int firstNumber,
    required int secondNumber,
    required Operation operation,
  }) {
    controller.firstNumber.value = firstNumber;
    controller.secondNumber.value = secondNumber;
    controller.operation.value = operation;
    controller.calculateResult();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      key: widgetKey,
      padding: EdgeInsets.only(top: MediaQuery.of(context).size.height * 0.01),
      child: GestureDetector(

        onTapDown: (_) {
          controller.isHolding.value = true;
        },
        onTapUp: (_) {
          controller.isHolding.value = false;
          // You can use this section to add further functionality if needed.
        },
        onPanUpdate: (details) {
          final RenderBox renderBox =
          widgetKey.currentContext!.findRenderObject() as RenderBox;
          final Offset localPosition =
          renderBox.globalToLocal(details.globalPosition);

          if (localPosition.dx < 0 ||
              localPosition.dx > renderBox.size.width ||
              localPosition.dy < 0 ||
              localPosition.dy > renderBox.size.height) {
            controller.isHolding.value = false;
          }
        },
        child: Obx(() => Container(
          width: MediaQuery.of(context).size.width * 0.45,
          height: MediaQuery.of(context).size.height * 0.07,
          decoration: BoxDecoration(
            color: controller.isHolding.value
                ? Colors.grey
                : (controller.isPrime.value
                ? Colors.green
                : AppConstants.appbarColor.withOpacity(0.0)),

          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Text(
                controller.firstNumber.value.toString(),
                style: TextStyle(
                  color: controller.isHolding.value
                      ? Colors.black
                      : Colors.white,
                  fontSize: MediaQuery.of(context).size.width * 0.06,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Container(
                decoration: BoxDecoration(
                    border: Border.all(color: Colors.white)
                ),
                padding: EdgeInsets.symmetric(horizontal: 10),
                child: Text(
                  controller.operation.value == Operation.plus
                      ? "?"
                      : "?",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: MediaQuery.of(context).size.width * 0.06,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              Text(
                controller.secondNumber.value.toString(),
                style: TextStyle(
                  color: controller.isHolding.value
                      ? Colors.black
                      : Colors.white,
                  fontSize: MediaQuery.of(context).size.width * 0.06,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                "=",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: MediaQuery.of(context).size.width * 0.06,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                controller.result.value.toString(),
                style: TextStyle(
                  color: controller.isHolding.value
                      ? Colors.black
                      : Colors.white,
                  fontSize: MediaQuery.of(context).size.width * 0.06,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        )),
      ),
    );
  }
}
