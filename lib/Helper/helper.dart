import 'package:intl/intl.dart';

class Helper {
  static bool validateEmail(String input) {
    if (input.isEmpty) {
      return false;
    } else {
      String pattern =
          r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+";

      RegExp regExp = RegExp(pattern);
      return regExp.hasMatch(input);
    }
  }

  static bool validatePassword(String value) {
    if (value.isEmpty) {
      return false;
    } else {
      if (value.length < 6) {
        return false;
      } else {
        return true;
      }
    }
  }

  static String getDateTime(x) {
    DateTime y = DateTime.parse(x);
    final DateFormat formatter = DateFormat('dd-MM-yyyy');
    final String formatted = formatter.format(y);
    return formatted;
  }
}
