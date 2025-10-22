import 'dart:math';

import '../models/quiz/quiz_models.dart';
import '../services/supabase_service.dart';

class QuizRepository {
  QuizRepository({
    SupabaseService? service,
    Random? random,
  })  : _service = service ?? SupabaseService(),
        _random = random ?? Random.secure();

  final SupabaseService _service;
  final Random _random;

  List<PokemonQuizEntry>? _cachedEntries;

  Future<List<PokemonQuizEntry>> loadPokemonList() async {
    if (_cachedEntries != null) {
      return _cachedEntries!;
    }

    final entries = await _service.fetchPokemonList();
    if (entries.length < 3) {
      throw StateError('Pokemon list requires at least 3 entries for the quiz.');
    }

    _cachedEntries = entries;
    return entries;
  }

  Future<PokemonQuizDetail> loadPokemonDetail(int id) {
    return _service.fetchPokemonDetail(id);
  }

  void clearCache() {
    _cachedEntries = null;
  }

  Future<QuizRound> createRound() async {
    final entries = await loadPokemonList();
    final sampled = _sample(entries, 3);
    final correctEntry = sampled[_random.nextInt(sampled.length)];
    final detail = await loadPokemonDetail(correctEntry.id);

    final options = sampled.map((entry) {
      return PokemonQuizOption(
        id: entry.id,
        displayName: entry.displayName,
        isCorrect: entry.id == detail.id,
        isSelected: false,
      );
    }).toList()
      ..shuffle(_random);

    return QuizRound(
      correct: detail,
      options: options,
      status: QuizRoundStatus.ready,
      countdownRemaining: null,
    );
  }

  List<PokemonQuizEntry> _sample(List<PokemonQuizEntry> source, int count) {
    if (source.length < count) {
      throw StateError('Not enough entries to sample $count options.');
    }

    final copy = List<PokemonQuizEntry>.from(source);
    copy.shuffle(_random);
    return copy.take(count).toList();
  }
}
