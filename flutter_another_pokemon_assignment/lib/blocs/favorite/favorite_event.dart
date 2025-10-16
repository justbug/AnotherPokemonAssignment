import 'package:equatable/equatable.dart';

/// Favorite events
abstract class FavoriteEvent extends Equatable {
  const FavoriteEvent();

  @override
  List<Object> get props => [];
}

/// Load all favorite states event
class FavoriteLoadAllRequested extends FavoriteEvent {
  const FavoriteLoadAllRequested();
}


/// Toggle favorite state event
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

