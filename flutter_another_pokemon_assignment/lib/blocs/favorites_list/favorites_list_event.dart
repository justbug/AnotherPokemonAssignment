import 'package:equatable/equatable.dart';

/// Favorites List events
/// Define user actions and system-triggered events for favorites list page
abstract class FavoritesListEvent extends Equatable {
  const FavoritesListEvent();

  @override
  List<Object> get props => [];
}

/// Initial load event
/// Corresponds to loading behavior when first entering favorites page
class FavoritesListLoadRequested extends FavoritesListEvent {
  const FavoritesListLoadRequested();
}

/// Pull-to-refresh event
/// Corresponds to user pulling to refresh favorites list
class FavoritesListRefreshRequested extends FavoritesListEvent {
  const FavoritesListRefreshRequested();
}
