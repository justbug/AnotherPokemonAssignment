import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'package:flutter_another_pokemon_assignment/blocs/quiz/quiz_bloc.dart';
import 'package:flutter_another_pokemon_assignment/blocs/quiz/quiz_event.dart';
import 'package:flutter_another_pokemon_assignment/blocs/quiz/quiz_state.dart';
import 'package:flutter_another_pokemon_assignment/models/quiz/quiz_models.dart';
import 'package:flutter_another_pokemon_assignment/repository/quiz_repository.dart';

import 'quiz_bloc_reveal_test.mocks.dart';

@GenerateMocks([QuizRepository])
void main() {
  group('QuizBloc reveal', () {
    late MockQuizRepository repository;
    late QuizRound round;

    setUp(() {
      repository = MockQuizRepository();
      round = QuizRound(
        correct: PokemonQuizDetail(
          id: 7,
          name: 'squirtle',
          silhouetteUrl: Uri.parse('https://example.com/silhouette.png'),
          officialUrl: Uri.parse('https://example.com/official.png'),
        ),
        options: const [
          PokemonQuizOption(id: 7, displayName: 'Squirtle', isCorrect: true, isSelected: false),
          PokemonQuizOption(id: 25, displayName: 'Pikachu', isCorrect: false, isSelected: false),
          PokemonQuizOption(id: 1, displayName: 'Bulbasaur', isCorrect: false, isSelected: false),
        ],
        status: QuizRoundStatus.ready,
      );
    });

    blocTest<QuizBloc, QuizState>(
      'emits QuizReveal with selected option and countdown start',
      build: () {
        when(repository.createRound()).thenAnswer((_) async => round);
        return QuizBloc(repository: repository, countdownSeconds: 5);
      },
      act: (bloc) async {
        bloc.add(const QuizStarted());
        await Future<void>.delayed(Duration.zero);
        bloc.add(const QuizOptionSelected(7));
      },
      wait: const Duration(milliseconds: 200),
      expect: () => [
        const QuizLoading(),
        isA<QuizReady>(),
        isA<QuizReveal>()
            .having((state) => state.round.countdownRemaining, 'countdown', 5)
            .having(
              (state) => state.round.options
                  .firstWhere((o) => o.id == 7)
                  .isSelected,
              'correct option selected',
              isTrue,
            ),
      ],
      verify: (_) {
        verify(repository.createRound()).called(1);
      },
    );
  });
}
