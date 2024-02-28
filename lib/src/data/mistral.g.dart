// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'mistral.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MistralMessage _$MistralMessageFromJson(Map<String, dynamic> json) =>
    MistralMessage(
      json['role'] as String,
      json['content'] as String,
    );

Map<String, dynamic> _$MistralMessageToJson(MistralMessage instance) =>
    <String, dynamic>{
      'role': instance.role,
      'content': instance.content,
    };

MistralModel _$MistralModelFromJson(Map<String, dynamic> json) => MistralModel(
      json['id'] as String?,
      json['created'] as int?,
      json['object'] as String?,
      json['owned_by'] as String,
    );

Map<String, dynamic> _$MistralModelToJson(MistralModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'created': instance.created,
      'object': instance.object,
      'owned_by': instance.ownedBy,
    };

MistralRequest _$MistralRequestFromJson(Map<String, dynamic> json) =>
    MistralRequest(
      model: json['model'] as String?,
      messages: (json['messages'] as List<dynamic>)
          .map((e) => MistralMessage.fromJson(e as Map<String, dynamic>))
          .toList(),
      temperature: (json['temperature'] as num?)?.toDouble(),
      topP: json['top_p'] as int?,
      maxTokens: json['max_tokens'] as int?,
      safePrompt: json['safe_prompt'] as bool?,
      randomSeed: json['random_seed'] as int?,
    );

Map<String, dynamic> _$MistralRequestToJson(MistralRequest instance) =>
    <String, dynamic>{
      'model': instance.model,
      'messages': instance.messages,
      'temperature': instance.temperature,
      'top_p': instance.topP,
      'max_tokens': instance.maxTokens,
      'safe_prompt': instance.safePrompt,
      'random_seed': instance.randomSeed,
    };

MistralResponse _$MistralResponseFromJson(Map<String, dynamic> json) =>
    MistralResponse(
      json['id'] as String?,
      json['object'] as String?,
      json['created'] as String?,
      json['model'] as String?,
      (json['choices'] as List<dynamic>)
          .map((e) => MistralChoice.fromJson(e as Map<String, dynamic>))
          .toList(),
      MistralUsage.fromJson(json['usage'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$MistralResponseToJson(MistralResponse instance) =>
    <String, dynamic>{
      'id': instance.id,
      'object': instance.object,
      'created': instance.created,
      'model': instance.model,
      'choices': instance.choices,
      'usage': instance.usage,
    };

MistralUsage _$MistralUsageFromJson(Map<String, dynamic> json) => MistralUsage(
      json['prompt_tokens'] as int?,
      json['completion_tokens'] as int?,
      json['total_tokens'] as int?,
    );

Map<String, dynamic> _$MistralUsageToJson(MistralUsage instance) =>
    <String, dynamic>{
      'prompt_tokens': instance.promptTokens,
      'completion_tokens': instance.completionTokens,
      'total_tokens': instance.totalTokens,
    };

MistralChoice _$MistralChoiceFromJson(Map<String, dynamic> json) =>
    MistralChoice(
      json['index'] as int?,
      json['mistralMessage'] == null
          ? null
          : MistralMessage.fromJson(
              json['mistralMessage'] as Map<String, dynamic>),
      json['finish_reason'] as String?,
    );

Map<String, dynamic> _$MistralChoiceToJson(MistralChoice instance) =>
    <String, dynamic>{
      'index': instance.index,
      'mistralMessage': instance.mistralMessage,
      'finish_reason': instance.finishReason,
    };

MistralEmbeddingRequest _$MistralEmbeddingRequestFromJson(
        Map<String, dynamic> json) =>
    MistralEmbeddingRequest(
      encodingFormat: json['encoding_format'] as String?,
      model: json['model'] as String?,
      input:
          (json['input'] as List<dynamic>?)?.map((e) => e as String).toList(),
    );

Map<String, dynamic> _$MistralEmbeddingRequestToJson(
        MistralEmbeddingRequest instance) =>
    <String, dynamic>{
      'encoding_format': instance.encodingFormat,
      'model': instance.model,
      'input': instance.input,
    };

MistralEmbedding _$MistralEmbeddingFromJson(Map<String, dynamic> json) =>
    MistralEmbedding(
      object: json['object'] as String?,
      embedding: (json['embedding'] as List<dynamic>?)
          ?.map((e) => (e as num).toDouble())
          .toList(),
      index: json['index'] as int?,
    );

Map<String, dynamic> _$MistralEmbeddingToJson(MistralEmbedding instance) =>
    <String, dynamic>{
      'object': instance.object,
      'embedding': instance.embedding,
      'index': instance.index,
    };

MistralEmbeddingResponse _$MistralEmbeddingResponseFromJson(
        Map<String, dynamic> json) =>
    MistralEmbeddingResponse(
      json['id'] as String?,
      json['object'] as String?,
      json['model'] as String?,
      (json['data'] as List<dynamic>)
          .map((e) => MistralEmbedding.fromJson(e as Map<String, dynamic>))
          .toList(),
      json['usage'] == null
          ? null
          : MistralUsage.fromJson(json['usage'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$MistralEmbeddingResponseToJson(
        MistralEmbeddingResponse instance) =>
    <String, dynamic>{
      'id': instance.id,
      'object': instance.object,
      'model': instance.model,
      'data': instance.data,
      'usage': instance.usage,
    };
