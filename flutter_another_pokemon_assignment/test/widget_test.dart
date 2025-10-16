// Pokemon List Widget Test
// Test basic functionality of Pokemon list page

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:flutter_another_pokemon_assignment/pages/pokemon_list_page.dart';
import 'package:flutter_another_pokemon_assignment/blocs/blocs.dart';

void main() {
  testWidgets('Pokemon List Page smoke test', (WidgetTester tester) async {
    // Build our app with proper BLoC providers and trigger a frame.
    await tester.pumpWidget(
      MaterialApp(
        home: MultiBlocProvider(
          providers: [
            BlocProvider(
              create: (context) => PokemonListBloc()..add(const PokemonListLoadRequested()),
            ),
            BlocProvider(
              create: (context) => FavoriteBloc(),
            ),
          ],
          child: const PokemonListPage(),
        ),
      ),
    );

    // Verify that the app bar title is displayed.
    expect(find.text('Pokemon List'), findsOneWidget);

    // Verify that loading indicator is shown initially.
    expect(find.byType(CircularProgressIndicator), findsOneWidget);
  });
}
