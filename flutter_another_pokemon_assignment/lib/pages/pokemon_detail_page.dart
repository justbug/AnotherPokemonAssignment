import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:cached_network_image/cached_network_image.dart';
import '../blocs/blocs.dart';
import '../widgets/favorite_icon_button.dart';

/// Pokemon detail page
/// Shows complete Pokemon detail information, includes favorite functionality
class PokemonDetailPage extends StatelessWidget {
  final String pokemonId;
  final String pokemonName;
  final String imageURL;

  const PokemonDetailPage({
    super.key,
    required this.pokemonId,
    required this.pokemonName,
    required this.imageURL,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(pokemonName),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        actions: [
          FavoriteIconButton(
            pokemonId: pokemonId,
            pokemonName: pokemonName,
            imageURL: imageURL,
          ),
        ],
      ),
      body: BlocConsumer<PokemonDetailBloc, PokemonDetailState>(
        listener: (context, state) {
          if (state is PokemonDetailError) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(state.message),
                backgroundColor: Colors.red,
              ),
            );
          }
        },
        builder: (context, state) {
          if (state is PokemonDetailInitial || state is PokemonDetailLoading) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }

          if (state is PokemonDetailSuccess) {
            return _buildDetailContent(context, state.detail);
          }

          if (state is PokemonDetailError) {
            return _buildErrorContent(context, state.message);
          }

          return const Center(
            child: Text('Unknown state'),
          );
        },
      ),
    );
  }

  /// Build detail content
  Widget _buildDetailContent(BuildContext context, detail) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Pokemon image
          Center(
            child: Container(
              width: 200,
              height: 200,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withValues(alpha: 0.3),
                    spreadRadius: 2,
                    blurRadius: 8,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: CachedNetworkImage(
                  imageUrl: detail.imageUrl ?? imageURL,
                  fit: BoxFit.cover,
                  placeholder: (context, url) => const Center(
                    child: CircularProgressIndicator(),
                  ),
                  errorWidget: (context, url, error) => const Icon(
                    Icons.error,
                    size: 50,
                    color: Colors.grey,
                  ),
                ),
              ),
            ),
          ),
          
          const SizedBox(height: 24),
          
          // Basic information
          _buildInfoCard(
            context,
            'Basic Information',
            [
              _buildInfoRow('ID', detail.id.toString()),
              _buildInfoRow('Weight', '${detail.weight / 10} kg'),
              _buildInfoRow('Height', '${detail.height / 10} m'),
            ],
          ),
          
          const SizedBox(height: 16),
          
          // Type information
          _buildInfoCard(
            context,
            'Types',
            [
              _buildTypeRow(detail.types),
            ],
          ),
        ],
      ),
    );
  }

  /// Build error content
  Widget _buildErrorContent(BuildContext context, String message) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
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
              message,
              style: const TextStyle(
                fontSize: 16,
                color: Colors.red,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                context.read<PokemonDetailBloc>().add(
                  PokemonDetailLoadRequested(pokemonId: pokemonId),
                );
              },
              child: const Text('Retry'),
            ),
          ],
        ),
      ),
    );
  }

  /// Build info card
  Widget _buildInfoCard(BuildContext context, String title, List<Widget> children) {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: Theme.of(context).textTheme.titleLarge?.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 12),
            ...children,
          ],
        ),
      ),
    );
  }

  /// Build info row
  Widget _buildInfoRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: const TextStyle(
              fontWeight: FontWeight.w500,
              fontSize: 16,
            ),
          ),
          Text(
            value,
            style: const TextStyle(
              fontSize: 16,
              color: Colors.grey,
            ),
          ),
        ],
      ),
    );
  }

  /// Build type row
  Widget _buildTypeRow(List<String> types) {
    return Wrap(
      spacing: 8.0,
      runSpacing: 8.0,
      children: types.map((type) => Chip(
        label: Text(
          type,
          style: const TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.w500,
          ),
        ),
        backgroundColor: _getTypeColor(type),
      )).toList(),
    );
  }

  /// Get color based on type
  Color _getTypeColor(String type) {
    switch (type.toLowerCase()) {
      case 'fire':
        return Colors.red;
      case 'water':
        return Colors.blue;
      case 'grass':
        return Colors.green;
      case 'electric':
        return Colors.yellow.shade700;
      case 'psychic':
        return Colors.purple;
      case 'ice':
        return Colors.cyan;
      case 'dragon':
        return Colors.indigo;
      case 'dark':
        return Colors.brown;
      case 'fairy':
        return Colors.pink;
      case 'fighting':
        return Colors.orange;
      case 'flying':
        return Colors.lightBlue;
      case 'poison':
        return Colors.deepPurple;
      case 'ground':
        return Colors.brown.shade300;
      case 'rock':
        return Colors.grey;
      case 'bug':
        return Colors.lightGreen;
      case 'ghost':
        return Colors.deepPurple.shade300;
      case 'steel':
        return Colors.grey.shade400;
      case 'normal':
        return Colors.grey.shade500;
      default:
        return Colors.grey;
    }
  }
}
