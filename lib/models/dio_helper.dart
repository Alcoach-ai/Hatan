
import 'package:dio/dio.dart';

class DioHelper {
  static Dio? dio;

  static init() {
    dio = Dio(
      BaseOptions(
        followRedirects: false,
        validateStatus: (status) => true,
        baseUrl: "https://cloudeves.com/hatan/public/api/",
        receiveDataWhenStatusError: true,
        headers: {
          'Content-Type': 'application/json',
        },
      ),
    );
  }

  static Future<Response?> getData({
    required String url,
    required Map<String, dynamic> query,
  }) async {
    dio?.options.headers = {};
    return await dio?.get(
      url,
      queryParameters: query,
    );
  }

  static Future<Response?> postData({
    required String url,
    Map<String, dynamic>? query,
    required Map<String, dynamic> data,
  }) async {
    dio?.options.headers = {};

    return await dio?.post(
      url,
      queryParameters: query,
      data: data,
    );
  }
}
