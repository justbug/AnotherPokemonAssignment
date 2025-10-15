import 'package:flutter_bloc/flutter_bloc.dart';
import '../../repository/detail_repository.dart';
import 'pokemon_detail_event.dart';
import 'pokemon_detail_state.dart';

/// Pokemon 詳細資訊 BLoC
/// 處理 Pokemon 詳細資訊的業務邏輯
class PokemonDetailBloc extends Bloc<PokemonDetailEvent, PokemonDetailState> {
  final DetailRepositorySpec _detailRepository;

  PokemonDetailBloc({DetailRepositorySpec? detailRepository}) 
      : _detailRepository = detailRepository ?? DetailRepository(),
        super(const PokemonDetailInitial()) {
    on<PokemonDetailLoadRequested>(_onLoadRequested);
  }

  /// 處理載入 Pokemon 詳細資訊事件
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
        message: '載入 Pokemon 詳細資訊失敗: $e',
      ));
    }
  }
}
