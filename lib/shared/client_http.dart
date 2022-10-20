// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:dio/dio.dart';

abstract class ClientHttp {
  Future<Response>? post(String url, {Map data});
  Future<Response>? get(String url);
}

class Response {
  Map<String, dynamic>? data;
  int? statusCode;
  Response({
    this.data,
    this.statusCode,
  });
}

// Desacopla framework dio
class DioClientHttp implements ClientHttp {
  final dio = Dio();

  @override
  Future<Response>? post(String url, {Map? data}) async {
    final response = await dio.post(url, data: data);
    return Response(
        data: jsonDecode(response.data), statusCode: response.statusCode);
  }

  @override
  Future<Response>? get(String url) async {
    final response = await dio.post(url);
    if (response.data != null) {
      return Response(
          data: jsonDecode(response.data), statusCode: response.statusCode);
    } else {
      return Response(data: null, statusCode: response.statusCode);
      ;
    }
  }
}
