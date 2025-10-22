import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'package:flutter_another_pokemon_assignment/blocs/quiz/quiz_bloc.dart';
import 'package:flutter_another_pokemon_assignment/models/quiz/quiz_models.dart';
import 'package:flutter_another_pokemon_assignment/pages/quiz_page.dart';
import 'package:flutter_another_pokemon_assignment/repository/quiz_repository.dart';

import 'quiz_page_initial_test.mocks.dart';

@GenerateMocks([QuizRepository])
void main() {
  testWidgets('renders silhouette and three options when ready', (tester) async {
    final repository = MockQuizRepository();
    final round = QuizRound(
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

    when(repository.createRound()).thenAnswer((_) async => round);

    await tester.pumpWidget(
      MaterialApp(
        home: BlocProvider(
          create: (_) => QuizBloc(repository: repository),
          child: const QuizPage(),
        ),
      ),
    );

    await tester.pump();
    await tester.pump();

    expect(find.text("Who's That Pokémon"), findsOneWidget);
    expect(find.byType(CachedNetworkImage), findsOneWidget);
    expect(find.text('Squirtle'), findsOneWidget);
    expect(find.text('Pikachu'), findsOneWidget);
    expect(find.text('Bulbasaur'), findsOneWidget);
    expect(find.byType(FilledButton), findsNWidgets(3));
  });
}
