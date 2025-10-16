import 'package:equatable/equatable.dart';

/// Favorite states
abstract class FavoriteState extends Equatable {
  const FavoriteState();

  /// Get favorite status for all Pokemon
  Map<String, bool> get favoriteStatus;

  /// Current Pokemon ID being viewed/processed
  String? get currentPokemonId;

  /// Check if specific Pokemon is favorite
  bool isFavorite(String pokemonId) {
    return favoriteStatus[pokemonId] ?? false;
  }

  @override
  List<Object?> get props => [favoriteStatus, currentPokemonId];
}



/// Initial state
class FavoriteInitial extends FavoriteState {
  @override
  final Map<String, bool> favoriteStatus;
  
  @override
  final String? currentPokemonId;

  const FavoriteInitial({
    this.favoriteStatus = const {},
    this.currentPokemonId,
  });

  @override
  List<Object?> get props => [favoriteStatus, currentPokemonId];
}

/// Success state
class FavoriteSuccess extends FavoriteState {
  @override
  final Map<String, bool> favoriteStatus;
  final String toggledPokemonId;
  final bool toggledPokemonFavoriteStatus;
  
  @override
  final String? currentPokemonId;

  const FavoriteSuccess({
    this.favoriteStatus = const {},
    required this.toggledPokemonId,
    required this.toggledPokemonFavoriteStatus,
    this.currentPokemonId,
  });

  @override
  List<Object?> get props => [favoriteStatus, toggledPokemonId, toggledPokemonFavoriteStatus, currentPokemonId];
}

/// Error state
class FavoriteError extends FavoriteState {
  final String message;
  @override
  final Map<String, bool> favoriteStatus;
  
  @override
  final String? currentPokemonId;

  const FavoriteError({
    required this.message,
    required this.favoriteStatus,
    this.currentPokemonId,
  });

  @override
  List<Object?> get props => [message, favoriteStatus, currentPokemonId];
}
