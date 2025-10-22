import 'package:freezed_annotation/freezed_annotation.dart';

part 'quiz_models.freezed.dart';
part 'quiz_models.g.dart';

enum QuizRoundStatus { loading, ready, revealed, error }

enum QuizOptionFeedback { none, check, cross }

@freezed
class PokemonQuizEntry with _$PokemonQuizEntry {
  const factory PokemonQuizEntry({
    required int id,
    required String name,
  }) = _PokemonQuizEntry;

  factory PokemonQuizEntry.fromJson(Map<String, dynamic> json) =>
      _$PokemonQuizEntryFromJson(json);
}

extension PokemonQuizEntryX on PokemonQuizEntry {
  String get displayName =>
      name.isEmpty ? name : '${name[0].toUpperCase()}${name.substring(1)}';
}

@freezed
class PokemonQuizDetail with _$PokemonQuizDetail {
  const factory PokemonQuizDetail({
    required int id,
    required String name,
    required Uri silhouetteUrl,
    required Uri officialUrl,
    DateTime? createdAt,
  }) = _PokemonQuizDetail;

  factory PokemonQuizDetail.fromJson(Map<String, dynamic> json) =>
      _$PokemonQuizDetailFromJson(json);
}

extension PokemonQuizDetailX on PokemonQuizDetail {
  String get displayName =>
      name.isEmpty ? name : '${name[0].toUpperCase()}${name.substring(1)}';
}

@freezed
class PokemonQuizOption with _$PokemonQuizOption {
  const factory PokemonQuizOption({
    required int id,
    required String displayName,
    required bool isCorrect,
    required bool isSelected,
  }) = _PokemonQuizOption;
}

extension PokemonQuizOptionX on PokemonQuizOption {
  QuizOptionFeedback get feedback {
    if (!isCorrect && !isSelected) {
      return QuizOptionFeedback.none;
    }
    return isCorrect ? QuizOptionFeedback.check : QuizOptionFeedback.cross;
  }
}

@freezed
class QuizRound with _$QuizRound {
  const factory QuizRound({
    required PokemonQuizDetail correct,
    required List<PokemonQuizOption> options,
    required QuizRoundStatus status,
    int? countdownRemaining,
    String? errorMessage,
  }) = _QuizRound;
}

extension QuizRoundX on QuizRound {
  PokemonQuizOption? get correctOption =>
      options.firstWhere((o) => o.isCorrect, orElse: () => options.first);

  PokemonQuizOption? get selectedOption =>
      options.where((o) => o.isSelected).firstOrNull;

  QuizRound resetSelections() => copyWith(
        options: options
            .map((o) => o.copyWith(isSelected: false))
            .toList(growable: false),
        status: QuizRoundStatus.ready,
        countdownRemaining: null,
        errorMessage: null,
      );

  QuizRound markSelected(int optionId) => copyWith(
        options: options
            .map(
              (o) => o.id == optionId
                  ? o.copyWith(isSelected: true)
                  : o.copyWith(isSelected: false),
            )
            .toList(growable: false),
      );

  QuizRound reveal({required int countdownStart}) => copyWith(
        status: QuizRoundStatus.revealed,
        countdownRemaining: countdownStart,
      );

  QuizRound tickCountdown() {
    final remaining = countdownRemaining ?? 0;
    final nextValue = remaining > 0 ? remaining - 1 : 0;
    return copyWith(countdownRemaining: nextValue);
  }
}

extension IterableFirstOrNullX<T> on Iterable<T> {
  T? get firstOrNull => isEmpty ? null : first;
}
