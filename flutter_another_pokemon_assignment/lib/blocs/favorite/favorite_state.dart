import 'package:equatable/equatable.dart';

/// Favorite states
abstract class FavoriteState extends Equatable {
  const FavoriteState();

  /// Get favorite id set for all Pokemon
  Set<String> get favoritePokemonIds;

  /// Current Pokemon ID being viewed/processed
  String? get currentPokemonId;

  /// Check if specific Pokemon is favorite
  bool isFavorite(String pokemonId) => favoritePokemonIds.contains(pokemonId);

  @override
  List<Object?> get props => [favoritePokemonIds, currentPokemonId];
}

/// Initial state
class FavoriteInitial extends FavoriteState {
  @override
  final Set<String> favoritePokemonIds;

  @override
  final String? currentPokemonId;

  const FavoriteInitial({
    this.favoritePokemonIds = const <String>{},
    this.currentPokemonId,
  });

  @override
  List<Object?> get props => [favoritePokemonIds, currentPokemonId];
}

/// Success state
class FavoriteSuccess extends FavoriteState {
  @override
  final Set<String> favoritePokemonIds;
  final bool toggledPokemonFavoriteStatus;

  @override
  final String? currentPokemonId;

  const FavoriteSuccess({
    this.favoritePokemonIds = const <String>{},
    required this.toggledPokemonFavoriteStatus,
    this.currentPokemonId,
  });

  @override
  List<Object?> get props => [
    favoritePokemonIds,
    toggledPokemonFavoriteStatus,
    currentPokemonId,
  ];
}

/// Error state
class FavoriteError extends FavoriteState {
  final String message;
  @override
  final Set<String> favoritePokemonIds;

  @override
  final String? currentPokemonId;

  const FavoriteError({
    required this.message,
    required this.favoritePokemonIds,
    this.currentPokemonId,
  });

  @override
  List<Object?> get props => [message, favoritePokemonIds, currentPokemonId];
}
