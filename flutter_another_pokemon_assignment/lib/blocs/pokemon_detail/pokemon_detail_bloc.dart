import 'package:flutter_bloc/flutter_bloc.dart';
import '../../repository/detail_repository.dart';
import 'pokemon_detail_event.dart';
import 'pokemon_detail_state.dart';

/// Pokemon detail BLoC
/// Handles Pokemon detail business logic
class PokemonDetailBloc extends Bloc<PokemonDetailEvent, PokemonDetailState> {
  final DetailRepositorySpec _detailRepository;

  PokemonDetailBloc({DetailRepositorySpec? detailRepository}) 
      : _detailRepository = detailRepository ?? DetailRepository(),
        super(const PokemonDetailInitial()) {
    on<PokemonDetailLoadRequested>(_onLoadRequested);
  }

  /// Handle load Pokemon detail event
  Future<void> _onLoadRequested(
    PokemonDetailLoadRequested event,
    Emitter<PokemonDetailState> emit,
  ) async {
    emit(const PokemonDetailLoading());
    
    try {
      final detail = await _detailRepository.fetchDetail(event.pokemonId);
      emit(PokemonDetailSuccess(detail: detail));
    } catch (e) {
      emit(PokemonDetailError(
        message: 'Failed to load Pokemon detail: $e',
      ));
    }
  }
}
