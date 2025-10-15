import 'package:flutter_test/flutter_test.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:mockito/mockito.dart';
import 'package:mockito/annotations.dart';
import 'package:flutter_another_pokemon_assignment/repository/favorite_pokemon_repository.dart';
import 'package:flutter_another_pokemon_assignment/blocs/favorite/favorite_bloc.dart';
import 'package:flutter_another_pokemon_assignment/blocs/favorite/favorite_event.dart';
import 'package:flutter_another_pokemon_assignment/blocs/favorite/favorite_state.dart';

import 'favorite_bloc_test.mocks.dart';

@GenerateMocks([FavoritePokemonRepository])
void main() {
  group('FavoriteBloc', () {
    late MockFavoritePokemonRepository mockFavoriteRepository;
    late FavoriteBloc favoriteBloc;

    setUp(() {
      mockFavoriteRepository = MockFavoritePokemonRepository();
      favoriteBloc = FavoriteBloc(
        favoriteRepository: mockFavoriteRepository,
      );
    });

    tearDown(() {
      favoriteBloc.close();
    });

    test('初始狀態應該是 FavoriteSuccess with empty favoriteStatus', () {
      expect(favoriteBloc.state, isA<FavoriteSuccess>());
      expect((favoriteBloc.state as FavoriteSuccess).favoriteStatus, isEmpty);
    });

    blocTest<FavoriteBloc, FavoriteState>(
      '當載入所有最愛狀態時，應該正確載入所有狀態',
      build: () {
        when(mockFavoriteRepository.getAllFavoriteStatus()).thenAnswer((_) async => {
          '1': false,
          '2': true,
          '3': false,
        });
        return FavoriteBloc(
          favoriteRepository: mockFavoriteRepository,
        );
      },
      act: (bloc) => bloc.add(const FavoriteLoadAllRequested()),
      expect: () => [
        const FavoriteSuccess(favoriteStatus: {'1': false, '2': true, '3': false}),
      ],
    );



    blocTest<FavoriteBloc, FavoriteState>(
      '點擊 favorite 按鈕應該切換狀態並儲存到 Repository',
      build: () {
        when(mockFavoriteRepository.toggleFavorite('1', 'Pikachu', 'https://example.com/pikachu.png')).thenAnswer((_) async {});
        return FavoriteBloc(
          favoriteRepository: mockFavoriteRepository,
        );
      },
      act: (bloc) => bloc.add(const FavoriteToggled(pokemonId: '1', pokemonName: 'Pikachu', imageURL: 'https://example.com/pikachu.png')),
      expect: () => [
        const FavoriteSuccess(favoriteStatus: {'1': true}),
      ],
      verify: (_) {
        verify(mockFavoriteRepository.toggleFavorite('1', 'Pikachu', 'https://example.com/pikachu.png')).called(1);
      },
    );

    blocTest<FavoriteBloc, FavoriteState>(
      '當 Pokemon 已經是最愛時，點擊應該移除最愛狀態',
      build: () {
        when(mockFavoriteRepository.toggleFavorite('1', 'Pikachu', 'https://example.com/pikachu.png')).thenAnswer((_) async {});
        return FavoriteBloc(
          favoriteRepository: mockFavoriteRepository,
        );
      },
      seed: () => const FavoriteSuccess(favoriteStatus: {'1': true}),
      act: (bloc) => bloc.add(const FavoriteToggled(pokemonId: '1', pokemonName: 'Pikachu', imageURL: 'https://example.com/pikachu.png')),
      expect: () => [
        const FavoriteSuccess(favoriteStatus: {'1': false}),
      ],
      verify: (_) {
        verify(mockFavoriteRepository.toggleFavorite('1', 'Pikachu', 'https://example.com/pikachu.png')).called(1);
      },
    );

    blocTest<FavoriteBloc, FavoriteState>(
      '當 Repository 操作失敗時，應該顯示錯誤狀態',
      build: () {
        when(mockFavoriteRepository.toggleFavorite('1', 'Pikachu', 'https://example.com/pikachu.png'))
            .thenThrow(Exception('Repository error'));
        return FavoriteBloc(
          favoriteRepository: mockFavoriteRepository,
        );
      },
      act: (bloc) => bloc.add(const FavoriteToggled(pokemonId: '1', pokemonName: 'Pikachu', imageURL: 'https://example.com/pikachu.png')),
      expect: () => [
        isA<FavoriteError>()
            .having((s) => s.message, 'message', contains('Repository error'))
            .having((s) => s.favoriteStatus, 'favoriteStatus', isEmpty),
      ],
    );
  });
}
