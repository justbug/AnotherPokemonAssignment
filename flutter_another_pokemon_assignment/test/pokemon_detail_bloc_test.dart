import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'package:flutter_another_pokemon_assignment/blocs/pokemon_detail/pokemon_detail_bloc.dart';
import 'package:flutter_another_pokemon_assignment/blocs/pokemon_detail/pokemon_detail_event.dart';
import 'package:flutter_another_pokemon_assignment/blocs/pokemon_detail/pokemon_detail_state.dart';
import 'package:flutter_another_pokemon_assignment/repository/detail_repository.dart';
import 'package:flutter_another_pokemon_assignment/repository/favorite_pokemon_repository.dart';
import 'package:flutter_another_pokemon_assignment/models/models.dart';

import 'helpers/test_helpers.dart';
import 'pokemon_detail_bloc_test.mocks.dart';

@GenerateMocks([DetailRepositorySpec, FavoritePokemonRepository])
void main() {
  group('PokemonDetailBloc', () {
    late MockDetailRepositorySpec mockDetailRepository;
    late MockFavoritePokemonRepository mockFavoriteRepository;

    setUp(() {
      mockDetailRepository = MockDetailRepositorySpec();
      mockFavoriteRepository = MockFavoritePokemonRepository();
    });

    test('has initial state', () {
      final bloc = PokemonDetailBloc(
        detailRepository: mockDetailRepository,
        favoriteRepository: mockFavoriteRepository,
      );
      expect(bloc.state, const PokemonDetailInitial());
    });

    group('PokemonDetailLoadRequested', () {
      blocTest<PokemonDetailBloc, PokemonDetailState>(
        'emits (Loading, Success) when fetchDetail succeeds',
        build: () {
          final pokemon = TestLocalPokemonFactory.createPokemonList(1).first;
          final pokemonWithDetail = pokemon.copyWith(
            detail: const PokemonDetailData(
              id: 1,
              weight: 60,
              height: 4,
              types: ['Electric'],
            ),
          );
          
          when(mockDetailRepository.fetchDetail('1', 'pikachu'))
              .thenAnswer((_) async => pokemonWithDetail);
          when(mockFavoriteRepository.isFavorite('1'))
              .thenAnswer((_) async => true);
          
          return PokemonDetailBloc(
            detailRepository: mockDetailRepository,
            favoriteRepository: mockFavoriteRepository,
          );
        },
        act: (bloc) => bloc.add(const PokemonDetailLoadRequested(
          pokemonId: '1',
          pokemonName: 'pikachu',
        )),
        expect: () => [
          const PokemonDetailLoading(),
          isA<PokemonDetailSuccess>()
              .having((s) => s.detail.id, 'detail.id', '1')
              .having((s) => s.detail.name, 'detail.name', 'pokemon-1')
              .having((s) => s.detail.isFavorite, 'detail.isFavorite', true)
              .having((s) => s.detail.detail?.id, 'detail.detail.id', 1)
              .having((s) => s.detail.detail?.types, 'detail.detail.types', ['Electric']),
        ],
        verify: (_) {
          verify(mockDetailRepository.fetchDetail('1', 'pikachu')).called(1);
          verify(mockFavoriteRepository.isFavorite('1')).called(1);
        },
      );

      blocTest<PokemonDetailBloc, PokemonDetailState>(
        'emits (Loading, Success) when fetchDetail succeeds with isFavorite false',
        build: () {
          final pokemon = TestLocalPokemonFactory.createPokemonList(1).first;
          final pokemonWithDetail = pokemon.copyWith(
            detail: const PokemonDetailData(
              id: 1,
              weight: 60,
              height: 4,
              types: ['Electric'],
            ),
          );
          
          when(mockDetailRepository.fetchDetail('1', 'pikachu'))
              .thenAnswer((_) async => pokemonWithDetail);
          when(mockFavoriteRepository.isFavorite('1'))
              .thenAnswer((_) async => false);
          
          return PokemonDetailBloc(
            detailRepository: mockDetailRepository,
            favoriteRepository: mockFavoriteRepository,
          );
        },
        act: (bloc) => bloc.add(const PokemonDetailLoadRequested(
          pokemonId: '1',
          pokemonName: 'pikachu',
        )),
        expect: () => [
          const PokemonDetailLoading(),
          isA<PokemonDetailSuccess>()
              .having((s) => s.detail.isFavorite, 'detail.isFavorite', false),
        ],
        verify: (_) {
          verify(mockDetailRepository.fetchDetail('1', 'pikachu')).called(1);
          verify(mockFavoriteRepository.isFavorite('1')).called(1);
        },
      );

      blocTest<PokemonDetailBloc, PokemonDetailState>(
        'emits (Loading, Error) when fetchDetail fails',
        build: () {
          when(mockDetailRepository.fetchDetail('1', 'pikachu'))
              .thenThrow(Exception('Network error'));
          
          return PokemonDetailBloc(
            detailRepository: mockDetailRepository,
            favoriteRepository: mockFavoriteRepository,
          );
        },
        act: (bloc) => bloc.add(const PokemonDetailLoadRequested(
          pokemonId: '1',
          pokemonName: 'pikachu',
        )),
        expect: () => [
          const PokemonDetailLoading(),
          isA<PokemonDetailError>()
              .having((s) => s.message, 'message', 'Failed to load Pokemon detail: Exception: Network error'),
        ],
        verify: (_) {
          verify(mockDetailRepository.fetchDetail('1', 'pikachu')).called(1);
          verifyNever(mockFavoriteRepository.isFavorite(any));
        },
      );

      blocTest<PokemonDetailBloc, PokemonDetailState>(
        'emits (Loading, Error) when isFavorite check fails',
        build: () {
          final pokemon = TestLocalPokemonFactory.createPokemonList(1).first;
          final pokemonWithDetail = pokemon.copyWith(
            detail: const PokemonDetailData(
              id: 1,
              weight: 60,
              height: 4,
              types: ['Electric'],
            ),
          );
          
          when(mockDetailRepository.fetchDetail('1', 'pikachu'))
              .thenAnswer((_) async => pokemonWithDetail);
          when(mockFavoriteRepository.isFavorite('1'))
              .thenThrow(Exception('Storage error'));
          
          return PokemonDetailBloc(
            detailRepository: mockDetailRepository,
            favoriteRepository: mockFavoriteRepository,
          );
        },
        act: (bloc) => bloc.add(const PokemonDetailLoadRequested(
          pokemonId: '1',
          pokemonName: 'pikachu',
        )),
        expect: () => [
          const PokemonDetailLoading(),
          isA<PokemonDetailError>()
              .having((s) => s.message, 'message', 'Failed to load Pokemon detail: Exception: Storage error'),
        ],
        verify: (_) {
          verify(mockDetailRepository.fetchDetail('1', 'pikachu')).called(1);
          verify(mockFavoriteRepository.isFavorite('1')).called(1);
        },
      );
    });

    group('PokemonDetailFavoriteToggled', () {
      final pokemonWithDetail = TestLocalPokemonFactory.createPokemonList(1).first.copyWith(
        detail: const PokemonDetailData(
          id: 1,
          weight: 60,
          height: 4,
          types: ['Electric'],
        ),
        isFavorite: false,
      );

      blocTest<PokemonDetailBloc, PokemonDetailState>(
        'emits Success with updated isFavorite when toggling favorite in Success state',
        build: () {
          return PokemonDetailBloc(
            detailRepository: mockDetailRepository,
            favoriteRepository: mockFavoriteRepository,
          );
        },
        seed: () => PokemonDetailSuccess(detail: pokemonWithDetail),
        act: (bloc) => bloc.add(const PokemonDetailFavoriteToggled(isFavorite: true)),
        expect: () => [
          isA<PokemonDetailSuccess>()
              .having((s) => s.detail.isFavorite, 'detail.isFavorite', true)
              .having((s) => s.detail.id, 'detail.id', pokemonWithDetail.id)
              .having((s) => s.detail.name, 'detail.name', pokemonWithDetail.name)
              .having((s) => s.detail.detail?.id, 'detail.detail.id', pokemonWithDetail.detail?.id),
        ],
        verify: (_) {
          verifyZeroInteractions(mockDetailRepository);
          verifyZeroInteractions(mockFavoriteRepository);
        },
      );

      blocTest<PokemonDetailBloc, PokemonDetailState>(
        'emits Success with updated isFavorite when toggling favorite from true to false',
        build: () {
          return PokemonDetailBloc(
            detailRepository: mockDetailRepository,
            favoriteRepository: mockFavoriteRepository,
          );
        },
        seed: () => PokemonDetailSuccess(detail: pokemonWithDetail.copyWith(isFavorite: true)),
        act: (bloc) => bloc.add(const PokemonDetailFavoriteToggled(isFavorite: false)),
        expect: () => [
          isA<PokemonDetailSuccess>()
              .having((s) => s.detail.isFavorite, 'detail.isFavorite', false)
              .having((s) => s.detail.id, 'detail.id', pokemonWithDetail.id)
              .having((s) => s.detail.name, 'detail.name', pokemonWithDetail.name),
        ],
        verify: (_) {
          verifyZeroInteractions(mockDetailRepository);
          verifyZeroInteractions(mockFavoriteRepository);
        },
      );

      blocTest<PokemonDetailBloc, PokemonDetailState>(
        'does not emit when toggling favorite in Initial state',
        build: () {
          return PokemonDetailBloc(
            detailRepository: mockDetailRepository,
            favoriteRepository: mockFavoriteRepository,
          );
        },
        act: (bloc) => bloc.add(const PokemonDetailFavoriteToggled(isFavorite: true)),
        expect: () => [],
        verify: (_) {
          verifyZeroInteractions(mockDetailRepository);
          verifyZeroInteractions(mockFavoriteRepository);
        },
      );

      blocTest<PokemonDetailBloc, PokemonDetailState>(
        'does not emit when toggling favorite in Loading state',
        build: () {
          return PokemonDetailBloc(
            detailRepository: mockDetailRepository,
            favoriteRepository: mockFavoriteRepository,
          );
        },
        seed: () => const PokemonDetailLoading(),
        act: (bloc) => bloc.add(const PokemonDetailFavoriteToggled(isFavorite: true)),
        expect: () => [],
        verify: (_) {
          verifyZeroInteractions(mockDetailRepository);
          verifyZeroInteractions(mockFavoriteRepository);
        },
      );

      blocTest<PokemonDetailBloc, PokemonDetailState>(
        'does not emit when toggling favorite in Error state',
        build: () {
          return PokemonDetailBloc(
            detailRepository: mockDetailRepository,
            favoriteRepository: mockFavoriteRepository,
          );
        },
        seed: () => const PokemonDetailError(message: 'Test error'),
        act: (bloc) => bloc.add(const PokemonDetailFavoriteToggled(isFavorite: true)),
        expect: () => [],
        verify: (_) {
          verifyZeroInteractions(mockDetailRepository);
          verifyZeroInteractions(mockFavoriteRepository);
        },
      );
    });
  });
}
