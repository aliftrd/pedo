import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:pedo/utils/secure_storage_service.dart';

class Network {
  final String baseUrl = "https://petadoption.my.id/api/";
  Map<String, String> headers = {
    'Content-Type': 'application/json',
    'Accept': 'application/json',
  };

  Future get({
    required String url,
    Map<String, String>? params,
    Map<String, String>? header,
    bool useToken = true,
  }) async {
    String sendUrl = baseUrl + url;
    List<String> keys = [];
    if (params != null) {
      for (var mapEntry in params.entries) {
        final key = mapEntry.key, value = mapEntry.value;
        keys.add("$key=$value");
      }
      String parameter = keys.join('&').toString();
      sendUrl = "$sendUrl?$parameter";
    }

    Map<String, String> sendHeader = {};
    if (header != null) {
      for (final mapEntry in header.entries) {
        final key = mapEntry.key, value = mapEntry.value;
        headers[key] = value;
      }
    }

    String authToken = await SecureStorageService.getToken();
    if (authToken.toString().isNotEmpty && useToken) {
      headers['Authorization'] = "Bearer $authToken";
    }
    headers.addAll(sendHeader);
    http.Response response = await http.get(
      Uri.parse(sendUrl),
      headers: headers,
    );

    return jsonDecode(response.body);
  }

  Future post({
    required String url,
    Map<String, String>? params,
    Map<String, String>? header,
    Map<String, dynamic>? body,
    bool useToken = true,
  }) async {
    String sendUrl = baseUrl + url;
    List<String> keys = [];
    if (params != null) {
      for (var mapEntry in params.entries) {
        final key = mapEntry.key, value = mapEntry.value;
        keys.add("$key=$value");
      }
      String parameter = keys.join('&').toString();
      sendUrl = "$sendUrl?$parameter";
    }

    Map<String, String> sendHeader = {};
    if (header != null) {
      for (final mapEntry in header.entries) {
        final key = mapEntry.key, value = mapEntry.value;
        headers[key] = value;
      }
    }

    String authToken = await SecureStorageService.getToken();
    if (authToken.toString().isNotEmpty && useToken) {
      headers['Authorization'] = "Bearer $authToken";
    }
    headers.addAll(sendHeader);

    final sendBody = jsonEncode(body);

    http.Response response = await http.post(
      Uri.parse(sendUrl),
      headers: headers,
      body: sendBody,
    );

    debugPrint(response.body);
    return jsonDecode(response.body);
  }
}
