import 'package:bloc_test/bloc_test.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import 'package:flutter_another_pokemon_assignment/blocs/quiz/quiz_bloc.dart';
import 'package:flutter_another_pokemon_assignment/blocs/quiz/quiz_event.dart';
import 'package:flutter_another_pokemon_assignment/blocs/quiz/quiz_state.dart';
import 'package:flutter_another_pokemon_assignment/models/quiz/quiz_models.dart';
import 'package:flutter_another_pokemon_assignment/pages/quiz_page.dart';

class MockQuizBloc extends MockBloc<QuizEvent, QuizState> implements QuizBloc {}

void main() {
  testWidgets('shows reveal UI with artwork, message, icons, and countdown', (tester) async {
    final mockBloc = MockQuizBloc();
    final revealState = QuizReveal(
      round: QuizRound(
        correct: PokemonQuizDetail(
          id: 7,
          name: 'squirtle',
          silhouetteUrl: Uri.parse('https://example.com/silhouette.png'),
          officialUrl: Uri.parse('https://example.com/official.png'),
        ),
        options: const [
          PokemonQuizOption(id: 7, displayName: 'Squirtle', isCorrect: true, isSelected: true),
          PokemonQuizOption(id: 25, displayName: 'Pikachu', isCorrect: false, isSelected: false),
          PokemonQuizOption(id: 1, displayName: 'Bulbasaur', isCorrect: false, isSelected: false),
        ],
        status: QuizRoundStatus.revealed,
        countdownRemaining: 3,
      ),
    );

    whenListen(
      mockBloc,
      Stream<QuizState>.value(revealState),
      initialState: revealState,
    );
    when(() => mockBloc.state).thenReturn(revealState);

    await tester.pumpWidget(
      MaterialApp(
        home: BlocProvider<QuizBloc>.value(
          value: mockBloc,
          child: const QuizPage(autoStart: false),
        ),
      ),
    );

    await tester.pump();

    expect(find.text("It's Squirtle"), findsOneWidget);
    expect(find.text('Next round in 3s'), findsOneWidget);
    expect(find.byIcon(Icons.check), findsOneWidget);
  });
}
