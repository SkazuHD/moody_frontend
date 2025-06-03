import 'package:test/test.dart';
import 'package:soullog_api/soullog_api.dart';

// tests for Persona
void main() {
  final instance = PersonaBuilder();
  // TODO add properties to the builder and call build()

  group(Persona, () {
    // Stable personality traits, values, and preferences.
    // BuiltList<String> longTermTraits
    test('to test the property `longTermTraits`', () async {
      // TODO
    });

    // Recent emotional or situational states.
    // BuiltList<ShortTermState> shortTermStates
    test('to test the property `shortTermStates`', () async {
      // TODO
    });

    // Commonly referenced people, themes, or objects.
    // BuiltList<ContextualInsight> contextualInsights
    test('to test the property `contextualInsights`', () async {
      // TODO
    });
  });
}
