import 'package:mistral_sgela_ai/mistral_sgela_ai.dart';
import 'package:test/test.dart';

void main() {
  group('Mistral AI Request Tests', () {
    final mistral = MistralService('uytiuytutyuy');

    setUp(() {
      // Additional setup goes here.
    });

    test('Test Exception getting models', () {
      expect(mistral.listModels(), isException);
    });
  });
}
