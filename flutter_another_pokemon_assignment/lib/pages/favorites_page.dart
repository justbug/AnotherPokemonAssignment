import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../blocs/blocs.dart';
import '../models/pokemon.dart';
import '../widgets/pokemon_list_widget.dart';

/// Favorites list page
/// Shows user's favorite Pokemon list, sorted by favorite time
class FavoritesPage extends StatefulWidget {
  const FavoritesPage({super.key});

  @override
  State<FavoritesPage> createState() => _FavoritesPageState();
}

class _FavoritesPageState extends State<FavoritesPage> {
  @override
  void initState() {
    super.initState();
    // Trigger initial load
    context.read<FavoritesListBloc>().add(const FavoritesListLoadRequested());
  }

  /// Handle pull-to-refresh
  Future<void> _onRefresh() async {
    // Reload favorite states
    context.read<FavoriteBloc>().add(const FavoriteLoadAllRequested());
    // Reload favorites list
    context.read<FavoritesListBloc>().add(const FavoritesListRefreshRequested());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Favorites'),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),
      body: BlocListener<FavoriteBloc, FavoriteState>(
        listener: (context, state) {
          // When favorite state changes, reload favorites list
          if (state is FavoriteSuccess) {
            context.read<FavoritesListBloc>().add(const FavoritesListRefreshRequested());
          }
        },
        child: BlocBuilder<FavoritesListBloc, FavoritesListState>(
          builder: (context, state) => _buildBody(state),
        ),
      ),
    );
  }

  Widget _buildBody(FavoritesListState state) {
    if (state is FavoritesListLoading) {
      return const Center(
        child: CircularProgressIndicator(),
      );
    }

    if (state is FavoritesListError) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(
              Icons.error_outline,
              size: 64,
              color: Colors.red,
            ),
            const SizedBox(height: 16),
            Text(
              state.message,
              style: const TextStyle(color: Colors.red),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                context.read<FavoritesListBloc>().add(const FavoritesListLoadRequested());
              },
              child: const Text('Retry'),
            ),
          ],
        ),
      );
    }

    if (state is FavoritesListSuccess) {
      // Convert LocalPokemon to Pokemon
      final favoritePokemons = state.favoritePokemons.map((localPokemon) => Pokemon(
        id: localPokemon.id,
        name: localPokemon.name,
        imageURL: localPokemon.imageURL,
      )).toList();

      if (favoritePokemons.isEmpty) {
        return RefreshIndicator(
          onRefresh: _onRefresh,
          child: SingleChildScrollView(
            physics: const AlwaysScrollableScrollPhysics(),
            child: SizedBox(
              height: MediaQuery.of(context).size.height * 0.7,
              child: const Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.favorite_border,
                      size: 64,
                      color: Colors.grey,
                    ),
                    SizedBox(height: 16),
                    Text(
                      'No favorite Pokemon yet',
                      style: TextStyle(
                        fontSize: 18,
                        color: Colors.grey,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      }

      return RefreshIndicator(
        onRefresh: _onRefresh,
        child: PokemonListWidget(
          pokemons: favoritePokemons,
          showLoadingIndicator: false,
        ),
      );
    }

    // Initial state
    return const Center(
      child: CircularProgressIndicator(),
    );
  }
}
