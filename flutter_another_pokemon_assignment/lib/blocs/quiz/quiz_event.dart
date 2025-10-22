import 'package:equatable/equatable.dart';

abstract class QuizEvent extends Equatable {
  const QuizEvent();

  @override
  List<Object?> get props => [];
}

class QuizStarted extends QuizEvent {
  const QuizStarted();
}

class QuizOptionSelected extends QuizEvent {
  const QuizOptionSelected(this.optionId);

  final int optionId;

  @override
  List<Object?> get props => [optionId];
}

class QuizRetryRequested extends QuizEvent {
  const QuizRetryRequested();
}

class QuizCountdownTicked extends QuizEvent {
  const QuizCountdownTicked(this.remaining);

  final int remaining;

  @override
  List<Object?> get props => [remaining];
}

class QuizCountdownCompleted extends QuizEvent {
  const QuizCountdownCompleted();
}
