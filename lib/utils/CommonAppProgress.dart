import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:lottie/lottie.dart';

Widget getCommonProgressBarFullScreen() {
  return Scaffold(
    body: Container(
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage("images/bg.jpg"),
          fit: BoxFit.cover,
        ),
      ),
      child: Align(
        alignment: Alignment.topCenter,
        child: SizedBox(
          width: 150, // Use the available width
          height: 150, // Make height equal to width (square)
          child: Lottie.asset(
            'assets/happy_load.json', // Replace with your Lottie asset path
            fit: BoxFit.contain,
            // Or any other BoxFit as needed.  contain is usually best
            repeat: true,
          ),
        ),
      ),
    ),
  );
}

Widget getCommonProgressBar() {
  return Align(
    alignment: Alignment.topCenter,
    child: SizedBox(
      width: 150, // Use the available width
      height: 150, // Make height equal to width (square)
      child: Lottie.asset(
        'assets/happy_load.json', // Replace with your Lottie asset path
        fit: BoxFit.contain,
        // Or any other BoxFit as needed.  contain is usually best
        repeat: true,
      ),
    ),
  );
}

String getTwoDecimalPrice(double doublePrice) {
  String twoDecimalPrice = "";
  final NumberFormat formatter = NumberFormat("#.00");
  if (doublePrice > 0) {
    twoDecimalPrice = formatter.format(doublePrice);
    return twoDecimalPrice;
  } else if (doublePrice == 0) {
    return "0.00";
  }
  return "";
}

void showSnackbar(BuildContext context, String s) {
  hideKeyboard(context);
  var snackBar = SnackBar(
    duration: const Duration(milliseconds: 1500),
    backgroundColor: Color.fromARGB(255, 123, 138, 195),
    content: Text(
      s,
      style: TextStyle(
        fontSize: 14.0,
        fontFamily: "Montserrat",
        fontWeight: FontWeight.w600,
        color: Colors.white,
      ),
    ),
  );
  ScaffoldMessenger.of(context).showSnackBar(snackBar);
}

// Function to hide the keyboard
void hideKeyboard(BuildContext context) {
  // 1. Using FocusNode (Preferred)
  FocusScopeNode currentFocus = FocusScope.of(context);
  if (!currentFocus.hasPrimaryFocus && currentFocus.hasFocus) {
    FocusManager.instance.primaryFocus?.unfocus();
  }

  // 2. Using SystemChannels (Fallback - Less Preferred)
  // This method is less preferred because it's more of a direct,
  // platform-level approach and might have side effects.  The
  // FocusNode method is generally better within the Flutter framework.
  //
  // Check the platform before using this, although it generally works on both.
  // Removed the check, as the method works on both iOS and Android and the check was causing an issue.
  SystemChannels.textInput.invokeMethod('TextInput.hide');
}
