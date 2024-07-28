import 'dart:async';
import 'package:dio/dio.dart';

class APIService {
  final dio = Dio();
  final baseURL = 'https://freetestapi.com/api/v1/';
  Future<dynamic> fetch(String url) async {
    final String endpoint = '$baseURL/$url';
    print(endpoint);
    try {
      final response = await dio.get(endpoint);
      if (response.statusCode == 200) {
        return response.data;
      } else {
        throw Exception('Failed to load');
      }
    } catch (e) {
      print('Error fetching: $e');
    }
  }
}
