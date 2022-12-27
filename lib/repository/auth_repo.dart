import 'package:do_an/api/api_client.dart';
import 'package:do_an/constants.dart';
import 'package:get/get_connect.dart';

class AuthRepo {
  final ApiClient apiClient = ApiClient();

  Future<Response> login(String email, String password) async {
    return await apiClient.postData(ApiContants.URL, ApiContants.LOGIN,
        {"email": email, "password": password});
  }

  Future<Response> register(
      String name, String email, String password, int age) async {
    return await apiClient.postData(ApiContants.URL, ApiContants.REGISTER,
        {"email": email, "password": password, "name": name, "age": age});
  }
}
