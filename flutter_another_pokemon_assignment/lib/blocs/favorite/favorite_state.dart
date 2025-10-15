import 'package:equatable/equatable.dart';

/// Favorite states
abstract class FavoriteState extends Equatable {
  const FavoriteState();

  /// Get favorite status for all Pokemon
  Map<String, bool> get favoriteStatus;

  /// Check if specific Pokemon is favorite
  bool isFavorite(String pokemonId) {
    return favoriteStatus[pokemonId] ?? false;
  }

  @override
  List<Object> get props => [favoriteStatus];
}



/// Success state (includes initial state)
class FavoriteSuccess extends FavoriteState {
  @override
  final Map<String, bool> favoriteStatus;

  const FavoriteSuccess({this.favoriteStatus = const {}});

  @override
  List<Object> get props => [favoriteStatus];
}

/// Error state
class FavoriteError extends FavoriteState {
  final String message;
  @override
  final Map<String, bool> favoriteStatus;

  const FavoriteError({
    required this.message,
    required this.favoriteStatus,
  });

  @override
  List<Object> get props => [message, favoriteStatus];
}
