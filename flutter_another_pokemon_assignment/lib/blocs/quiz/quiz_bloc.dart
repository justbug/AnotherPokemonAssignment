import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';

import '../../models/quiz/quiz_models.dart';
import '../../repository/quiz_repository.dart';
import 'quiz_event.dart';
import 'quiz_state.dart';

class QuizBloc extends Bloc<QuizEvent, QuizState> {
  QuizBloc({
    QuizRepository? repository,
    int countdownSeconds = 5,
  })  : _repository = repository ?? QuizRepository(),
        _countdownSeconds = countdownSeconds,
        super(const QuizLoading()) {
    on<QuizStarted>(_onStarted);
    on<QuizRetryRequested>(_onRetryRequested);
    on<QuizOptionSelected>(_onOptionSelected);
    on<QuizCountdownTicked>(_onCountdownTicked);
    on<QuizCountdownCompleted>(_onCountdownCompleted);
  }

  final QuizRepository _repository;
  final int _countdownSeconds;

  Timer? _countdownTimer;
  bool _isLoadingRound = false;

  Future<void> _onStarted(
    QuizStarted event,
    Emitter<QuizState> emit,
  ) async {
    await _loadRound(emit);
  }

  Future<void> _onRetryRequested(
    QuizRetryRequested event,
    Emitter<QuizState> emit,
  ) async {
    await _loadRound(emit);
  }

  Future<void> _onOptionSelected(
    QuizOptionSelected event,
    Emitter<QuizState> emit,
  ) async {
    if (state is! QuizReady) {
      return;
    }

    final readyState = state as QuizReady;
    final selectedRound = readyState.round
        .markSelected(event.optionId)
        .reveal(countdownStart: _countdownSeconds);

    emit(QuizReveal(round: selectedRound));
    _startCountdown();
  }

  void _onCountdownTicked(
    QuizCountdownTicked event,
    Emitter<QuizState> emit,
  ) {
    if (state is! QuizReveal) {
      return;
    }

    final revealState = state as QuizReveal;
    emit(
      QuizReveal(
        round: revealState.round.copyWith(
          countdownRemaining: event.remaining,
        ),
      ),
    );
  }

  Future<void> _onCountdownCompleted(
    QuizCountdownCompleted event,
    Emitter<QuizState> emit,
  ) async {
    await _loadRound(emit);
  }

  Future<void> _loadRound(Emitter<QuizState> emit) async {
    if (_isLoadingRound) {
      return;
    }

    _isLoadingRound = true;
    _cancelCountdown();
    emit(const QuizLoading());

    try {
      final round = await _repository.createRound();
      emit(QuizReady(round: round));
    } catch (error) {
      emit(QuizError(message: 'Failed to load quiz round: $error'));
    } finally {
      _isLoadingRound = false;
    }
  }

  void _startCountdown() {
    _cancelCountdown();

    var remaining = _countdownSeconds;
    _countdownTimer = Timer.periodic(const Duration(seconds: 1), (timer) {
      remaining -= 1;
      if (remaining > 0) {
        add(QuizCountdownTicked(remaining));
      } else {
        timer.cancel();
        add(const QuizCountdownCompleted());
      }
    });
  }

  void _cancelCountdown() {
    _countdownTimer?.cancel();
    _countdownTimer = null;
  }

  @override
  Future<void> close() {
    _cancelCountdown();
    return super.close();
  }
}
