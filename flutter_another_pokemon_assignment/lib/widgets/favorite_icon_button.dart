import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../blocs/favorite/favorite_bloc.dart';
import '../blocs/favorite/favorite_state.dart';
import '../blocs/favorite/favorite_event.dart';

/// 最愛按鈕元件
/// 獨立的最愛按鈕，自動綁定 FavoriteBloc 狀態
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
        // 只有當此 Pokemon 的最愛狀態改變時才重建
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
