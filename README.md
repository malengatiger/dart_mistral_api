# Dart Mistral API Package

This Dart package provides idiomatic access to the Mistral AI API for both Dart and Flutter applications. Mistral AI is a powerful platform for artificial intelligence and machine learning tasks, and this package simplifies integration with your Dart and Flutter projects.

## Installation

Add the following to your `pubspec.yaml`:

```yaml
dependencies:
  dart_mistral_api: ^1.0.0
```

Then, run:

```bash
$ flutter pub get
```

## Usage

Import the package where you need to use it:

```dart
import 'package:dart_mistral_api/dart_mistral_api.dart';
```

Initialize the Mistral API client with your API key:

```dart
final mistral = MistralService(apiKey: 'your_api_key');
```

Now you can use the various methods provided by the Mistral API. For example:  
Send a request to the Mistral Chat models endpoint.

```dart
final List<MistralModel> models = mistral.listModels(); 
```
Send a request to the Mistral Chat completions endpoint.

```dart
var mistralRequest = MistralRequest();
final MistralResponse response = mistral.sendMistralRequest(mistralRequest); 
```
Send a request to the Mistral Chat embeddings endpoint.

```dart
var mistralEmbeddingRequest = MistralEmbeddingRequest();
final List<MistralEmbeddingResponse> response = mistral.sendEmbeddingRequest(mistralEmbeddingRequest); 
```

For more details on available methods and their usage, refer to the [API documentation](https://mistralai.com/docs).

## Authentication

You need an API key from Mistral AI to use this package. You can sign up and get your API key from the [Mistral AI website](https://mistralai.com).

## Example

You can find a simple example in the [example](example) directory of this repository.

## Issues and Feedback

Please file any issues, bugs, or feature requests in the [issue tracker](https://github.com/your_username/dart_mistral_api/issues).

## License

This package is licensed under the MIT License. See the [LICENSE](LICENSE) file for details.