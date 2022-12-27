import 'package:flutter/material.dart';
import 'package:logger/logger.dart';

const kPrimaryColor = Color(0xFF6F35A5);
const kPrimaryLightColor = Color(0xFFF1E6FF);

const double defaultPadding = 16.0;

final logger = Logger(printer: PrettyPrinter(colors: false));

extension EmailValidator on String {
  bool isValidEmail() {
    return RegExp(
            r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$')
        .hasMatch(this);
  }
}

/// api////

class ApiContants {
  static const String URL = 'http://localhost:8000/api';
  static const String LOGIN = '/login';
  static const String REGISTER = '/register';
  static const String CATEGORY = '/category';
  static const String POST = '/post';
}
