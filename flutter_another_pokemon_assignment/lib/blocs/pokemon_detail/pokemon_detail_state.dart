import 'package:equatable/equatable.dart';
import '../../models/models.dart';

/// Pokemon detail states
/// Define various UI states
abstract class PokemonDetailState extends Equatable {
  const PokemonDetailState();

  @override
  List<Object> get props => [];
}

/// Initial state
/// State when page first loads
class PokemonDetailInitial extends PokemonDetailState {
  const PokemonDetailInitial();
}

/// Loading state
/// State when loading Pokemon detail
class PokemonDetailLoading extends PokemonDetailState {
  const PokemonDetailLoading();
}

/// Success state
/// State when Pokemon detail loads successfully
class PokemonDetailSuccess extends PokemonDetailState {
  final Pokemon detail;

  const PokemonDetailSuccess({required this.detail});

  @override
  List<Object> get props => [detail];
}

/// Error state
/// State when loading Pokemon detail fails
class PokemonDetailError extends PokemonDetailState {
  final String message;

  const PokemonDetailError({required this.message});

  @override
  List<Object> get props => [message];
}
