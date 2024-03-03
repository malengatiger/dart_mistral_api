import 'package:json_annotation/json_annotation.dart';

part 'mistral.g.dart';

@JsonSerializable()
class MistralMessage {
  String role;
  String content;

  MistralMessage(this.role, this.content);

  factory MistralMessage.fromJson(Map<String, dynamic> json) =>
      _$MistralMessageFromJson(json);

  Map<String, dynamic> toJson() => _$MistralMessageToJson(this);
}

@JsonSerializable()
class MistralModel {
  String? id;
  int? created;
  String? object;
  @JsonKey(name: 'owned_by')
  String ownedBy;

  MistralModel(this.id, this.created, this.object, this.ownedBy);

  factory MistralModel.fromJson(Map<String, dynamic> json) =>
      _$MistralModelFromJson(json);

  Map<String, dynamic> toJson() => _$MistralModelToJson(this);
}

@JsonSerializable()
class MistralRequest {
  String? model;
  List<MistralMessage> messages = [];
  double? temperature;
  @JsonKey(name: 'top_p')
  int? topP;
  @JsonKey(name: 'max_tokens')
  int? maxTokens;
  @JsonKey(name: 'safe_prompt')
  bool? safePrompt;
  @JsonKey(name: 'random_seed')
  int? randomSeed;
  bool? stream;

  MistralRequest(
      {required this.model,
      required this.messages,
      this.temperature,
      this.topP,
      this.maxTokens,
      this.safePrompt,
      this.stream,
      this.randomSeed});

  factory MistralRequest.fromJson(Map<String, dynamic> json) =>
      _$MistralRequestFromJson(json);

  Map<String, dynamic> toJson() => _$MistralRequestToJson(this);
}

@JsonSerializable()
class MistralResponse {
  String? id, object, created, model;
  List<MistralChoice> choices = [];
  MistralUsage usage;

  MistralResponse(
      this.id, this.object, this.created, this.model, this.choices, this.usage);

  factory MistralResponse.fromJson(Map<String, dynamic> json) =>
      _$MistralResponseFromJson(json);

  Map<String, dynamic> toJson() => _$MistralResponseToJson(this);
}

@JsonSerializable()
class MistralUsage {
  @JsonKey(name: 'prompt_tokens')
  int? promptTokens;
  @JsonKey(name: 'completion_tokens')
  int? completionTokens;
  @JsonKey(name: 'total_tokens')
  int? totalTokens;

  MistralUsage(this.promptTokens, this.completionTokens, this.totalTokens);

  factory MistralUsage.fromJson(Map<String, dynamic> json) =>
      _$MistralUsageFromJson(json);

  Map<String, dynamic> toJson() => _$MistralUsageToJson(this);
}

@JsonSerializable()
class MistralChoice {
  int? index;
  MistralMessage? mistralMessage;
  @JsonKey(name: 'finish_reason')
  String? finishReason;

  MistralChoice(this.index, this.mistralMessage, this.finishReason);

  factory MistralChoice.fromJson(Map<String, dynamic> json) =>
      _$MistralChoiceFromJson(json);

  Map<String, dynamic> toJson() => _$MistralChoiceToJson(this);
}

@JsonSerializable()
class MistralEmbeddingRequest {
  @JsonKey(name: 'encoding_format')
  String? encodingFormat;
  String? model;
  List<String>? input = [];

  MistralEmbeddingRequest(
      {required this.encodingFormat, required this.model, required this.input});

  factory MistralEmbeddingRequest.fromJson(Map<String, dynamic> json) =>
      _$MistralEmbeddingRequestFromJson(json);

  Map<String, dynamic> toJson() => _$MistralEmbeddingRequestToJson(this);
}

@JsonSerializable()
class MistralEmbedding {
  String? object;
  List<double>? embedding;
  int? index;

  MistralEmbedding(
      {required this.object, required this.embedding, required this.index});

  factory MistralEmbedding.fromJson(Map<String, dynamic> json) =>
      _$MistralEmbeddingFromJson(json);

  Map<String, dynamic> toJson() => _$MistralEmbeddingToJson(this);
}

@JsonSerializable()
class MistralEmbeddingResponse {
  String? id, object, model;
  List<MistralEmbedding> data = [];
  MistralUsage? usage;

  MistralEmbeddingResponse(
      this.id, this.object, this.model, this.data, this.usage);

  factory MistralEmbeddingResponse.fromJson(Map<String, dynamic> json) =>
      _$MistralEmbeddingResponseFromJson(json);

  Map<String, dynamic> toJson() => _$MistralEmbeddingResponseToJson(this);
}
