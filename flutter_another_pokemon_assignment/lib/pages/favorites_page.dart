import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../blocs/blocs.dart';
import '../widgets/pokemon_list_widget.dart';

/// Favorites list page
/// Shows user's favorite Pokemon list, sorted by favorite time
class FavoritesPage extends StatelessWidget {
  const FavoritesPage({super.key});

  /// Handle pull-to-refresh
  Future<void> _onRefresh(BuildContext context) async {
    context.read<FavoritesListBloc>().add(
      const FavoritesListRefreshRequested(),
    );
  }

  void _onRetry(BuildContext context) {
    context.read<FavoritesListBloc>().add(const FavoritesListLoadRequested());
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
          if (state is FavoriteSuccess) {
            context.read<FavoritesListBloc>().add(
              const FavoritesListRefreshRequested(),
            );
          }
        },
        child: BlocBuilder<FavoritesListBloc, FavoritesListState>(
          builder: (context, state) => _buildBody(context, state),
        ),
      ),
    );
  }

  Widget _buildBody(BuildContext context, FavoritesListState state) {
    if (state is FavoritesListLoading) {
      return const Center(child: CircularProgressIndicator());
    }

    if (state is FavoritesListError) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.error_outline, size: 64, color: Colors.red),
            const SizedBox(height: 16),
            Text(
              state.message,
              style: const TextStyle(color: Colors.red),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: () => _onRetry(context),
              child: const Text('Retry'),
            ),
          ],
        ),
      );
    }

    if (state is FavoritesListSuccess) {
      // Use Pokemon directly from state
      final favoritePokemons = state.favoritePokemons;

      if (favoritePokemons.isEmpty) {
        return RefreshIndicator(
          onRefresh: () => _onRefresh(context),
          child: SingleChildScrollView(
            physics: const AlwaysScrollableScrollPhysics(),
            child: SizedBox(
              height: MediaQuery.of(context).size.height * 0.7,
              child: const Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.favorite_border, size: 64, color: Colors.grey),
                    SizedBox(height: 16),
                    Text(
                      'No favorite Pokemon yet',
                      style: TextStyle(fontSize: 18, color: Colors.grey),
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      }

      return RefreshIndicator(
        onRefresh: () => _onRefresh(context),
        child: PokemonListWidget(
          pokemons: favoritePokemons,
          showLoadingIndicator: false,
        ),
      );
    }

    // Initial state
    return const Center(child: CircularProgressIndicator());
  }
}
