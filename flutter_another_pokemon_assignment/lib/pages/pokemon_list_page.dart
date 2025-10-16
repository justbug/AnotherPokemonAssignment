import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../blocs/blocs.dart';
import '../widgets/pokemon_list_widget.dart';

/// Pokemon list page
/// Uses BLoC pattern to manage state, supports pull-to-refresh and load more on scroll
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
    
    // Load all favorite states
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<FavoriteBloc>().add(const FavoriteLoadAllRequested());
    });
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  /// Listen to scroll events, load more data when near bottom
  void _onScroll() {
    if (_scrollController.position.pixels >= 
        _scrollController.position.maxScrollExtent - 200) {
      context.read<PokemonListBloc>().add(const PokemonListLoadMoreRequested());
    }
  }

  /// Handle pull-to-refresh
  Future<void> _onRefresh() async {
    context.read<PokemonListBloc>().add(const PokemonListRefreshRequested());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Pokemon List'),
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
              child: PokemonListWidget(
                pokemons: state.pokemons,
                scrollController: _scrollController,
                showLoadingIndicator: state.hasMore,
              ),
            );
          }

          if (state is PokemonListLoadingMore) {
            return RefreshIndicator(
              onRefresh: _onRefresh,
              child: PokemonListWidget(
                pokemons: state.pokemons,
                scrollController: _scrollController,
                showLoadingIndicator: true,
              ),
            );
          }

          if (state is PokemonListError) {
            return RefreshIndicator(
              onRefresh: _onRefresh,
              child: PokemonListWidget(
                pokemons: state.previousPokemons ?? [],
                scrollController: _scrollController,
                showError: true,
                errorMessage: 'Load failed, please pull to refresh',
              ),
            );
          }

          return const Center(
            child: Text('Unknown state'),
          );
        },
      ),
    );
  }
}
