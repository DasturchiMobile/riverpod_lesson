import 'dart:convert';
import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:riverpod_lesson_one/config/network/status_model.dart';

import '../service/secure_data.dart';

//https://newsapi.org/v2/everything?q=tesla&from=2024-07-19&sortBy=publishedAt&apiKey=2996abecbbfd43e2850857ecbae60ff3
class ApiClient {
  final baseUrl = "https://newsapi.org/v2/";
  Dio dio = Dio();
  static Future<Map<String, dynamic>> defaultHeader() async {
    String token = await SecureStorage().read(key: 'token') ?? "";
    return {
      'Authorization': 'Bearer $token',
      'Accept': 'application/json, text/plain',
    };
  }

  Future<StatusModel> postMethod({required String pathUrl,required Map<String, dynamic> body, dynamic header, required isHeader})async {
    try {
      final res = await dio.post("$baseUrl$pathUrl",
        options: Options(headers:isHeader?  await defaultHeader() : {"Content_type" : "application/json"},),
        data: jsonEncode(body),
      ).timeout(const Duration(seconds: 30));
      log(
        "postMethod pathUrl: $baseUrl$pathUrl"
            "\n\n"
            "header: ${await defaultHeader()}"
            "\n\n"
            "body: $body"
            "\n\n"
            "code: ${res.statusCode}",
      );
      log("response: ${res.data}");
      if(res.statusCode! >= 200 && res.statusCode! < 300){
        return StatusModel(response: res.data, isSuccess: true, code: res.statusCode);
      }
      throw res.data["message"];
    } on DioError catch(e ) {
      log(
        "postMethod pathUrl: $baseUrl$pathUrl"
            "\n\n"
            "header: ${await defaultHeader()}"
            "\n\n"
            "body: $body"
            "\n\n"
            "code: ${e.response?.statusCode}"
            "\n\n"
            "response: ${e.response?.data}",
      );
      return dioError(e);
    }
  }


  Future<StatusModel> getMethod({required pathUrl, Map<String, dynamic>? header,Map<String, dynamic>?  body, required isHeader, bool anotherLink = false})async {
    try {
      final res = await dio
          .get("${anotherLink ? "" : baseUrl}$pathUrl",
        options: Options(headers:isHeader?  await defaultHeader() : {"Content_type" : "application/json"}),
        data: jsonEncode(body ?? {}),
      ).timeout(const Duration(seconds: 30));
      log(
          "getMethod pathUrl: $baseUrl$pathUrl"
              "\n\n"
              "header: ${await defaultHeader()}"
              "\n\n"
              "body: $body"
              "\n\n"
              "code: ${res.statusCode}"
              "\n\n"
      );
      log("response: ${res.data}");
      if(res.statusCode! >= 200 && res.statusCode! < 300){
        return StatusModel(response: res.data, isSuccess: true, code: res.statusCode);
      }
      throw res.data["message"];
    } on DioError catch(e) {
      log(
        "getMethod pathUrl: $baseUrl$pathUrl"
            "\n\n"
            "header: ${await defaultHeader()}"
            "\n\n"
            "body: $body"
            "\n\n"
            "code: ${e.response?.statusCode}"
            "\n\n"
            "response: ${e.response?.data}",
      );
      return dioError(e);
    }
  }

  Future<StatusModel> putMethod({required pathUrl,required dynamic body, dynamic header, required isHeader})async {
    try {
      final res = await dio.put("$baseUrl$pathUrl",
        options: Options(headers: isHeader ? await defaultHeader() : {"Content_type": "application/json"}),
        data: jsonEncode(body),
      ).timeout(const Duration(seconds: 30));
      log(
          "putMethod pathUrl: $baseUrl$pathUrl"
              "\n\n"
              "header: ${await defaultHeader()}"
              "\n\n"
              "body: $body"
              "\n\n"
              "code: ${res.statusCode}"
              "\n\n"
      );
      log("response: ${res.data}");
      if (res.statusCode == 200) {
        return StatusModel(response: res.data, isSuccess: true, code: 200);
      }
      throw res.data["message"];
    } on DioError catch (e) {
      log(
        "putMethod pathUrl: $baseUrl$pathUrl"
            "\n\n"
            "header: ${await defaultHeader()}"
            "\n\n"
            "body: $body"
            "\n\n"
            "code: ${e.response?.statusCode}"
            "\n\n"
            "response: ${e.response?.data}",
      );
      return dioError(e);
    }
  }

  Future<StatusModel> patchMethod({required String pathUrl,required Map<String, dynamic> body, dynamic header, required isHeader})async {
    try {
      final res = await dio.patch("$baseUrl$pathUrl",
        options: Options(headers:isHeader?  await defaultHeader() : {"Content_type" : "application/json"},),
        data: jsonEncode(body),
      ).timeout(const Duration(seconds: 30));
      log(
          "patchMethod pathUrl: $baseUrl$pathUrl"
              "\n\n"
              "header: ${await defaultHeader()}"
              "\n\n"
              "body: $body"
              "\n\n"
              "code: ${res.statusCode}"
              "\n\n"
      );
      log("response: ${res.data}");
      if(res.statusCode! >= 200 && res.statusCode! < 300){
        return StatusModel(response: res.data, isSuccess: true, code: res.statusCode);
      }
      throw res.data["message"];
    } on DioError catch(e ) {
      log(
        "postMethod pathUrl: $baseUrl$pathUrl"
            "\n\n"
            "header: ${await defaultHeader()}"
            "\n\n"
            "body: $body"
            "\n\n"
            "code: ${e.response?.statusCode}"
            "\n\n"
            "response: ${e.response?.data}",
      );
      return dioError(e);
    }
  }

  Future<StatusModel> deleteMethod({required String pathUrl, dynamic header, required isHeader, Map<String, dynamic>? body})async {
    try {
      final res = await dio.delete("$baseUrl$pathUrl",
          options: Options(headers:isHeader?  await defaultHeader() : {"Content_type" : "application/json"}),
          data: jsonEncode(body ?? {})
      ).timeout(const Duration(seconds: 30));
      log(
          "deleteMethod pathUrl: $baseUrl$pathUrl"
              "\n\n"
              "header: ${await defaultHeader()}"
              "\n\n"
              "body: $body"
              "\n\n"
              "code: ${res.statusCode}"
              "\n\n"
      );
      log("response: ${res.data}");
      if(res.statusCode == 200){
        return StatusModel(response: res.data, isSuccess: true, code: 200);
      }
      throw "unknownError";
    } on DioError catch(e) {
      log(
        "deleteMethod pathUrl: $baseUrl$pathUrl"
            "\n\n"
            "header: ${await defaultHeader()}"
            "\n\n"
            "body: $body"
            "\n\n"
            "code: ${e.response?.statusCode}"
            "\n\n"
            "response: ${e.response?.data}",
      );
      return dioError(e);
    }
  }
}

StatusModel dioError(DioException e){
  if(e.type == DioExceptionType.connectionTimeout){
    throw "internet bilan muamo";
  }
  if(e.type == DioExceptionType.connectionError){
    throw "internet bilan muamo";
  }
  try{
    if(e.response!.statusCode! >= 500){
      throw "server bilan ulanib bo'lmadi";
    }
  }catch(e){}
  throw "nimadir xato ketdi bilolmadim";
}