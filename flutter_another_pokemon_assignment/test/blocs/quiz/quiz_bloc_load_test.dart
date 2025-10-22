import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'package:flutter_another_pokemon_assignment/blocs/quiz/quiz_bloc.dart';
import 'package:flutter_another_pokemon_assignment/blocs/quiz/quiz_event.dart';
import 'package:flutter_another_pokemon_assignment/blocs/quiz/quiz_state.dart';
import 'package:flutter_another_pokemon_assignment/models/quiz/quiz_models.dart';
import 'package:flutter_another_pokemon_assignment/repository/quiz_repository.dart';

import 'quiz_bloc_load_test.mocks.dart';

@GenerateMocks([QuizRepository])
void main() {
  final round = QuizRound(
    correct: PokemonQuizDetail(
      id: 25,
      name: 'pikachu',
      silhouetteUrl: Uri.parse('https://example.com/silhouette.png'),
      officialUrl: Uri.parse('https://example.com/official.png'),
    ),
    options: const [
      PokemonQuizOption(id: 25, displayName: 'Pikachu', isCorrect: true, isSelected: false),
      PokemonQuizOption(id: 1, displayName: 'Bulbasaur', isCorrect: false, isSelected: false),
      PokemonQuizOption(id: 4, displayName: 'Charmander', isCorrect: false, isSelected: false),
    ],
    status: QuizRoundStatus.ready,
  );

  group('QuizBloc loading', () {
    late MockQuizRepository repository;

    setUp(() {
      repository = MockQuizRepository();
    });

    blocTest<QuizBloc, QuizState>(
      'emits loading then ready when round loads successfully',
      build: () {
        when(repository.createRound()).thenAnswer((_) async => round);
        return QuizBloc(repository: repository);
      },
      act: (bloc) => bloc.add(const QuizStarted()),
      expect: () => [
        isA<QuizLoading>(),
        isA<QuizReady>().having((state) => state.round.options.length, 'options length', 3),
      ],
      verify: (_) => verify(repository.createRound()).called(1),
    );

    blocTest<QuizBloc, QuizState>(
      'emits error when repository load fails',
      build: () {
        when(repository.createRound()).thenThrow(Exception('network'));
        return QuizBloc(repository: repository);
      },
      act: (bloc) => bloc.add(const QuizStarted()),
      expect: () => [
        isA<QuizLoading>(),
        isA<QuizError>().having((state) => state.message, 'message', contains('network')),
      ],
    );
  });
}
