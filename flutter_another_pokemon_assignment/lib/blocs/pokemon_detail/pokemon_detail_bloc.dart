import 'package:flutter_bloc/flutter_bloc.dart';
import '../../repository/detail_repository.dart';
import '../../repository/favorite_pokemon_repository.dart';
import 'pokemon_detail_event.dart';
import 'pokemon_detail_state.dart';

/// Pokemon detail BLoC
/// Handles Pokemon detail business logic
class PokemonDetailBloc extends Bloc<PokemonDetailEvent, PokemonDetailState> {
  final DetailRepositorySpec _detailRepository;
  final FavoritePokemonRepository _favoriteRepository;

  PokemonDetailBloc({
    DetailRepositorySpec? detailRepository,
    FavoritePokemonRepository? favoriteRepository,
  }) : _detailRepository = detailRepository ?? DetailRepository(),
       _favoriteRepository = favoriteRepository ?? FavoritePokemonRepository(),
        super(const PokemonDetailInitial()) {
    on<PokemonDetailLoadRequested>(_onLoadRequested);
    on<PokemonDetailFavoriteToggled>(_onFavoriteToggled);
  }

  /// Handle load Pokemon detail event
  Future<void> _onLoadRequested(
    PokemonDetailLoadRequested event,
    Emitter<PokemonDetailState> emit,
  ) async {
    emit(const PokemonDetailLoading());
    
    try {
      final detail = await _detailRepository.fetchDetail(event.pokemonId);
      
      // Load favorite status and set isFavorite
      final isFavorite = await _favoriteRepository.isFavorite(event.pokemonId);
      final detailWithFavorite = detail.copyWith(isFavorite: isFavorite);
      
      emit(PokemonDetailSuccess(detail: detailWithFavorite));
    } catch (e) {
      emit(PokemonDetailError(
        message: 'Failed to load Pokemon detail: $e',
      ));
    }
  }

  /// Handle favorite toggle event
  Future<void> _onFavoriteToggled(
    PokemonDetailFavoriteToggled event,
    Emitter<PokemonDetailState> emit,
  ) async {
    final currentState = state;
    if (currentState is! PokemonDetailSuccess) {
      return;
    }

    final updatedDetail = currentState.detail.copyWith(
      isFavorite: event.isFavorite,
    );

    emit(PokemonDetailSuccess(detail: updatedDetail));
  }
}
