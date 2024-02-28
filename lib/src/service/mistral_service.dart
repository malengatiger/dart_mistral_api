import 'dart:convert';

import 'package:dart_mistral_api/dart_mistral_api.dart';
import 'package:dio/dio.dart';

class MistralService {
  /*
  💜💜 Mistral AI provides five API endpoints for its five Large Language Models
*/

  final DioUtil dioUtil = DioUtil(Dio());

  final String apiKey;
  static const _mistralUrl = 'https://api.mistral.ai/v1/chat/completions';

  /*
  curl --location "https://api.mistral.ai/v1/chat/completions" \
     --header 'Content-Type: application/json' \
     --header 'Accept: application/json' \
     --header "Authorization: Bearer $MISTRAL_API_KEY" \
     --data '{
    "model": "mistral-large-latest",
    "messages": [
     {
        "role": "user",
        "content": "What is the best French cheese?"
      }
    ]
  }'
  curl --location "https://api.mistral.ai/v1/embeddings" \
     --header 'Content-Type: application/json' \
     --header 'Accept: application/json' \
     --header "Authorization: Bearer $MISTRAL_API_KEY" \
     --data '{
    "model": "mistral-embed",
    "input": ["Embed this sentence.", "As well as this one."]
  }'
   */

  MistralService(this.apiKey);

  static const mm = '🍐🍐🍐🍐MistralService 🍐';
  static const _mistralGetUrl = 'https://api.mistral.ai/v1/';

  init() {}

  var headers = {
    'Content-Type': 'application/json',
  };

  static void prettyPrintJson(Map<String, dynamic> json) {
    JsonEncoder encoder = JsonEncoder.withIndent('  ');
    String prettyPrintedJson = encoder.convert(json);
    print(prettyPrintedJson);
  }

  Future<List<MistralModel>> listModels({bool? debug}) async {
    List<MistralModel> mList = [];
    headers['Authorization'] = 'Bearer $apiKey';
    if (debug != null) {
      if ((debug)) {
        prettyPrintJson({
          'command': 'List Mistral models',
          'apiKey': apiKey,
          'debug': debug
        });
      }
    }
    try {
      var res = await dioUtil.sendGetRequestWithHeaders(
          path: _mistralGetUrl, queryParameters: {}, headers: headers);
      var object = res['object'];
      List jList = res['data'];
      for (var value in jList) {
        mList.add(MistralModel.fromJson(value));
      }
      if (debug != null) {
        if ((debug)) {
          print('$mm Found ${mList.length} Mistral Models ');
          prettyPrintJson(res);
        }
      }
    } catch (e, s) {
      print('$mm ERROR: $e - $s');
    }

    return mList;
  }

  Future<MistralResponse?> sendMistralRequest(
      {required MistralRequest mistralRequest, bool? debug}) async {
    MistralResponse? mistralResponse;
    try {
      var jsonMessages = [];
      headers['Authorization'] = 'Bearer $apiKey';
      if (debug != null) {
        if (debug) {
          print('$mm sending mistralRequest to Mistral AI ........ ');
          prettyPrintJson(mistralRequest.toJson());
        }
      }
      for (var value in mistralRequest.messages) {
        jsonMessages.add(value.toJson());
      }
      var queryParams = {
        'model': mistralRequest.model,
        'messages': jsonMessages
      };
      var resp = mistralResponse = await dioUtil.sendGetRequestWithHeaders(
          path: '${_mistralGetUrl}models',
          queryParameters: queryParams,
          headers: headers);
      mistralResponse = MistralResponse.fromJson(resp);
      if ((debug != null)) {
        if ((debug)) {
          print('$mm Mistral Response: ${mistralResponse.toJson()}');
          prettyPrintJson(resp);
        }
      }
    } catch (e, s) {
      print('$mm ERROR: $e - $s');
      throw Exception(['Mistral Exception occurred: $e - $s']);
    }
    return mistralResponse;
  }

  //
  Future<MistralEmbeddingResponse?> sendEmbeddingRequest(
      {required MistralEmbeddingRequest embeddingRequest, bool? debug}) async {
    MistralEmbeddingResponse? mistralResponse;
    try {
      headers['Authorization'] = 'Bearer $apiKey';

      if (debug != null) {
        if (debug) {
          print('$mm sending embedding request ....');
          prettyPrintJson(embeddingRequest.toJson());
        }
      }
      var queryParams = embeddingRequest.toJson();
      var resp = mistralResponse = await dioUtil.sendGetRequestWithHeaders(
          path: '${_mistralGetUrl}embeddings',
          queryParameters: queryParams,
          headers: headers);
      mistralResponse = MistralEmbeddingResponse.fromJson(resp);
      if ((debug != null)) {
        if ((debug)) {
          print('$mm Mistral Response: ${mistralResponse.toJson()}');
          prettyPrintJson(resp);
        }
      }
    } catch (e, s) {
      print('$mm ERROR: $e - $s');
      throw Exception(['Mistral Exception occurred: $e - $s']);
    }
    return mistralResponse;
  }
}
