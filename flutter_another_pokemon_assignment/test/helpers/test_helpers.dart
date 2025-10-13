import 'dart:collection';

import '../../lib/models/models.dart';
import '../../lib/repository/list_repository.dart';

class MockListRepository implements ListRepositorySpec {
  final Map<int, Queue<_MockResponse>> _responses = {};
  final List<int> requestedOffsets = [];

  void queuePokemons({
    required int offset,
    required List<Pokemon> pokemons,
  }) {
    final queue = _responses.putIfAbsent(offset, () => Queue<_MockResponse>());
    queue.add(_MockResponse(pokemons: pokemons));
  }

  void queueError({
    required int offset,
    required Exception exception,
  }) {
    final queue = _responses.putIfAbsent(offset, () => Queue<_MockResponse>());
    queue.add(_MockResponse(exception: exception));
  }

  void reset() {
    _responses.clear();
    requestedOffsets.clear();
  }

  @override
  Future<List<Pokemon>> fetchList({int offset = 0}) async {
    requestedOffsets.add(offset);
    final queue = _responses[offset];
    if (queue == null || queue.isEmpty) {
      throw Exception('No mock response configured for offset $offset');
    }

    final response = queue.removeFirst();
    if (response.exception != null) {
      throw response.exception!;
    }

    return response.pokemons!;
  }
}

class _MockResponse {
  const _MockResponse({this.pokemons, this.exception});

  final List<Pokemon>? pokemons;
  final Exception? exception;
}

class TestPokemonFactory {
  static List<Pokemon> createPokemonList(int count, {int startId = 1}) {
    return List.generate(
      count,
      (index) => Pokemon(
        name: 'pokemon-${startId + index}',
        id: '${startId + index}',
      ),
    );
  }
}
