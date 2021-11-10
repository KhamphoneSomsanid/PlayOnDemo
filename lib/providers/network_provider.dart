import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:mobile/providers/dialog_provider.dart';

class NetworkProvider {
  final BuildContext context;

  NetworkProvider(this.context);

  static NetworkProvider of(BuildContext context) {
    return NetworkProvider(context);
  }

  Future<Map<String, dynamic>> post(
      String header, String link, Map<String, dynamic> parameter,
      {bool isProgress = false}) async {
    if (isProgress && context != null) DialogProvider.of(context).showLoading();

    var url = Uri.parse('$header/$link');

    _httpRequestLog(url, parameter);

    final response = await http.get(
      url,
    );
    if (isProgress && context != null) DialogProvider.of(context).hideLoading();

    if (response == null) {
      _httpResponseLog(url, parameter, 'No internet connection');
      return null;
    }

    if (response.statusCode == 201 || response.statusCode == 200) {
      try {
        var json = jsonDecode(response.body);
        return json;
      } catch (e) {
        _httpResponseLog(url, parameter, 'Json decode issue');
        return null;
      }
    } else {
      _httpResponseLog(url, parameter, response.statusCode.toString());
      return null;
    }
  }

  void _httpRequestLog(Uri url, dynamic param) {
    print("""
    |------------------------------------------------------------------ 
    |  link : ${url.toString()}
    |  parameter : $param
    |------------------------------------------------------------------
    """);
  }

  void _httpResponseLog(Uri url, dynamic parameter, dynamic response) {
    print("""
    |------------------------------------------------------------------ 
    |  link : ${url.toString()}
    |  response : $response
    |------------------------------------------------------------------
    """);
  }
}