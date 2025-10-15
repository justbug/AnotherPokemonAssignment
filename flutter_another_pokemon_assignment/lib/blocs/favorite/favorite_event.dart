import 'package:equatable/equatable.dart';

/// Favorite 事件
abstract class FavoriteEvent extends Equatable {
  const FavoriteEvent();

  @override
  List<Object> get props => [];
}

/// 載入所有最愛狀態事件
class FavoriteLoadAllRequested extends FavoriteEvent {
  const FavoriteLoadAllRequested();
}


/// 切換最愛狀態事件
class FavoriteToggled extends FavoriteEvent {
  final String pokemonId;
  final String pokemonName;
  final String imageURL;
  
  const FavoriteToggled({
    required this.pokemonId,
    required this.pokemonName,
    required this.imageURL,
  });
  
  @override
  List<Object> get props => [pokemonId, pokemonName, imageURL];
}

