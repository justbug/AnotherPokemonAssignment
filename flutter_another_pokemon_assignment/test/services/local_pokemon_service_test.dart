import 'dart:io';

import 'package:flutter_test/flutter_test.dart';
import 'package:path/path.dart' as p;
import 'package:sqflite_common_ffi/sqflite_ffi.dart';

import 'package:flutter_another_pokemon_assignment/models/local_pokemon.dart';
import 'package:flutter_another_pokemon_assignment/services/local_pokemon_database.dart';
import 'package:flutter_another_pokemon_assignment/services/local_pokemon_service.dart';
import 'package:flutter_another_pokemon_assignment/services/local_pokemon_telemetry.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();
  sqfliteFfiInit();

  late LocalPokemonDatabase database;
  late LocalPokemonService service;
  late Directory tempDir;
  late List<Map<String, Object?>> telemetryEvents;

  LocalPokemon buildPokemon(
    String id, {
    String name = 'Bulbasaur',
    String imageUrl = 'https://img.pokemondb.net/artwork/bulbasaur.jpg',
    bool isFavorite = true,
    int? created,
  }) {
    final createdTimestamp = created ?? DateTime.now().millisecondsSinceEpoch;
    return LocalPokemon(
      id: id,
      name: name,
      imageURL: imageUrl,
      isFavorite: isFavorite,
      created: createdTimestamp,
    );
  }

  setUp(() async {
    tempDir = await Directory.systemTemp.createTemp('pokemon_db_test_');
    database = LocalPokemonDatabase.test(
      databaseFactory: databaseFactoryFfi,
      pathBuilder: () async => p.join(tempDir.path, 'pokemon_favorites.db'),
    );
    telemetryEvents = <Map<String, Object?>>[];
    final telemetry = LocalPokemonTelemetry(
      sink: (event, payload) async {
        telemetryEvents.add(<String, Object?>{
          'event': event,
          'payload': payload,
        });
      },
    );
    service = LocalPokemonService(database: database, telemetry: telemetry);
  });

  tearDown(() async {
    await database.close();
    if (await tempDir.exists()) {
      await tempDir.delete(recursive: true);
    }
  });

  test('insertOrUpdate persists data retrievable via getById', () async {
    final pokemon = buildPokemon('0001');

    await service.insertOrUpdate(pokemon);
    final stored = await service.getById('0001');

    expect(stored, isNotNull);
    expect(stored!.id, '0001');
    expect(stored.isFavorite, isTrue);
    expect(stored.updatedAt, greaterThan(0));
  });

  test('insertOrUpdate retains original created timestamp', () async {
    final created = DateTime(2024, 01, 01).millisecondsSinceEpoch;
    final pokemon = buildPokemon('0002', created: created);

    await service.insertOrUpdate(pokemon);
    await Future<void>.delayed(const Duration(milliseconds: 5));
    await service.insertOrUpdate(pokemon.copyWith(name: 'Bulba'));

    final stored = await service.getById('0002');
    expect(stored?.created, created);
    expect(stored?.updatedAt, greaterThan(stored!.created));
  });

  test('getAll returns favorites ordered by updatedAt descending', () async {
    final first = buildPokemon('0003');
    await service.insertOrUpdate(first);
    await Future<void>.delayed(const Duration(milliseconds: 5));
    final second = buildPokemon('0004');
    await service.insertOrUpdate(second);

    final all = await service.getAll();
    expect(all.length, 2);
    expect(all.first.id, '0004');
    expect(all.first.updatedAt, greaterThanOrEqualTo(all.last.updatedAt));
  });

  test('delete removes record', () async {
    final pokemon = buildPokemon('0005');
    await service.insertOrUpdate(pokemon);

    await service.delete('0005');
    final stored = await service.getById('0005');

    expect(stored, isNull);
  });

  test('clear removes all favorites', () async {
    await service.insertOrUpdate(buildPokemon('0006'));
    await service.insertOrUpdate(buildPokemon('0007'));

    await service.clear();
    final all = await service.getAll();

    expect(all, isEmpty);
    final clearEvent = telemetryEvents
        .where((event) => event['event'] == LocalPokemonTelemetry.clearEvent)
        .toList();
    expect(clearEvent, isNotEmpty);
  });

  test(
    'concurrent insertOrUpdate operations complete without conflict',
    () async {
      final pokemons = List<LocalPokemon>.generate(
        5,
        (index) => buildPokemon((index + 10).toString().padLeft(4, '0')),
      );

      await Future.wait(pokemons.map(service.insertOrUpdate));

      final stored = await service.getAll();
      expect(stored.length, pokemons.length);
    },
  );
}

// Removed unused extension; direct matcher used above
