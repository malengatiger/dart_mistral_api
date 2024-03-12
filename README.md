# Dart Mistral API Package

This Dart package provides idiomatic access to the Mistral AI API for both Dart and Flutter applications. 
Mistral AI is a powerful platform for artificial intelligence and machine learning tasks, and this package simplifies integration with your Dart and Flutter projects.    

The package hides the messy details of the Mistral API and lets you work with nice statically typed classes.  

- **MistralService**
- **MistralRequest**
- **MistralResponse**
- **MistralEmbeddingRequest**
- **MistralEmbeddingResponse**
- **MistralModel**
- **MistralEmbedding**
- **MistralConstants**


## Installation

Add the following to your `pubspec.yaml`:

```yaml
dependencies:
  mistral_sgela_ai: ^1.1.0+1
```

Then, run:

```bash
$ flutter pub get
```

## Usage

Import the package where you need to use it:

```dart
import 'package:mistral_sgela_ai/mistral_sgela_ai.dart';
```

Initialize the Mistral API client with your API key:

```dart
final mistral = MistralService(apiKey: 'your_api_key');
```

Now you can use the various methods provided by the Mistral API. For example:  
Send a request to the Mistral Chat models endpoint.

```dart
final List<MistralModel> models = await mistral.listModels(); 
```
Send a request to the Mistral Chat completions endpoint.

```dart
var mistralRequest = MistralRequest();
final MistralResponse response = await mistral.sendMistralRequest(mistralRequest); 
```
Send a request to the Mistral Chat embeddings endpoint.

```dart
var mistralEmbeddingRequest = MistralEmbeddingRequest();
final List<MistralEmbeddingResponse> response = await mistral.sendEmbeddingRequest(mistralEmbeddingRequest); 
```

A quick way to check whether things are cool is by sending a Hello request to the Mistral Chat Completions endpoint.   

```dart
final List<MistralResponse> response = await mistral.sendHello(); 
```

## Authentication

You need an API key from Mistral AI to use this package. Get registered and get an API key here: [Mistral AI Website](https://mistral.ai/)  

## Example

You can find a simple example in the [example](example) directory of this repository.

## Issues and Feedback

Please file any issues, bugs, or feature requests in the [issue tracker](https://github.com/malengatiger/dart_mistral_api/issues).

## License

This package is licensed under the MIT License. See the [LICENSE](LICENSE) file for details.