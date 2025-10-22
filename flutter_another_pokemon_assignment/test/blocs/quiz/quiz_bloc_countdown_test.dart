import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'package:flutter_another_pokemon_assignment/blocs/quiz/quiz_bloc.dart';
import 'package:flutter_another_pokemon_assignment/blocs/quiz/quiz_event.dart';
import 'package:flutter_another_pokemon_assignment/blocs/quiz/quiz_state.dart';
import 'package:flutter_another_pokemon_assignment/models/quiz/quiz_models.dart';
import 'package:flutter_another_pokemon_assignment/repository/quiz_repository.dart';

import 'quiz_bloc_countdown_test.mocks.dart';

@GenerateMocks([QuizRepository])
void main() {
  group('QuizBloc countdown', () {
    late MockQuizRepository repository;
    late QuizRound initialRound;
    late QuizRound nextRound;

    setUp(() {
      repository = MockQuizRepository();
      initialRound = QuizRound(
        correct: PokemonQuizDetail(
          id: 4,
          name: 'charmander',
          silhouetteUrl: Uri.parse('https://example.com/silhouette.png'),
          officialUrl: Uri.parse('https://example.com/official.png'),
        ),
        options: const [
          PokemonQuizOption(id: 4, displayName: 'Charmander', isCorrect: true, isSelected: false),
          PokemonQuizOption(id: 7, displayName: 'Squirtle', isCorrect: false, isSelected: false),
          PokemonQuizOption(id: 1, displayName: 'Bulbasaur', isCorrect: false, isSelected: false),
        ],
        status: QuizRoundStatus.ready,
      );
      nextRound = QuizRound(
        correct: PokemonQuizDetail(
          id: 25,
          name: 'pikachu',
          silhouetteUrl: Uri.parse('https://example.com/silhouette2.png'),
          officialUrl: Uri.parse('https://example.com/official2.png'),
        ),
        options: const [
          PokemonQuizOption(id: 25, displayName: 'Pikachu', isCorrect: true, isSelected: false),
          PokemonQuizOption(id: 52, displayName: 'Meowth', isCorrect: false, isSelected: false),
          PokemonQuizOption(id: 39, displayName: 'Jigglypuff', isCorrect: false, isSelected: false),
        ],
        status: QuizRoundStatus.ready,
      );
    });

    blocTest<QuizBloc, QuizState>(
      'auto advances to new round after countdown',
      build: () {
        var callCount = 0;
        when(repository.createRound()).thenAnswer((_) async {
          if (callCount == 0) {
            callCount += 1;
            return initialRound;
          }
          return nextRound;
        });
        return QuizBloc(repository: repository, countdownSeconds: 5);
      },
      act: (bloc) async {
        bloc.add(const QuizStarted());
        await Future<void>.delayed(Duration.zero);
        bloc.add(const QuizOptionSelected(4));
      },
      wait: const Duration(seconds: 6),
      expect: () => [
        const QuizLoading(),
        isA<QuizReady>(),
        isA<QuizReveal>().having(
          (state) => state.round.countdownRemaining,
          'countdown start',
          5,
        ),
        isA<QuizReveal>().having(
          (state) => state.round.countdownRemaining,
          'countdown tick 4',
          4,
        ),
        isA<QuizReveal>().having(
          (state) => state.round.countdownRemaining,
          'countdown tick 3',
          3,
        ),
        isA<QuizReveal>().having(
          (state) => state.round.countdownRemaining,
          'countdown tick 2',
          2,
        ),
        isA<QuizReveal>().having(
          (state) => state.round.countdownRemaining,
          'countdown tick 1',
          1,
        ),
        const QuizLoading(),
        isA<QuizReady>().having(
          (state) => state.round.correct.id,
          'next round pokemon id',
          25,
        ),
      ],
      verify: (_) {
        verify(repository.createRound()).called(2);
      },
    );
  });
}
