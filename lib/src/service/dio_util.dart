import 'package:dio/dio.dart';

class DioUtil {
  final Dio dio;
  static const mm = '🍎🍎 DioUtil - Network Utility 🍎🍎';

  DioUtil(this.dio);

  Future<dynamic> sendGetRequestWithHeaders(
      {required String path,
      required Map<String, dynamic> queryParameters,
      required dynamic headers, bool? debug = false}) async {
    if (debug!) {
      print('$mm Dio sendGetRequestWithHeaders '
          '...: 🍎🍎🍎 path: $path 🍎🍎');
      print('$mm Dio sendGetRequestWithHeaders '
          '...: 🍎🍎🍎 queryParameters: $queryParameters 🍎🍎');
      print('$mm Dio sendGetRequestWithHeaders '
          '...: 🍎🍎🍎 headers: $headers 🍎🍎');
    }

    try {
      Response response;
      response = await dio.get(
        path,
        queryParameters: queryParameters,
        options: Options(headers: headers, responseType: ResponseType.json),
      );

      if (debug) {
        print(
            '$mm Dio network response: 🥬🥬🥬🥬🥬🥬 '
                'status code: ${response.statusCode}');
        print(
            '$mm Dio network response: 🥬🥬🥬🥬🥬🥬 '
                ' data: ${response.data}');
      }
      return response.data;
    } catch (e,s) {
      print('$mm Dio network response: 👿👿👿👿 ERROR: $e $s');
      print(e);
      rethrow;
    }
  }

  Future<dynamic> sendPostRequest(
      {required String path,
      required dynamic body,
      required dynamic headers, bool? debug = false}) async {
    if (debug!) {
      print('$mm Dio sendPostRequest ...: 🍎🍎🍎 path: $path 🍎🍎');
      print('$mm Dio sendPostRequest ...: 🍎🍎🍎 body: $body 🍎🍎');
      print('$mm Dio sendPostRequest ...: 🍎🍎🍎 headers: $headers 🍎🍎');

    }
    try {
      Response response;
      response = await dio.post(
        path,
        data: body,
        options: Options(headers: headers, responseType: ResponseType.json),
        onReceiveProgress: (count, total) {
          print('$mm onReceiveProgress: count: $count total: $total');
        },
        onSendProgress: (count, total) {
          print('$mm onSendProgress: count: $count total: $total');
        },
      ).timeout(const Duration(seconds: 300));

      if (debug) {
        print(
            '$mm .... network POST response, 💚status code: ${response.statusCode} 💚💚');
        print(
            '$mm .... network POST response,  data: ${response.data} 💚💚');
      }
      return response.data;
    } catch (e, s) {
      print('$mm .... network POST error response, '
          '👿👿👿👿 $e - $s 👿👿👿👿');
      print(e);
      rethrow;
    }
  }
}
