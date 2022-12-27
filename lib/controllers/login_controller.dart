import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../Helper/helper.dart';
import '../constants.dart';
import '../models/response_model.dart';
import '../models/user_model.dart';
import '../repository/auth_repo.dart';
import 'register_controller.dart';

class LoginController extends GetxController implements GetxService {
  final authRepo = Get.put(AuthRepo());
  final registerController = Get.put(RegisterController());
  final _pref = Get.find<SharedPreferences>();

  final TextEditingController emailController = TextEditingController();
  final TextEditingController passController = TextEditingController();

  final keyLogin = GlobalKey<FormState>();

  var user = User().obs;

  String? validateEmail(String email) {
    if (email.isEmpty) {
      return "Email không được để trống";
    } else if (!Helper.validateEmail(email)) {
      return "Email không đúng định dạng";
    }
    return null;
  }

  void saveUserInfo(String jsonUser) {
    _pref.setString("user", jsonUser);
  }

  String? validatePass(String value) {
    if (value.isEmpty) {
      return "Mật khẩu không được để trống";
    } else if (value.length < 6) {
      return "Mật khẩu quá ngắn";
    }
    return null;
  }

  Future<ResponseModel> login(
      {required String email, required String password}) async {
    try {
      final Response _res = await authRepo.login(email, password);
      // logger.i(_res.body);
      ResponseModel responseModel;
      if (_res.statusCode == 200 && _res.body["success"] == true) {
        responseModel = ResponseModel(
            isSuccess: true, message: "Success", data: _res.body["user"]);
        user(User.fromJson(responseModel.data));
        saveUserInfo(jsonEncode(user));
        _pref.setString('TOKEN', _res.body["token"]);
      } else {
        responseModel =
            ResponseModel(isSuccess: false, message: _res.body["message"]);
      }
      return responseModel;
    } catch (e) {
      return ResponseModel(
          isSuccess: false,
          message: "Không kết nối được với server! Vui lòng thử lại");
    }
  }
}
