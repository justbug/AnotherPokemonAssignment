import 'package:equatable/equatable.dart';

/// Pokemon list events
/// Define user actions and system-triggered events
abstract class PokemonListEvent extends Equatable {
  const PokemonListEvent();

  @override
  List<Object> get props => [];
}

/// Initial load event
/// Corresponds to loading behavior when first entering the page
class PokemonListLoadRequested extends PokemonListEvent {
  const PokemonListLoadRequested();
}

/// Pull-to-refresh event
/// Corresponds to user pulling to refresh the list
class PokemonListRefreshRequested extends PokemonListEvent {
  const PokemonListRefreshRequested();
}

/// Load more event
/// Corresponds to user scrolling to bottom to load more data
class PokemonListLoadMoreRequested extends PokemonListEvent {
  const PokemonListLoadMoreRequested();
}

/// Update favorite status for a specific Pokemon
class PokemonListFavoriteToggled extends PokemonListEvent {
  final String pokemonId;
  final bool isFavorite;

  const PokemonListFavoriteToggled({
    required this.pokemonId,
    required this.isFavorite,
  });

  @override
  List<Object> get props => [pokemonId, isFavorite];
}
