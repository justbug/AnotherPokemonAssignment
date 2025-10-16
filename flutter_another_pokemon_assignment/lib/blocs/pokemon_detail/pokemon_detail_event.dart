import 'package:equatable/equatable.dart';

/// Pokemon detail events
/// Define user actions and system-triggered events
abstract class PokemonDetailEvent extends Equatable {
  const PokemonDetailEvent();

  @override
  List<Object> get props => [];
}

/// Load Pokemon detail event
/// Corresponds to loading behavior when entering Pokemon detail page
class PokemonDetailLoadRequested extends PokemonDetailEvent {
  final String pokemonId;
  final String pokemonName;

  const PokemonDetailLoadRequested({
    required this.pokemonId,
    required this.pokemonName,
  });

  @override
  List<Object> get props => [pokemonId, pokemonName];
}

/// Pokemon detail favorite toggle event
/// Corresponds to favorite status change without reloading detail
class PokemonDetailFavoriteToggled extends PokemonDetailEvent {
  final bool isFavorite;

  const PokemonDetailFavoriteToggled({required this.isFavorite});

  @override
  List<Object> get props => [isFavorite];
}
