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
        pokemonId: '1',
        pokemonName: 'Pikachu',
        favoriteRepository: mockFavoriteRepository,
      );
    });

    tearDown(() {
      favoriteBloc.close();
    });

    test('初始狀態應該是 FavoriteInitial with isFavorite: false', () {
      expect(favoriteBloc.state, isA<FavoriteInitial>());
      expect((favoriteBloc.state as FavoriteInitial).isFavorite, false);
    });

    blocTest<FavoriteBloc, FavoriteState>(
      '當 Pokemon 不在 Repository 中時，初始狀態應該是 false',
      build: () {
        when(mockFavoriteRepository.isFavorite('1')).thenAnswer((_) async => false);
        return FavoriteBloc(
          pokemonId: '1',
          pokemonName: 'Pikachu',
          favoriteRepository: mockFavoriteRepository,
        );
      },
      expect: () => [
        const FavoriteInitial(isFavorite: false),
      ],
    );

    blocTest<FavoriteBloc, FavoriteState>(
      '當 Pokemon 在 Repository 中且 isFavorite 為 true 時，初始狀態應該是 true',
      build: () {
        when(mockFavoriteRepository.isFavorite('1')).thenAnswer((_) async => true);
        return FavoriteBloc(
          pokemonId: '1',
          pokemonName: 'Pikachu',
          favoriteRepository: mockFavoriteRepository,
        );
      },
      expect: () => [
        const FavoriteInitial(isFavorite: true),
      ],
    );

    blocTest<FavoriteBloc, FavoriteState>(
      '點擊 favorite 按鈕應該切換狀態並儲存到 Repository',
      build: () {
        when(mockFavoriteRepository.isFavorite('1')).thenAnswer((_) async => false);
        when(mockFavoriteRepository.toggleFavorite('1', 'Pikachu')).thenAnswer((_) async {});
        return FavoriteBloc(
          pokemonId: '1',
          pokemonName: 'Pikachu',
          favoriteRepository: mockFavoriteRepository,
        );
      },
      act: (bloc) => bloc.add(const FavoriteToggled()),
      expect: () => [
        const FavoriteLoading(isFavorite: false),
        const FavoriteInitial(isFavorite: false),
        const FavoriteSuccess(isFavorite: true),
      ],
      verify: (_) {
        verify(mockFavoriteRepository.toggleFavorite('1', 'Pikachu')).called(1);
      },
    );

    blocTest<FavoriteBloc, FavoriteState>(
      '當 Pokemon 已經是最愛時，點擊應該移除最愛狀態',
      build: () {
        // 重置 mock
        reset(mockFavoriteRepository);
        
        // 設定 isFavorite 在每次調用時都返回 true
        when(mockFavoriteRepository.isFavorite('1')).thenAnswer((_) async => true);
        when(mockFavoriteRepository.toggleFavorite('1', 'Pikachu')).thenAnswer((_) async {});
        return FavoriteBloc(
          pokemonId: '1',
          pokemonName: 'Pikachu',
          favoriteRepository: mockFavoriteRepository,
        );
      },
      act: (bloc) => bloc.add(const FavoriteToggled()),
      expect: () => [
        const FavoriteLoading(isFavorite: false),
        const FavoriteInitial(isFavorite: true),
        const FavoriteSuccess(isFavorite: true),
      ],
      verify: (_) {
        verify(mockFavoriteRepository.toggleFavorite('1', 'Pikachu')).called(1);
      },
    );

    blocTest<FavoriteBloc, FavoriteState>(
      '當 Repository 操作失敗時，應該顯示錯誤狀態',
      build: () {
        when(mockFavoriteRepository.isFavorite('1')).thenAnswer((_) async => false);
        when(mockFavoriteRepository.toggleFavorite('1', 'Pikachu'))
            .thenThrow(Exception('Repository error'));
        return FavoriteBloc(
          pokemonId: '1',
          pokemonName: 'Pikachu',
          favoriteRepository: mockFavoriteRepository,
        );
      },
      act: (bloc) => bloc.add(const FavoriteToggled()),
      expect: () => [
        const FavoriteLoading(isFavorite: false),
        isA<FavoriteError>()
            .having((s) => s.message, 'message', contains('Repository error'))
            .having((s) => s.isFavorite, 'isFavorite', false),
        const FavoriteInitial(isFavorite: false),
      ],
    );
  });
}
