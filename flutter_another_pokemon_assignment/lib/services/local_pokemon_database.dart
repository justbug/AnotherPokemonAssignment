import 'dart:async';
import 'dart:io';

import 'package:path/path.dart' as p;
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';
import 'package:synchronized/synchronized.dart';

/// SQLite database helper for LocalPokemon persistence.
class LocalPokemonDatabase {
  LocalPokemonDatabase._({
    DatabaseFactory? factoryOverride,
    Future<String> Function()? pathBuilder,
  }) : _databaseFactory = factoryOverride ?? databaseFactory,
       _pathBuilder = pathBuilder ?? _defaultPathBuilder;

  /// Production singleton instance.
  static final LocalPokemonDatabase instance = LocalPokemonDatabase._();

  /// Factory for tests to supply custom database factories or paths.
  factory LocalPokemonDatabase.test({
    required DatabaseFactory databaseFactory,
    required Future<String> Function() pathBuilder,
  }) {
    return LocalPokemonDatabase._(
      factoryOverride: databaseFactory,
      pathBuilder: pathBuilder,
    );
  }

  static const String databaseName = 'pokemon_favorites.db';
  static const int databaseVersion = 1;

  static const String favoritesTable = 'pokemon_favorites';
  static const String favoritesColumnId = 'id';
  static const String favoritesColumnName = 'name';
  static const String favoritesColumnImageUrl = 'image_url';
  static const String favoritesColumnIsFavorite = 'is_favorite';
  static const String favoritesColumnCreated = 'created';
  static const String favoritesColumnUpdatedAt = 'updated_at';

  final DatabaseFactory _databaseFactory;
  final Future<String> Function() _pathBuilder;

  final Lock _initLock = Lock();
  Database? _database;

  /// Provides the lazily initialized database instance.
  Future<Database> get database async {
    if (_database != null) {
      return _database!;
    }
    return _initLock.synchronized(() async {
      if (_database != null) {
        return _database!;
      }
      final path = await _pathBuilder();
      _database = await _databaseFactory.openDatabase(
        path,
        options: OpenDatabaseOptions(
          version: databaseVersion,
          onCreate: _onCreate,
          onUpgrade: _onUpgrade,
          onOpen: _onOpen,
        ),
      );
      return _database!;
    });
  }

  /// Closes the underlying database. Intended for tests.
  Future<void> close() async {
    await _initLock.synchronized(() async {
      if (_database != null) {
        await _database!.close();
        _database = null;
      }
    });
  }

  static Future<String> _defaultPathBuilder() async {
    final Directory directory = await getApplicationDocumentsDirectory();
    return p.join(directory.path, databaseName);
  }

  FutureOr<void> _onCreate(Database db, int version) async {
    await db.execute('''
      CREATE TABLE $favoritesTable (
        $favoritesColumnId TEXT PRIMARY KEY,
        $favoritesColumnName TEXT NOT NULL,
        $favoritesColumnImageUrl TEXT NOT NULL,
        $favoritesColumnIsFavorite INTEGER NOT NULL,
        $favoritesColumnCreated INTEGER NOT NULL,
        $favoritesColumnUpdatedAt INTEGER NOT NULL
      )
    ''');
  }

  FutureOr<void> _onUpgrade(Database db, int oldVersion, int newVersion) async {
    // No-op for initial release. Placeholder for future schema migrations.
  }

  FutureOr<void> _onOpen(Database db) async {
    await db.execute('PRAGMA foreign_keys = ON');
  }
}
