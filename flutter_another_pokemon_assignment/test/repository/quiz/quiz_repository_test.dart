import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'package:flutter_another_pokemon_assignment/models/quiz/quiz_models.dart';
import 'package:flutter_another_pokemon_assignment/repository/quiz_repository.dart';
import 'package:flutter_another_pokemon_assignment/services/supabase_service.dart';

import 'quiz_repository_test.mocks.dart';

@GenerateMocks([SupabaseService])
void main() {
  late MockSupabaseService service;
  late QuizRepository repository;

  const list = [
    PokemonQuizEntry(id: 1, name: 'bulbasaur'),
    PokemonQuizEntry(id: 2, name: 'ivysaur'),
    PokemonQuizEntry(id: 3, name: 'venusaur'),
  ];

  final detail = PokemonQuizDetail(
    id: 1,
    name: 'bulbasaur',
    silhouetteUrl: Uri.parse('https://example.com/silhouette.png'),
    officialUrl: Uri.parse('https://example.com/official.png'),
    createdAt: DateTime.parse('2024-01-15T10:30:00Z'),
  );

  setUp(() {
    service = MockSupabaseService();
    repository = QuizRepository(service: service);
  });

  group('loadPokemonList', () {
    test('fetches list once and caches subsequent calls', () async {
      when(service.fetchPokemonList()).thenAnswer((_) async => list);

      final first = await repository.loadPokemonList();
      final second = await repository.loadPokemonList();

      expect(first, equals(list));
      expect(second, equals(list));
      verify(service.fetchPokemonList()).called(1);
    });

    test('throws StateError when list smaller than 3 entries', () async {
      when(service.fetchPokemonList()).thenAnswer((_) async => list.take(2).toList());

      await expectLater(
        repository.loadPokemonList(),
        throwsA(isA<StateError>()),
      );
    });
  });

  group('loadPokemonDetail', () {
    test('delegates to service for detail fetch', () async {
      when(service.fetchPokemonDetail(1)).thenAnswer((_) async => detail);

      final result = await repository.loadPokemonDetail(1);

      expect(result, equals(detail));
      verify(service.fetchPokemonDetail(1)).called(1);
    });
  });
}
