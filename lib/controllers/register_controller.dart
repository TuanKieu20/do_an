import 'package:flutter/material.dart';
import 'package:do_an/models/response_model.dart';
import 'package:do_an/repository/auth_repo.dart';
import 'package:get/get.dart';

import '../Helper/helper.dart';
import '../constants.dart';

class RegisterController extends GetxController implements GetxService {
  final AuthRepo authRepo = AuthRepo();

  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passController = TextEditingController();
  var age = ''.obs;

  final keySignUp = GlobalKey<FormState>();

  void changeAge(String value) {
    age(value);
  }

  String? validateName(String value) {
    if (value.isEmpty) {
      return 'Tên không được để trống!';
    } else if (value.length < 6) {
      return 'Tên quá ngắn!';
    }
    return null;
  }

  String? validateEmail(String email) {
    if (email.isEmpty) {
      return "Email không được để trống";
    } else if (!Helper.validateEmail(email)) {
      return "Email không đúng định dạng";
    }
    return null;
  }

  String? validatePass(String value) {
    if (value.isEmpty) {
      return "Mật khẩu không được để trống";
    } else if (value.length < 6) {
      return "Mật khẩu quá ngắn";
    }
    return null;
  }

  Future<ResponseModel> signUp(
      {required String email,
      required String password,
      required String name,
      required int age}) async {
    try {
      final Response response =
          await authRepo.register(name, email, password, age);
      logger.e(response.body.toString());
      final ResponseModel res;
      if (response.statusCode == 200 && response.body['success'] == true) {
        res = ResponseModel(isSuccess: true, message: 'Success');
      } else {
        res =
            ResponseModel(isSuccess: false, message: response.body['message']);
      }
      return res;
    } catch (e) {
      return ResponseModel(
          isSuccess: false,
          message: "Không kết nối được với server! Vui lòng thử lại");
    }
  }
}
