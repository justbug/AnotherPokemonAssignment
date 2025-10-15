import 'package:equatable/equatable.dart';
import '../../models/models.dart';

/// Pokemon list states
/// Define various UI states
abstract class PokemonListState extends Equatable {
  const PokemonListState();

  @override
  List<Object> get props => [];
}

/// Initial state
/// State when page first loads
class PokemonListInitial extends PokemonListState {
  const PokemonListInitial();
}

/// Loading state
/// State when first loading data
class PokemonListLoading extends PokemonListState {
  const PokemonListLoading();
}

/// Success state
/// State when data loads successfully
class PokemonListSuccess extends PokemonListState {
  final List<Pokemon> pokemons;
  final bool hasMore;
  final int currentOffset;

  const PokemonListSuccess({
    required this.pokemons,
    required this.hasMore,
    required this.currentOffset,
  });

  @override
  List<Object> get props => [pokemons, hasMore, currentOffset];

  /// Copy and update state
  PokemonListSuccess copyWith({
    List<Pokemon>? pokemons,
    bool? hasMore,
    int? currentOffset,
  }) {
    return PokemonListSuccess(
      pokemons: pokemons ?? this.pokemons,
      hasMore: hasMore ?? this.hasMore,
      currentOffset: currentOffset ?? this.currentOffset,
    );
  }
}

/// Loading more state
/// State when loading more data
class PokemonListLoadingMore extends PokemonListState {
  final List<Pokemon> pokemons;
  final bool hasMore;
  final int currentOffset;

  const PokemonListLoadingMore({
    required this.pokemons,
    required this.hasMore,
    required this.currentOffset,
  });

  @override
  List<Object> get props => [pokemons, hasMore, currentOffset];
}

/// Error state
/// State when loading fails
class PokemonListError extends PokemonListState {
  final String message;
  final List<Pokemon>? previousPokemons;

  const PokemonListError({
    required this.message,
    this.previousPokemons,
  });

  @override
  List<Object> get props => [message, previousPokemons ?? []];
}
