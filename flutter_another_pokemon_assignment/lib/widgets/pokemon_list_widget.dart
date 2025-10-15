import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:cached_network_image/cached_network_image.dart';
import '../models/pokemon.dart';
import '../blocs/blocs.dart';
import '../pages/pokemon_detail_page.dart';
import 'favorite_icon_button.dart';

/// Pokemon 列表元件
/// 可重用的 Pokemon 列表顯示元件，支援不同的顯示狀態
class PokemonListWidget extends StatelessWidget {
  final List<Pokemon> pokemons;
  final ScrollController? scrollController;
  final bool showLoadingIndicator;
  final bool showError;
  final String? errorMessage;

  const PokemonListWidget({
    super.key,
    required this.pokemons,
    this.scrollController,
    this.showLoadingIndicator = false,
    this.showError = false,
    this.errorMessage,
  });

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      controller: scrollController,
      itemCount: pokemons.length + (showLoadingIndicator || showError ? 1 : 0),
      itemBuilder: (context, index) {
        // 顯示載入指示器
        if (showLoadingIndicator && index >= pokemons.length) {
          return const Padding(
            padding: EdgeInsets.all(16.0),
            child: Center(
              child: CircularProgressIndicator(),
            ),
          );
        }

        // 顯示錯誤訊息
        if (showError && index >= pokemons.length) {
          return Center(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Text(
                errorMessage ?? '載入失敗，請下拉刷新重試',
                style: const TextStyle(color: Colors.red),
              ),
            ),
          );
        }

        // 顯示 Pokemon 項目
        return _buildDefaultPokemonTile(context, pokemons[index]);
      },
    );
  }

  /// 建立預設的 Pokemon 列表項目
  Widget _buildDefaultPokemonTile(BuildContext context, Pokemon pokemon) {
    return ListTile(
      leading: CachedNetworkImage(
        imageUrl: pokemon.imageURL,
        width: 60,
        height: 60,
        errorWidget: (context, url, error) => const Icon(Icons.error),
      ),
      title: Text(pokemon.name),
      subtitle: Text('ID: ${pokemon.id}'),
      trailing: FavoriteIconButton(
        pokemonId: pokemon.id,
        pokemonName: pokemon.name,
        imageURL: pokemon.imageURL,
      ),
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => BlocProvider(
              create: (context) => PokemonDetailBloc()
                ..add(PokemonDetailLoadRequested(pokemonId: pokemon.id)),
              child: PokemonDetailPage(
                pokemonId: pokemon.id,
                pokemonName: pokemon.name,
                imageURL: pokemon.imageURL,
              ),
            ),
          ),
        );
      },
    );
  }
}
