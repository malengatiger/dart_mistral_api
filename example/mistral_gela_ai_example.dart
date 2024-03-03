

import 'package:mistral_sgela_ai/mistral_sgela_ai.dart';
import 'package:mistral_sgela_ai/src/mistral_constants.dart';

Future<void> main() async {
  var mistral = MistralService('<apiKey>');
  //
  List<MistralModel> models = await mistral.listModels(debug: true);
  for (var model in models) {
    MistralService.prettyPrintJson(model.toJson());
  }
  //
  List<MistralMessage> messages = [];
  messages.add(MistralMessage('user', 'Hello!'));
  //add more messages ....
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
  input.add('I need your assistance for cooking rice');
  //add your texts
  MistralEmbeddingRequest request = MistralEmbeddingRequest(
      encodingFormat: 'float', model: MistralConstants.mistralSmallLatest, input: input);
  MistralEmbeddingResponse? embeddingResponse = await mistral
      .sendEmbeddingRequest(embeddingRequest: request, debug: true);
  //print response
  if (embeddingResponse != null) {
    MistralService.prettyPrintJson(embeddingResponse!.toJson());
  }
}
