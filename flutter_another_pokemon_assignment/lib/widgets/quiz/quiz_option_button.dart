import 'package:flutter/material.dart';

import '../../models/quiz/quiz_models.dart';

class QuizOptionButton extends StatelessWidget {
  const QuizOptionButton({
    super.key,
    required this.option,
    required this.onSelected,
    required this.showFeedback,
  });

  final PokemonQuizOption option;
  final VoidCallback onSelected;
  final bool showFeedback;

  @override
  Widget build(BuildContext context) {
    final icon = _iconDataFor(option, showFeedback);
    final isEnabled = !showFeedback;

    final buttonStyle = FilledButton.styleFrom(
      padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 12),
      textStyle: Theme.of(context).textTheme.titleMedium,
      backgroundColor: _backgroundColorFor(context, option, showFeedback),
      side: _borderSideFor(option, showFeedback),
    );

    if (icon != null) {
      return FilledButton.icon(
        onPressed: isEnabled ? onSelected : null,
        icon: Icon(icon, color: _iconColorFor(option, showFeedback)),
        label: Text(option.displayName),
        style: buttonStyle,
      );
    }

    return FilledButton(
      onPressed: isEnabled ? onSelected : null,
      style: buttonStyle,
      child: Text(option.displayName),
    );
  }

  IconData? _iconDataFor(PokemonQuizOption option, bool showFeedback) {
    if (!showFeedback) return null;

    switch (option.feedback) {
      case QuizOptionFeedback.check:
        return Icons.check;
      case QuizOptionFeedback.cross:
        return Icons.close;
      case QuizOptionFeedback.none:
        return null;
    }
  }

  Color? _iconColorFor(PokemonQuizOption option, bool showFeedback) {
    if (!showFeedback) return null;

    switch (option.feedback) {
      case QuizOptionFeedback.check:
        return Colors.green;
      case QuizOptionFeedback.cross:
        return Colors.red;
      case QuizOptionFeedback.none:
        return null;
    }
  }

  BorderSide? _borderSideFor(PokemonQuizOption option, bool showFeedback) {
    if (!showFeedback) return null;

    switch (option.feedback) {
      case QuizOptionFeedback.check:
        return const BorderSide(color: Colors.green, width: 2.0);
      case QuizOptionFeedback.cross:
        return const BorderSide(color: Colors.red, width: 2.0);
      case QuizOptionFeedback.none:
        return null;
    }
  }

  Color? _backgroundColorFor(
    BuildContext context,
    PokemonQuizOption option,
    bool showFeedback,
  ) {
    if (!showFeedback) {
      return null;
    }

    final theme = Theme.of(context);
    if (option.feedback == QuizOptionFeedback.check) {
      return theme.colorScheme.primaryContainer;
    }
    if (option.feedback == QuizOptionFeedback.cross && option.isSelected) {
      return theme.colorScheme.errorContainer;
    }
    return theme.colorScheme.surface;
  }
}
