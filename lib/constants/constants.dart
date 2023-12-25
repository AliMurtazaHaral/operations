import 'package:flutter/material.dart';

import '../widgets/customAppBar.dart';


class AppConstants {
  // Colors
  static const correctColor = const Color(0xFF3AAA6A);
  static const wrongColor = const Color(0xFFD21B67);
  static const appbarColor = const Color(0xFF131965);

  // Strings
  static const appName = "My Flutter App";

  static bool isPrime(String n) {
    if (n == "*" || n == "/") {
      return false;
    }
    return true;
  }

  static void showAnimatedText(
      BuildContext context,
      CustomAppBarController appBarController,
      Offset startingPosition,
      Offset endingPosition) {
    OverlayEntry overlayEntry;

    overlayEntry = OverlayEntry(
      builder: (context) => Positioned(
        top: startingPosition.dy,
        left: startingPosition.dx,
        child: TweenAnimationBuilder(
          tween: Tween<double>(begin: 0.0, end: 1.0),
          duration: Duration(seconds: 1),
          builder: (context, double value, child) {
            return Opacity(
              opacity: value,
              child: Transform.translate(
                offset: Offset(
                  (endingPosition.dx - startingPosition.dx) * value,
                  (endingPosition.dy - startingPosition.dy) * value,
                ),
                child: Text(
                  "1",
                  style: TextStyle(
                    color: Colors.green,
                    fontSize: 20.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );

    Overlay.of(context)?.insert(overlayEntry);

    // Delay for some time before removing the overlay
    Future.delayed(Duration(seconds: 1), () {
      appBarController.correctPoints += 1;
      overlayEntry.remove();
    });
  }
  static void showAnimatedTextFalse(
      BuildContext context,
      CustomAppBarController appBarController,
      Offset startingPosition,
      Offset endingPosition) {
    OverlayEntry overlayEntry;

    overlayEntry = OverlayEntry(
      builder: (context) => Positioned(
        top: startingPosition.dy,
        left: startingPosition.dx,
        child: TweenAnimationBuilder(
          tween: Tween<double>(begin: 0.0, end: 0.9),
          duration: Duration(seconds: 1),
          builder: (context, double value, child) {
            return Opacity(
              opacity: value,
              child: Transform.translate(
                offset: Offset(
                  (endingPosition.dx - startingPosition.dx) * value,
                  (endingPosition.dy - startingPosition.dy) * value,
                ),
                child: Text(
                  "1",
                  style: TextStyle(
                    color: Colors.red,
                    fontSize: 20.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );

    Overlay.of(context)?.insert(overlayEntry);

    // Delay for some time before removing the overlay
    Future.delayed(Duration(seconds: 1), () {
      appBarController.wrongPoints += 1;
      overlayEntry.remove();
    });
  }
}
