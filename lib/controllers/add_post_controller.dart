import 'package:flutter/widgets.dart';
import 'package:do_an/components/custom_loading.dart';
import 'package:do_an/constants.dart';
import 'package:do_an/repository/home_repo.dart';
import 'package:get/get.dart';

import '../api/api_client.dart';
import '../models/response_model.dart';

class PostControlelr extends GetxController {
  final TextEditingController titleTextEditingController =
      TextEditingController();
  final TextEditingController contentTextEditingController =
      TextEditingController();
  final formKey = GlobalKey<FormState>();

  final ApiClient apiClient = ApiClient();
  final homeRepo = Get.put(HomeRepo());

  String? validateTitle(String title) {
    if (title.isEmpty) {
      return "Tiêu đề không được để trống";
    }
    return null;
  }

  String? validateContent(String content) {
    if (content.isEmpty) {
      return "Nội dung không được để trống";
    } else if (content.length < 10) {
      return "Nội dung quá ngắn để phân loại bài viết";
    }
    return null;
  }

  Future<ResponseModel> addPost({required String content}) async {
    try {
      showLoadingOverlay();
      final response = await homeRepo.addPost(content);
      logger.e(response.body);
      final ResponseModel _res;
      if (response.statusCode == 200 && response.body['success']) {
        _res = ResponseModel(
            isSuccess: true,
            message: 'success',
            data: response.body["category"][0]);
      } else {
        _res = ResponseModel(
          isSuccess: false,
          message: 'false',
        );
      }
      hideLoadingOverlay();
      return _res;
    } catch (e) {
      hideLoadingOverlay();
      return ResponseModel(
          isSuccess: false,
          message: "Không kết nối được với server! Vui lòng thử lại");
    }
  }
}
