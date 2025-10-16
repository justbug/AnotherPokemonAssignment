import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../blocs/favorite/favorite_bloc.dart';
import '../blocs/favorite/favorite_event.dart';

/// Favorite icon button widget
/// Simple button that triggers FavoriteBloc events
/// The page-level BlocListener will handle updating other BLoCs
class FavoriteIconButton extends StatelessWidget {
  final String pokemonId;
  final String pokemonName;
  final String imageURL;
  final bool isFavorite;

  const FavoriteIconButton({
    super.key,
    required this.pokemonId,
    required this.pokemonName,
    required this.imageURL,
    required this.isFavorite,
  });

  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: Icon(
        isFavorite ? Icons.favorite : Icons.favorite_border,
        color: isFavorite ? Colors.red : Colors.grey,
      ),
      onPressed: () {
        // Only trigger FavoriteBloc event
        // The page-level BlocListener will handle updating other BLoCs
        context.read<FavoriteBloc>().add(FavoriteToggled(
          pokemonId: pokemonId,
          pokemonName: pokemonName,
          imageURL: imageURL,
        ));
      },
    );
  }
}
