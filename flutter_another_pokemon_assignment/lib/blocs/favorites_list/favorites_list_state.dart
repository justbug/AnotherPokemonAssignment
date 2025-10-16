import 'package:equatable/equatable.dart';
import '../../models/pokemon.dart';

/// Favorites List states
/// Define various states for favorites list page
abstract class FavoritesListState extends Equatable {
  const FavoritesListState();

  @override
  List<Object> get props => [];
}

/// Initial state
/// State when page first loads
class FavoritesListInitial extends FavoritesListState {
  const FavoritesListInitial();
}

/// Loading state
/// State when loading favorites list data
class FavoritesListLoading extends FavoritesListState {
  const FavoritesListLoading();
}

/// Success state
/// State when favorites list loads successfully
class FavoritesListSuccess extends FavoritesListState {
  final List<Pokemon> favoritePokemons;

  const FavoritesListSuccess({
    required this.favoritePokemons,
  });

  @override
  List<Object> get props => [favoritePokemons];

  /// Copy and update state
  FavoritesListSuccess copyWith({
    List<Pokemon>? favoritePokemons,
  }) {
    return FavoritesListSuccess(
      favoritePokemons: favoritePokemons ?? this.favoritePokemons,
    );
  }
}

/// Error state
/// State when loading favorites list fails
class FavoritesListError extends FavoritesListState {
  final String message;
  final List<Pokemon>? previousFavoritePokemons;

  const FavoritesListError({
    required this.message,
    this.previousFavoritePokemons,
  });

  @override
  List<Object> get props => [message, previousFavoritePokemons ?? []];
}
