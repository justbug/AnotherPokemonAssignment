import 'package:equatable/equatable.dart';

import '../../models/quiz/quiz_models.dart';

abstract class QuizState extends Equatable {
  const QuizState();

  @override
  List<Object?> get props => [];
}

class QuizLoading extends QuizState {
  const QuizLoading();
}

class QuizReady extends QuizState {
  const QuizReady({required this.round});

  final QuizRound round;

  @override
  List<Object?> get props => [round];
}

class QuizReveal extends QuizState {
  const QuizReveal({required this.round});

  final QuizRound round;

  @override
  List<Object?> get props => [round];
}

class QuizError extends QuizState {
  const QuizError({required this.message});

  final String message;

  @override
  List<Object?> get props => [message];
}
