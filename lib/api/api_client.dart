import 'dart:convert';

import 'package:flutter/foundation.dart' as foundation;
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

import '../constants.dart';

class ApiClient extends GetxService {
  late String token;
  late Map<String, String> _mainHeaders;
  final int timeoutInSeconds = 60;
  final String invalidToken = 'Invalid token specified! Please login again!';
  final String noInternetMessage =
      'Connection to API server failed due to internet connection';

  ApiClient() {
    _mainHeaders = {
      'Content-Type': 'application/json; charset=UTF-8',
    };
  }

  Future<Response> getData(
    String? otherURL,
    String uri, {
    Map<String, dynamic>? query,
    Map<String, String>? headers,
    bool useTestHeader = false,
  }) async {
    try {
      if (foundation.kDebugMode) {
        // logger.d('$otherURL$uri');
      }
      http.Response _response = await http
          .get(
            Uri.parse(otherURL! + uri),
            headers: headers ?? _mainHeaders,
          )
          .timeout(Duration(seconds: timeoutInSeconds));
      dynamic _body = jsonDecode(_response.body);
      Response response = Response(
        body: _body ?? _response.body,
        bodyString: _response.body.toString(),
        headers: _response.headers,
        statusCode: _response.statusCode,
        statusText: _response.reasonPhrase,
      );
      if (foundation.kDebugMode) {
        logger.i('[${response.statusCode}] $uri\n\n${response.body}');
      }
      return response;
    } catch (e) {
      return Response(statusCode: 1, statusText: noInternetMessage);
    }
  }

  Future<Response> postData(
    String? otherURL,
    String uri,
    dynamic body, {
    Map<String, String>? headers,
    bool useTestHeader = false,
  }) async {
    try {
      final String url = otherURL! + uri;
      if (foundation.kDebugMode) {
        // logger.d(body);
      }
      http.Response _response = await http
          .post(
            Uri.parse(url),
            body: jsonEncode(body),
            headers: headers ?? _mainHeaders,
          )
          .timeout(Duration(seconds: timeoutInSeconds));

      dynamic _body = jsonDecode(_response.body);
      Response response = Response(
        body: _body ?? _response.body,
        bodyString: _response.body.toString(),
        headers: _response.headers,
        statusCode: _response.statusCode,
        statusText: _response.reasonPhrase,
      );
      if (foundation.kDebugMode) {
        logger.i('[${response.statusCode}] $uri\n\n${response.body}');
      }
      return response;
    } catch (e) {
      return Response(statusCode: 1, statusText: noInternetMessage);
    }
  }
}
