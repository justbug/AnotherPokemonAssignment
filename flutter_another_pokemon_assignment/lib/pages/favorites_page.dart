import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../blocs/blocs.dart';
import '../models/pokemon.dart';
import '../widgets/pokemon_list_widget.dart';

/// 收藏列表頁面
/// 顯示用戶收藏的 Pokemon 列表，按收藏時間排序
class FavoritesPage extends StatefulWidget {
  const FavoritesPage({super.key});

  @override
  State<FavoritesPage> createState() => _FavoritesPageState();
}

class _FavoritesPageState extends State<FavoritesPage> {
  @override
  void initState() {
    super.initState();
    // 觸發初始載入
    context.read<FavoritesListBloc>().add(const FavoritesListLoadRequested());
  }

  /// 處理下拉刷新
  Future<void> _onRefresh() async {
    // 重新載入收藏狀態
    context.read<FavoriteBloc>().add(const FavoriteLoadAllRequested());
    // 重新載入收藏列表
    context.read<FavoritesListBloc>().add(const FavoritesListRefreshRequested());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('收藏列表'),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),
      body: BlocListener<FavoriteBloc, FavoriteState>(
        listener: (context, state) {
          // 當收藏狀態改變時，重新載入收藏列表
          if (state is FavoriteSuccess) {
            context.read<FavoritesListBloc>().add(const FavoritesListRefreshRequested());
          }
        },
        child: BlocBuilder<FavoritesListBloc, FavoritesListState>(
          builder: (context, state) => _buildBody(state),
        ),
      ),
    );
  }

  Widget _buildBody(FavoritesListState state) {
    if (state is FavoritesListLoading) {
      return const Center(
        child: CircularProgressIndicator(),
      );
    }

    if (state is FavoritesListError) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(
              Icons.error_outline,
              size: 64,
              color: Colors.red,
            ),
            const SizedBox(height: 16),
            Text(
              state.message,
              style: const TextStyle(color: Colors.red),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                context.read<FavoritesListBloc>().add(const FavoritesListLoadRequested());
              },
              child: const Text('重試'),
            ),
          ],
        ),
      );
    }

    if (state is FavoritesListSuccess) {
      // 將 LocalPokemon 轉換為 Pokemon
      final favoritePokemons = state.favoritePokemons.map((localPokemon) => Pokemon(
        id: localPokemon.id,
        name: localPokemon.name,
        imageURL: localPokemon.imageURL,
      )).toList();

      if (favoritePokemons.isEmpty) {
        return RefreshIndicator(
          onRefresh: _onRefresh,
          child: SingleChildScrollView(
            physics: const AlwaysScrollableScrollPhysics(),
            child: SizedBox(
              height: MediaQuery.of(context).size.height * 0.7,
              child: const Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.favorite_border,
                      size: 64,
                      color: Colors.grey,
                    ),
                    SizedBox(height: 16),
                    Text(
                      '尚無收藏的 Pokemon',
                      style: TextStyle(
                        fontSize: 18,
                        color: Colors.grey,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      }

      return RefreshIndicator(
        onRefresh: _onRefresh,
        child: PokemonListWidget(
          pokemons: favoritePokemons,
          showLoadingIndicator: false,
        ),
      );
    }

    // 初始狀態
    return const Center(
      child: CircularProgressIndicator(),
    );
  }
}
