import 'dart:async';

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
  testWidgets('updates countdown text and resets for next round', (tester) async {
    final mockBloc = MockQuizBloc();

    final revealTwo = QuizReveal(
      round: QuizRound(
        correct: PokemonQuizDetail(
          id: 4,
          name: 'charmander',
          silhouetteUrl: Uri.parse('https://example.com/silhouette.png'),
          officialUrl: Uri.parse('https://example.com/official.png'),
        ),
        options: const [
          PokemonQuizOption(id: 4, displayName: 'Charmander', isCorrect: true, isSelected: true),
          PokemonQuizOption(id: 7, displayName: 'Squirtle', isCorrect: false, isSelected: false),
          PokemonQuizOption(id: 1, displayName: 'Bulbasaur', isCorrect: false, isSelected: false),
        ],
        status: QuizRoundStatus.revealed,
        countdownRemaining: 2,
      ),
    );

    final revealOne = QuizReveal(
      round: revealTwo.round.copyWith(countdownRemaining: 1),
    );
    const loading = QuizLoading();
    final ready = QuizReady(
      round: QuizRound(
        correct: PokemonQuizDetail(
          id: 39,
          name: 'jigglypuff',
          silhouetteUrl: Uri.parse('https://example.com/silhouette2.png'),
          officialUrl: Uri.parse('https://example.com/official2.png'),
        ),
        options: const [
          PokemonQuizOption(id: 39, displayName: 'Jigglypuff', isCorrect: true, isSelected: false),
          PokemonQuizOption(id: 25, displayName: 'Pikachu', isCorrect: false, isSelected: false),
          PokemonQuizOption(id: 7, displayName: 'Squirtle', isCorrect: false, isSelected: false),
        ],
        status: QuizRoundStatus.ready,
      ),
    );

    final controller = StreamController<QuizState>();
    addTearDown(controller.close);

    whenListen(
      mockBloc,
      controller.stream,
      initialState: revealTwo,
    );
    when(() => mockBloc.state).thenReturn(revealTwo);

    await tester.pumpWidget(
      MaterialApp(
        home: BlocProvider<QuizBloc>.value(
          value: mockBloc,
          child: const QuizPage(autoStart: false),
        ),
      ),
    );

    await tester.pump();
    controller.add(revealTwo);
    await tester.pump();
    expect(find.text('Next round in 2s'), findsOneWidget);

    controller.add(revealOne);
    await tester.pump();
    expect(find.text('Next round in 1s'), findsOneWidget);

    controller.add(loading);
    await tester.pump();
    expect(find.byType(CircularProgressIndicator), findsOneWidget);

    controller.add(ready);
    await tester.pump();
    expect(find.text('Next round in 1s'), findsNothing);
    expect(find.text('Jigglypuff'), findsOneWidget);
  });
}
