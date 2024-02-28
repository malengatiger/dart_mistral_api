
import 'package:dio/dio.dart';

class DioUtil {
  final Dio dio;
  static const mm = '🥬🥬🥬🥬 DioUtil 🥬';

  DioUtil(this.dio);
  
  
  Future<dynamic> sendGetRequestWithHeaders(
      {required String path,
      required Map<String, dynamic> queryParameters,
      required dynamic headers}) async {

    print('$mm Dio sendGetRequestWithHeaders ...: 🍎🍎🍎 path: $path 🍎🍎');
    try {
      Response response;
      // The below request is the same as above.
      response = await dio.get(
        path,
        queryParameters: queryParameters,
        options: Options(headers: headers, responseType: ResponseType.json),
      );

      print('$mm Dio network response: 🥬🥬🥬🥬🥬🥬 status code: ${response.statusCode}');
      return response.data;
    } catch (e) {
      print('$mm Dio network response: 👿👿👿👿 ERROR: $e');
      print(e);
      rethrow;
    }
  }


  Future<dynamic> sendPostRequest({required String path, required dynamic body}) async {
    print('$mm Dio sendPostRequest ...: 🍎🍎🍎 path: $path 🍎🍎');
    try {
      Response response;
      response = await dio
          .post(
            path,
            data: body,
            options: Options(responseType: ResponseType.json),
            onReceiveProgress: (count, total) {
              print('$mm onReceiveProgress: count: $count total: $total');
            },
            onSendProgress: (count, total) {
              print('$mm onSendProgress: count: $count total: $total');
            },
          )
          .timeout(const Duration(seconds: 300))
          .catchError((error, stackTrace) {
            print('$mm Error occurred during the POST request: $error');
            throw Exception('Network problem encountered: $error');
          });
      print('$mm .... network POST response, 💚status code: ${response.statusCode} 💚💚');
      return response.data;
    } catch (e) {
      print('$mm .... network POST error response, '
          '👿👿👿👿 $e 👿👿👿👿');
      print(e);
      rethrow;
    }
  }
}
