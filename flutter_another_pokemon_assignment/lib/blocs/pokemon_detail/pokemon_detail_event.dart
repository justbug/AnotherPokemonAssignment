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

  const PokemonDetailLoadRequested({required this.pokemonId});

  @override
  List<Object> get props => [pokemonId];
}
