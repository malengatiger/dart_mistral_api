import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:mistral_sgela_ai/src/mistral_constants.dart';

import '../../mistral_sgela_ai.dart';

/// MaterialService is the main class for the package.
/// It provides the implementation of all the Mistral AI endpoints
class MistralService {
  /*
  💜💜 Mistral AI provides five API endpoints for its five Large Language Models
*/

  final DioUtil dioUtil = DioUtil(Dio());

  final String apiKey;
  static const _mistralUrl = 'https://api.mistral.ai/v1/chat/completions';
  static const _embeddingUrl = 'https://api.mistral.ai/v1/embeddings';
  static const _mistralModelUrl = 'https://api.mistral.ai/v1/models';

  MistralService(this.apiKey);

  static const mm = '🍐🍐MistralService 🍐';

  init() {}

  var headers = {
    'Content-Type': 'application/json',
  };

  static void prettyPrintJson(Map<String, dynamic> json) {
    JsonEncoder encoder = JsonEncoder.withIndent('  ');
    String prettyPrintedJson = encoder.convert(json);
    print(prettyPrintedJson);
  }

  /// List all the available Mistral models
  Future<List<MistralModel>> listModels({bool? debug}) async {
    List<MistralModel> mList = [];
    headers['Authorization'] = 'Bearer $apiKey';

    if (debug != null) {
      if ((debug)) {
        print('$mm ... sending list query for 🍎 Mistral models ...');
      }
    }
    try {
      Response res = await dioUtil.sendGetRequestWithHeaders(
          path: _mistralModelUrl, queryParameters: {}, headers: headers, debug: debug);

      if (res.statusCode == 200 || res.statusCode == 201) {
        List jList = res.data;
        for (var value in jList) {
          mList.add(MistralModel.fromJson(value));
        }
        if (debug != null) {
          if ((debug)) {
            print('\n\n$mm listModels request found: '
                '💜 ${mList.length} Mistral Models ');
            for (var model in mList) {
              print('$mm Model 💜💜 ${model.toJson()} ');
            }
            print('\n\n$mm End of 💜💜 ${mList.length} Mistral Models \n');
          }
        }
      }
    } catch (e, s) {
      print('$mm ERROR: $e - $s');
    }
    print('$mm listModels request returning '
        '🍎 ${mList.length} 🍎 Mistral Models \n\n');
    return mList;
  }

  static const blue = '🔵🔵🔵';

  /// Send a request to a Mistral model

  Future<MistralResponse?> sendMistralRequest(
      {required MistralRequest mistralRequest, bool? debug}) async {
    MistralResponse? mistralResponse;
    try {
      headers['Authorization'] = 'Bearer $apiKey';
      print('$mm headers, check auth: $headers');

      if (debug != null) {
        if (debug) {
          print('$mm sending request to 🔵🔵 Mistral AI ........ ');
          prettyPrintJson(mistralRequest.toJson());
        }
      }

      Response resp = await dioUtil.sendPostRequest(
          path: _mistralUrl, body: mistralRequest.toJson(), headers: headers, debug: debug);
      if (resp.statusCode == 200 || resp.statusCode == 201) {
        var mJson = jsonDecode(resp.data);
        mistralResponse = MistralResponse.fromJson(mJson);
        if ((debug != null)) {
          if ((debug)) {
            print('$mm response from Mistral $blue}');
            prettyPrintJson(resp.data);
          }
        }
      } else {
        print('$mm sendMistralRequest response: 🔵 '
            '${resp.statusCode} - ${resp.statusMessage}');
        throw Exception(['Mistral Exception occurred, status: ${resp.statusCode}']);

      }
    } catch (e, s) {
      print('$mm ERROR: $e - $s');
      throw Exception(['Mistral Exception occurred: $e - $s']);
    }
    print('$mm sendMistralRequest response: 🔵 totalTokens consumed: '
        '🍎 ${mistralResponse?.usage.totalTokens} 🍎 ');
    return mistralResponse;
  }

  //
  /// Send an embedding request to a Mistral model

  Future<MistralEmbeddingResponse?> sendEmbeddingRequest(
      {required MistralEmbeddingRequest embeddingRequest, bool? debug}) async {
    MistralEmbeddingResponse? mistralResponse;
    try {
      headers['Authorization'] = 'Bearer $apiKey';
      print('$mm headers, check auth: $headers');

      if (debug != null) {
        if (debug) {
          print('$mm sending embedding request '
              '$blue ${embeddingRequest.input?.length} texts to be embedded ....');
          prettyPrintJson(embeddingRequest.toJson());
        }
      }
      var queryParams = embeddingRequest.toJson();
      Response resp  = await dioUtil.sendGetRequestWithHeaders(
          path: _embeddingUrl, queryParameters: queryParams, headers: headers);
      if (resp.statusCode == 200) {
        var mJson = jsonDecode(resp.data);
        mistralResponse = MistralEmbeddingResponse.fromJson(mJson);
        if ((debug != null)) {
          if ((debug)) {
            print('$mm Mistral AI embedding response: '
                '$blue ${mistralResponse.toJson()}');
            prettyPrintJson(mJson);
          }
        }
      }
    } catch (e, s) {
      print('$mm ERROR: $e - $s');
      throw Exception(['Mistral Exception occurred: $e - $s']);
    }
    print('$mm Mistral sendEmbeddingRequest responded; '
        '$blue totalTokens consumed: '
        '🍎 ${mistralResponse?.usage?.totalTokens} 🍎 ');

    return mistralResponse;
  }

  ///Send Hello!

  Future<MistralResponse?> sendHello({bool? debug = true}) async {
    print('$mm sending Hello! to Mistral AI ... 🍎');
    List<MistralMessage> messages = [];
    messages.add(MistralMessage('model', 'I am a Super Tutor'));
    messages.add(MistralMessage('user', 'Hello! help me with algebra fundamentals'));

    MistralResponse? mistralResponse;
    try {
      headers['Authorization'] = 'Bearer $apiKey';
      print('$mm headers, check auth: $headers');

      var request = MistralRequest(
          model: MistralConstants.mistralLargeLatest,
          messages: messages,
          temperature: 0.3,
          randomSeed: 123);

      Response res = await dioUtil.sendPostRequest(
          path: _mistralUrl, body: request.toJson(), headers: headers, debug: debug);
      if (res.statusCode == 200 || res.statusCode == 201) {
        var mJson = jsonDecode(res.data);
        mistralResponse = MistralResponse.fromJson(mJson);
        if (debug!) {
          print('$mm response from saying Hello! to Mistral AI, '
              '🍎tokens: ${mistralResponse.usage.totalTokens}');
          prettyPrintJson(mJson);
        }
      }

    } catch (e, s) {
      print('$mm ERROR: $e - $s');
    }
    return mistralResponse;
  }
}
