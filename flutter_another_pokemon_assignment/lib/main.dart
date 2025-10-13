import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'blocs/blocs.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Pokemon List',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
        useMaterial3: true,
      ),
      home: BlocProvider(
        create: (context) => PokemonListBloc()..add(const PokemonListLoadRequested()),
        child: const PokemonListPage(),
      ),
    );
  }
}

/// Pokemon 列表頁面
/// 使用 BLoC 模式管理狀態，支援下拉刷新和上拉載入更多
class PokemonListPage extends StatefulWidget {
  const PokemonListPage({super.key});

  @override
  State<PokemonListPage> createState() => _PokemonListPageState();
}

class _PokemonListPageState extends State<PokemonListPage> {
  late ScrollController _scrollController;

  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController();
    _scrollController.addListener(_onScroll);
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  /// 監聽滾動事件，當接近底部時載入更多資料
  void _onScroll() {
    if (_scrollController.position.pixels >= 
        _scrollController.position.maxScrollExtent - 200) {
      context.read<PokemonListBloc>().add(const PokemonListLoadMoreRequested());
    }
  }

  /// 處理下拉刷新
  Future<void> _onRefresh() async {
    context.read<PokemonListBloc>().add(const PokemonListRefreshRequested());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Pokemon 列表'),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),
      body: BlocConsumer<PokemonListBloc, PokemonListState>(
        listener: (context, state) {
          if (state is PokemonListError) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(state.message),
                backgroundColor: Colors.red,
              ),
            );
          }
        },
        builder: (context, state) {
          if (state is PokemonListInitial || state is PokemonListLoading) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }

          if (state is PokemonListSuccess) {
            return RefreshIndicator(
              onRefresh: _onRefresh,
              child: ListView.builder(
                controller: _scrollController,
                itemCount: state.pokemons.length + (state.hasMore ? 1 : 0),
                itemBuilder: (context, index) {
                  if (index >= state.pokemons.length) {
                    return const Padding(
                      padding: EdgeInsets.all(16.0),
                      child: Center(
                        child: CircularProgressIndicator(),
                      ),
                    );
                  }

                  final pokemon = state.pokemons[index];
                  return ListTile(
                    title: Text(pokemon.name),
                    subtitle: Text('ID: ${pokemon.id}'),
                    leading: CircleAvatar(
                      child: Text(pokemon.id),
                    ),
                  );
                },
              ),
            );
          }

          if (state is PokemonListLoadingMore) {
            return RefreshIndicator(
              onRefresh: _onRefresh,
              child: ListView.builder(
                controller: _scrollController,
                itemCount: state.pokemons.length + 1,
                itemBuilder: (context, index) {
                  if (index >= state.pokemons.length) {
                    return const Padding(
                      padding: EdgeInsets.all(16.0),
                      child: Center(
                        child: CircularProgressIndicator(),
                      ),
                    );
                  }

                  final pokemon = state.pokemons[index];
                  return ListTile(
                    title: Text(pokemon.name),
                    subtitle: Text('ID: ${pokemon.id}'),
                    leading: CircleAvatar(
                      child: Text(pokemon.id),
                    ),
                  );
                },
              ),
            );
          }

          if (state is PokemonListError) {
            return RefreshIndicator(
              onRefresh: _onRefresh,
              child: ListView.builder(
                controller: _scrollController,
                itemCount: (state.previousPokemons?.length ?? 0) + 1,
                itemBuilder: (context, index) {
                  if (index >= (state.previousPokemons?.length ?? 0)) {
                    return const Center(
                      child: Padding(
                        padding: EdgeInsets.all(16.0),
                        child: Text(
                          '載入失敗，請下拉刷新重試',
                          style: TextStyle(color: Colors.red),
                        ),
                      ),
                    );
                  }

                  final pokemon = state.previousPokemons![index];
                  return ListTile(
                    title: Text(pokemon.name),
                    subtitle: Text('ID: ${pokemon.id}'),
                    leading: CircleAvatar(
                      child: Text(pokemon.id),
                    ),
                  );
                },
              ),
            );
          }

          return const Center(
            child: Text('未知狀態'),
          );
        },
      ),
    );
  }
}
