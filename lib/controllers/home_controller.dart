import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../constants.dart';
import '../models/category.dart';
import '../models/post.dart';
import '../models/response_model.dart';
import '../models/user_model.dart';
import '../repository/home_repo.dart';

class HomeController extends GetxController with GetTickerProviderStateMixin {
  final homeRepo = Get.put(HomeRepo());

  late User user;
  final _pref = Get.find<SharedPreferences>();
  late TabController tabController;

  var listCategories = <Category>[].obs;
  var listPost = <PostModel>[].obs;

  var indexPost = 0.obs;

  @override
  void onInit() {
    // tabController = TabController(length: 10, vsync: this);
    String? jsonUser = _pref.getString("user");
    user = User.fromJson(jsonDecode(jsonUser ?? ""));
    super.onInit();
  }

  void changeIndex(value) {
    indexPost(value);
  }

  Future<ResponseModel> getCategories() async {
    try {
      final Response response = await homeRepo.getCategory();

      await getPosts("1");
      final ResponseModel res;
      if (response.statusCode == 200 && response.body['success']) {
        res = ResponseModel(
            isSuccess: true, message: "Success", data: response.body);
        tabController = TabController(
            length: response.body['categories'].length, vsync: this);
        for (var item in response.body['categories']) {
          listCategories.add(Category.fromJson(item));
        }
        // logger.e(response.body['categories']);
      } else {
        res = ResponseModel(isSuccess: false, message: 'False');
      }
      return res;
    } catch (e) {
      return ResponseModel(
          isSuccess: false,
          message: "Không kết nối được với server! Vui lòng thử lại");
    }
  }

  Future<ResponseModel> getPosts(String categoryId) async {
    try {
      final Response response = await homeRepo.getPost(categoryId);
      final ResponseModel res;
      if (response.statusCode == 200 && response.body['success']) {
        res = ResponseModel(
            isSuccess: true, message: "Success", data: response.body);
        final listTemp = <PostModel>[];
        listPost([]);
        for (var item in response.body['data']['data']) {
          listTemp.add(PostModel.fromJson(item));
        }
        listPost(listTemp);
        logger.d(listPost.length);
      } else {
        res = ResponseModel(isSuccess: false, message: 'False');
      }
      // update();
      return res;
    } catch (e) {
      return ResponseModel(
          isSuccess: false,
          message: "Không kết nối được với server! Vui lòng thử lại");
    }
  }
}
