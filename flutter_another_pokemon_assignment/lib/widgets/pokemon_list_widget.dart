import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:cached_network_image/cached_network_image.dart';
import '../models/pokemon.dart';
import '../blocs/blocs.dart';
import '../pages/pokemon_detail_page.dart';
import 'favorite_icon_button.dart';

/// Pokemon list widget
/// Reusable Pokemon list display component, supports different display states
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
        // Show loading indicator
        if (showLoadingIndicator && index >= pokemons.length) {
          return const Padding(
            padding: EdgeInsets.all(16.0),
            child: Center(
              child: CircularProgressIndicator(),
            ),
          );
        }

        // Show error message
        if (showError && index >= pokemons.length) {
          return Center(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Text(
                errorMessage ?? 'Load failed, please pull to refresh',
                style: const TextStyle(color: Colors.red),
              ),
            ),
          );
        }

        // Show Pokemon items
        return _buildDefaultPokemonTile(context, pokemons[index]);
      },
    );
  }

  /// Build default Pokemon list item
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
        isFavorite: pokemon.isFavorite,
      ),
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => BlocProvider(
              create: (context) => PokemonDetailBloc()
                ..add(PokemonDetailLoadRequested(
                  pokemonId: pokemon.id,
                  pokemonName: pokemon.name,
                )),
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
