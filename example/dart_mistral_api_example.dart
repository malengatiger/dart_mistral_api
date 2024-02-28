import 'package:dart_mistral_api/dart_mistral_api.dart';

Future<void> main() async {
  var mistral = MistralService('<apiKey>');
  //
  List<MistralModel> models = await mistral.listModels(debug: true);
  for (var model in models) {
    MistralService.prettyPrintJson(model.toJson());
  }
  //
  List<MistralMessage> messages = [];
  //add your messages
  var mistralRequest = MistralRequest(
      model: 'model',
      messages: messages,
      temperature: 0.0,
      topP: 1,
      maxTokens: 100,
      safePrompt: null,
      randomSeed: 123);

  MistralResponse? response = await mistral.sendMistralRequest(
      mistralRequest: mistralRequest, debug: true);

  //print response
  if (response != null) {
    MistralService.prettyPrintJson(response.toJson());
  }

  //embeddings
  List<String> input = [];
  //add your texts
  MistralEmbeddingRequest request = MistralEmbeddingRequest(
      encodingFormat: 'float', model: '<model>', input: input);
  MistralEmbeddingResponse? embeddingResponse = await mistral
      .sendEmbeddingRequest(embeddingRequest: request, debug: true);
  //print response
  if (embeddingResponse != null) {
    MistralService.prettyPrintJson(embeddingResponse!.toJson());
  }
}
