import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../api/api_client.dart';
import '../constants.dart';

class HomeRepo {
  final ApiClient apiClient = ApiClient();
  final _pref = Get.find<SharedPreferences>();
  late String token;

  Future<Response> getCategory() async {
    token = _pref.getString('TOKEN') ?? "";
    final Response res;
    res = await apiClient.getData(ApiContants.URL, ApiContants.CATEGORY,
        headers: {
          'Content-Type': 'application/json',
          "Authorization": "Bearer $token"
        });
    return res;
  }

  Future<Response> getPost(String categoryId) async {
    token = _pref.getString('TOKEN') ?? "";
    final Response res;
    res = await apiClient.getData(
        ApiContants.URL, "${ApiContants.POST}?category_id=$categoryId",
        headers: {
          'Content-Type': 'application/json',
          "Authorization": "Bearer $token"
        });
    return res;
  }

  Future<Response> addPost(String content) async {
    token = _pref.getString('TOKEN') ?? "";
    final Response res;
    res = await apiClient.postData(ApiContants.URL, ApiContants.POST, {
      "content": content
    }, headers: {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      "Authorization": "Bearer $token"
    });
    logger.d(res.body);
    return res;
  }
}
