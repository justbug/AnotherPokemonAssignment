import 'dart:async';

import 'package:flutter/foundation.dart';

typedef TelemetrySink =
    FutureOr<void> Function(String event, Map<String, Object?> payload);

/// Simple telemetry helper to emit structured events for favorites persistence.
class LocalPokemonTelemetry {
  LocalPokemonTelemetry({TelemetrySink? sink}) : _sink = sink ?? _defaultSink;

  static const String persistenceEvent = 'favorites_persistence_result';
  static const String clearEvent = 'favorites_clear_result';

  final TelemetrySink _sink;

  Future<void> recordPersistence({
    required String operation,
    required bool success,
    String? pokemonId,
    Object? error,
  }) async {
    final payload = <String, Object?>{
      'operation': operation,
      'status': success ? 'success' : 'failure',
      if (pokemonId != null) 'pokemonId': pokemonId,
      if (error != null) 'error': error.toString(),
    };
    await _sink(persistenceEvent, payload);
  }

  Future<void> recordClear({
    required bool success,
    int? clearedCount,
    Object? error,
  }) async {
    final payload = <String, Object?>{
      'status': success ? 'success' : 'failure',
      if (clearedCount != null) 'clearedCount': clearedCount,
      if (error != null) 'error': error.toString(),
    };
    await _sink(clearEvent, payload);
  }

  static FutureOr<void> _defaultSink(
    String event,
    Map<String, Object?> payload,
  ) {
    debugPrint('[LocalPokemonTelemetry][$event] $payload');
  }
}
