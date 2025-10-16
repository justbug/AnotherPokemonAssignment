import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../blocs/favorite/favorite_bloc.dart';
import '../blocs/favorite/favorite_state.dart';
import '../blocs/favorite/favorite_event.dart';

/// Favorite icon button widget
/// Independent favorite button, automatically binds to FavoriteBloc state
class FavoriteIconButton extends StatelessWidget {
  final String pokemonId;
  final String pokemonName;
  final String imageURL;

  const FavoriteIconButton({
    super.key,
    required this.pokemonId,
    required this.pokemonName,
    required this.imageURL,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<FavoriteBloc, FavoriteState>(
      buildWhen: (previous, current) {
        // Only rebuild when this Pokemon's favorite state changes
        return previous.isFavorite(pokemonId) != current.isFavorite(pokemonId);
      },
      builder: (context, state) {
        final isFavorite = state.isFavorite(pokemonId);
        return IconButton(
          icon: Icon(
            isFavorite ? Icons.favorite : Icons.favorite_border,
            color: isFavorite ? Colors.red : Colors.grey,
          ),
          onPressed: () {
            context.read<FavoriteBloc>().add(FavoriteToggled(
              pokemonId: pokemonId,
              pokemonName: pokemonName,
              imageURL: imageURL,
            ));
          },
        );
      },
    );
  }
}
