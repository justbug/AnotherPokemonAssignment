// Pokemon List Widget Test
// Test basic functionality of Pokemon list page

import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_another_pokemon_assignment/models/models.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:flutter_another_pokemon_assignment/blocs/blocs.dart';
import 'package:flutter_another_pokemon_assignment/pages/pokemon_list_page.dart';
import 'package:flutter_another_pokemon_assignment/repository/favorite_pokemon_repository.dart';
import 'package:flutter_another_pokemon_assignment/repository/list_repository.dart';
import 'helpers/test_helpers.dart';

class _ControlledListRepository implements ListRepositorySpec {
  const _ControlledListRepository(this.completer);

  final Completer<List<Pokemon>> completer;

  @override
  Future<List<Pokemon>> fetchList({int offset = 0}) {
    return completer.future;
  }
}

void main() {
  testWidgets('Pokemon List Page smoke test', (WidgetTester tester) async {
    final completer = Completer<List<Pokemon>>();
    // Build our app with proper BLoC providers and trigger a frame.
    await tester.pumpWidget(
      MaterialApp(
        home: MultiBlocProvider(
          providers: [
            BlocProvider(
              create: (context) => PokemonListBloc(
                listRepository: _ControlledListRepository(completer),
                favoriteRepository: FavoritePokemonRepository(
                  localPokemonService: InMemoryLocalPokemonService(),
                ),
              )..add(const PokemonListLoadRequested()),
            ),
            BlocProvider(
              create: (context) => FavoriteBloc(
                favoriteRepository: FavoritePokemonRepository(
                  localPokemonService: InMemoryLocalPokemonService(),
                ),
              ),
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

    completer.complete(const <Pokemon>[]);
    await tester.pump();
  });
}
