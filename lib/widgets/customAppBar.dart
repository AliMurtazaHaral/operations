import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../constants/constants.dart';
import 'circularTimer.dart';

class CustomAppBarController extends GetxController {
  var correctPoints = 0.obs;
  var wrongPoints = 0.obs;
  var timerSeconds = 30.obs;
  late Timer timer;

  @override
  void onInit() {
    super.onInit();
    startTimer();
  }

  void startTimer() {
    timer = Timer.periodic(Duration(seconds: 1), (timer) {
      if (timerSeconds.value > 0) {
        timerSeconds--;
      } else {
        timer.cancel();
      }
    });
  }

  @override
  void onClose() {
    timer.cancel();
    super.onClose();
  }
}

class CustomAppBar extends StatelessWidget {
  final CustomAppBarController controller = Get.put(CustomAppBarController());

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(40),
          bottomRight: Radius.circular(40),
        ),
        color: AppConstants.appbarColor.withOpacity(0.8),
      ),
      height: MediaQuery.of(context).size.height * 0.18,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(width: MediaQuery.of(context).size.width * 0.04),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "ROUND",
                style: TextStyle(
                  fontSize: MediaQuery.of(context).size.width * 0.05,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              Text(
                "1 of 5",
                style: TextStyle(
                  fontSize: MediaQuery.of(context).size.width * 0.05,
                  color: Colors.white,
                ),
              ),
            ],
          ),
          SizedBox(width: MediaQuery.of(context).size.width * 0.12),
          Flexible(
            child: Stack(
              children: [
                Container(
                  height: MediaQuery.of(context).size.width * 0.15,
                  width: MediaQuery.of(context).size.width * 0.15,
                  child: CircularTimer(
                    timer: controller.timerSeconds.value,
                  ),
                ),
                Positioned.fill(
                  child: Center(
                    child: Obx(
                      () => Visibility(
                        visible: controller.timerSeconds.value > 0,
                        child: Text(
                          "${controller.timerSeconds}",
                          style: TextStyle(
                            fontSize: MediaQuery.of(context).size.width * 0.07,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          SizedBox(width: MediaQuery.of(context).size.width * 0.1),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Row(
                children: [
                  Container(
                    width: MediaQuery.sizeOf(context).width * 0.27,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.horizontal(
                        left: Radius.circular(
                            MediaQuery.of(context).size.width * 0.05),
                        right: Radius.circular(
                            MediaQuery.of(context).size.width * 0.05),
                      ),
                    ),
                    child: Padding(
                      padding: EdgeInsets.only(
                        top: MediaQuery.of(context).size.height * 0.005,
                        bottom: MediaQuery.of(context).size.height * 0.005,
                        right: MediaQuery.of(context).size.width * 0.02,
                      ),
                      child: Row(
                        children: [
                          Image.asset(
                            "assets/images/correct_answer_image.jpeg",
                            height: MediaQuery.of(context).size.width * 0.065,
                            width: MediaQuery.of(context).size.width * 0.12,
                          ),
                          Obx(() => Opacity(
                                opacity:
                                    controller.correctPoints > 0 ? 1.0 : 0.0,
                                child: Text(
                                  "${controller.correctPoints}/15",
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize:
                                        MediaQuery.of(context).size.width *
                                            0.04,
                                  ),
                                ),
                              )),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: MediaQuery.of(context).size.height * 0.003),
              Row(
                children: [
                  Container(
                    width: MediaQuery.sizeOf(context).width * 0.27,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.horizontal(
                        left: Radius.circular(
                            MediaQuery.of(context).size.width * 0.05),
                        right: Radius.circular(
                            MediaQuery.of(context).size.width * 0.05),
                      ),
                    ),
                    child: Padding(
                      padding: EdgeInsets.only(
                        top: MediaQuery.of(context).size.height * 0.005,
                        bottom: MediaQuery.of(context).size.height * 0.005,
                        right: MediaQuery.of(context).size.width * 0.02,
                      ),
                      child: Row(
                        children: [
                          Image.asset(
                            "assets/images/wrong_answer_image.jpeg",
                            height: MediaQuery.of(context).size.width * 0.065,
                            width: MediaQuery.of(context).size.width * 0.12,
                          ),
                          Obx(() => Visibility(
                                visible: controller.wrongPoints > 0,
                                child: Text(
                                  "${controller.wrongPoints}/10",
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize:
                                        MediaQuery.of(context).size.width *
                                            0.04,
                                  ),
                                ),
                              )),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}
