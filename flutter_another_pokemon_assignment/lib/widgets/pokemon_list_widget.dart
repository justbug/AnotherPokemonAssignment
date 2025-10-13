import 'package:flutter/material.dart';
import '../models/pokemon.dart';

/// Pokemon 列表元件
/// 可重用的 Pokemon 列表顯示元件，支援不同的顯示狀態
class PokemonListWidget extends StatelessWidget {
  final List<Pokemon> pokemons;
  final ScrollController? scrollController;
  final bool showLoadingIndicator;
  final bool showError;
  final String? errorMessage;
  final Widget Function(BuildContext context, Pokemon pokemon, int index)? itemBuilder;

  const PokemonListWidget({
    super.key,
    required this.pokemons,
    this.scrollController,
    this.showLoadingIndicator = false,
    this.showError = false,
    this.errorMessage,
    this.itemBuilder,
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
        final pokemon = pokemons[index];
        
        // 使用自定義的 itemBuilder 或預設的樣式
        if (itemBuilder != null) {
          return itemBuilder!(context, pokemon, index);
        }

        return _buildDefaultPokemonTile(pokemon);
      },
    );
  }

  /// 建立預設的 Pokemon 列表項目
  Widget _buildDefaultPokemonTile(Pokemon pokemon) {
    return ListTile(
      title: Text(pokemon.name),
      subtitle: Text('ID: ${pokemon.id}')
    );
  }
}
