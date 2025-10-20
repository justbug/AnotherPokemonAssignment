import 'dart:async';

import 'package:sqflite/sqflite.dart';
import 'package:synchronized/synchronized.dart';

import '../models/local_pokemon.dart';
import 'local_pokemon_database.dart';
import 'local_pokemon_service_spec.dart';
import 'local_pokemon_telemetry.dart';

/// Exception thrown when local persistence fails.
class LocalPokemonPersistenceException implements Exception {
  LocalPokemonPersistenceException(this.message, {this.cause});

  final String message;
  final Object? cause;

  @override
  String toString() {
    if (cause == null) {
      return 'LocalPokemonPersistenceException: $message';
    }
    return 'LocalPokemonPersistenceException: $message ($cause)';
  }
}

/// SQLite-backed implementation of [LocalPokemonServiceSpec].
class LocalPokemonService implements LocalPokemonServiceSpec {
  LocalPokemonService({
    LocalPokemonDatabase? database,
    LocalPokemonTelemetry? telemetry,
  }) : _database = database ?? LocalPokemonDatabase.instance,
       _telemetry = telemetry ?? LocalPokemonTelemetry();

  final LocalPokemonDatabase _database;
  final LocalPokemonTelemetry _telemetry;

  final Lock _operationLock = Lock();

  Future<Database> _db() => _database.database;

  @override
  Future<void> insertOrUpdate(LocalPokemon pokemon) async {
    await _operationLock.synchronized(() async {
      final db = await _db();
      final now = DateTime.now().millisecondsSinceEpoch;
      try {
        final existing = await db.query(
          LocalPokemonDatabase.favoritesTable,
          columns: <String>[LocalPokemonDatabase.favoritesColumnCreated],
          where: '${LocalPokemonDatabase.favoritesColumnId} = ?',
          whereArgs: <Object?>[pokemon.id],
          limit: 1,
        );

        final created = existing.isNotEmpty
            ? (existing.first[LocalPokemonDatabase.favoritesColumnCreated]
                  as int)
            : (pokemon.created == 0 ? now : pokemon.created);

        final upserted = pokemon.copyWith(created: created, updatedAt: now);

        await db.insert(
          LocalPokemonDatabase.favoritesTable,
          _toRow(upserted),
          conflictAlgorithm: ConflictAlgorithm.replace,
        );

        await _telemetry.recordPersistence(
          operation: 'upsert',
          success: true,
          pokemonId: pokemon.id,
        );
      } catch (error) {
        await _telemetry.recordPersistence(
          operation: 'upsert',
          success: false,
          pokemonId: pokemon.id,
          error: error,
        );
        throw LocalPokemonPersistenceException(
          'Failed to persist favorite ${pokemon.id}',
          cause: error,
        );
      }
    });
  }

  @override
  Future<void> delete(String id) async {
    await _operationLock.synchronized(() async {
      final db = await _db();
      try {
        await db.delete(
          LocalPokemonDatabase.favoritesTable,
          where: '${LocalPokemonDatabase.favoritesColumnId} = ?',
          whereArgs: <Object?>[id],
        );
        await _telemetry.recordPersistence(
          operation: 'delete',
          success: true,
          pokemonId: id,
        );
      } catch (error) {
        await _telemetry.recordPersistence(
          operation: 'delete',
          success: false,
          pokemonId: id,
          error: error,
        );
        throw LocalPokemonPersistenceException(
          'Failed to delete favorite $id',
          cause: error,
        );
      }
    });
  }

  @override
  Future<LocalPokemon?> getById(String id) async {
    final db = await _db();
    final results = await db.query(
      LocalPokemonDatabase.favoritesTable,
      where: '${LocalPokemonDatabase.favoritesColumnId} = ?',
      whereArgs: <Object?>[id],
      limit: 1,
    );
    if (results.isEmpty) {
      return null;
    }
    return _fromRow(results.first);
  }

  @override
  Future<List<LocalPokemon>> getAll() async {
    final db = await _db();
    final results = await db.query(
      LocalPokemonDatabase.favoritesTable,
      orderBy: '${LocalPokemonDatabase.favoritesColumnUpdatedAt} DESC',
    );
    return results.map(_fromRow).toList();
  }

  @override
  Future<void> clear() async {
    await _operationLock.synchronized(() async {
      final db = await _db();
      try {
        final cleared = await db.delete(LocalPokemonDatabase.favoritesTable);
        await _telemetry.recordClear(success: true, clearedCount: cleared);
      } catch (error) {
        await _telemetry.recordClear(success: false, error: error);
        throw LocalPokemonPersistenceException(
          'Failed to clear local favorites',
          cause: error,
        );
      }
    });
  }

  Map<String, Object?> _toRow(LocalPokemon pokemon) {
    return <String, Object?>{
      LocalPokemonDatabase.favoritesColumnId: pokemon.id,
      LocalPokemonDatabase.favoritesColumnName: pokemon.name,
      LocalPokemonDatabase.favoritesColumnImageUrl: pokemon.imageURL,
      LocalPokemonDatabase.favoritesColumnIsFavorite: pokemon.isFavorite
          ? 1
          : 0,
      LocalPokemonDatabase.favoritesColumnCreated: pokemon.created,
      LocalPokemonDatabase.favoritesColumnUpdatedAt: pokemon.updatedAt,
    };
  }

  LocalPokemon _fromRow(Map<String, Object?> row) {
    return LocalPokemon(
      id: row[LocalPokemonDatabase.favoritesColumnId]! as String,
      name: row[LocalPokemonDatabase.favoritesColumnName]! as String,
      imageURL: row[LocalPokemonDatabase.favoritesColumnImageUrl]! as String,
      isFavorite:
          (row[LocalPokemonDatabase.favoritesColumnIsFavorite]! as int) == 1,
      created: row[LocalPokemonDatabase.favoritesColumnCreated]! as int,
      updatedAt: row[LocalPokemonDatabase.favoritesColumnUpdatedAt]! as int,
    );
  }
}
