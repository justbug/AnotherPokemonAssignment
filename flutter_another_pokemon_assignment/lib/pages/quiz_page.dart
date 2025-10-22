import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../blocs/quiz/quiz_bloc.dart';
import '../blocs/quiz/quiz_event.dart';
import '../blocs/quiz/quiz_state.dart';
import '../models/quiz/quiz_models.dart';
import '../widgets/quiz/quiz_option_button.dart';

class QuizPage extends StatefulWidget {
  const QuizPage({super.key, this.autoStart = true});

  final bool autoStart;

  @override
  State<QuizPage> createState() => _QuizPageState();
}

class _QuizPageState extends State<QuizPage> {
  @override
  void initState() {
    super.initState();
    if (widget.autoStart) {
      context.read<QuizBloc>().add(const QuizStarted());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Who's That Pokémon"),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: BlocBuilder<QuizBloc, QuizState>(
            builder: (context, state) {
              return switch (state) {
                QuizLoading() => const _QuizLoadingView(),
                QuizReady(round: final round) => _QuizReadyView(round: round),
                QuizReveal(round: final round) => _QuizRevealView(round: round),
                QuizError(message: final message) => _QuizErrorView(message: message),
                _ => const SizedBox.shrink(),
              };
            },
          ),
        ),
      ),
    );
  }
}

class _QuizLoadingView extends StatelessWidget {
  const _QuizLoadingView();

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: CircularProgressIndicator(),
    );
  }
}

class _QuizErrorView extends StatelessWidget {
  const _QuizErrorView({required this.message});

  final String message;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            'Something went wrong',
            style: Theme.of(context).textTheme.titleLarge,
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 8),
          Text(
            message,
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 16),
          FilledButton(
            onPressed: () {
              context.read<QuizBloc>().add(const QuizRetryRequested());
            },
            child: const Text('Retry'),
          ),
        ],
      ),
    );
  }
}

class _QuizReadyView extends StatelessWidget {
  const _QuizReadyView({required this.round});

  final QuizRound round;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Expanded(
          child: _QuizImageCard(
            imageUrl: round.correct.silhouetteUrl.toString(),
            description: 'Guess the Pokémon',
          ),
        ),
        const SizedBox(height: 24),
        ...round.options.map(
          (option) => Padding(
            padding: const EdgeInsets.only(bottom: 12),
            child: QuizOptionButton(
              option: option,
              showFeedback: false,
              onSelected: () => context
                  .read<QuizBloc>()
                  .add(QuizOptionSelected(option.id)),
            ),
          ),
        ),
      ],
    );
  }
}

class _QuizRevealView extends StatelessWidget {
  const _QuizRevealView({required this.round});

  final QuizRound round;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Expanded(
          child: _QuizImageCard(
            imageUrl: round.correct.officialUrl.toString(),
            description: "It's ${round.correct.displayName}",
          ),
        ),
        const SizedBox(height: 16),
        if (round.countdownRemaining != null)
          Text(
            'Next round in ${round.countdownRemaining}s',
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.titleMedium,
          ),
        const SizedBox(height: 16),
        ...round.options.map(
          (option) => Padding(
            padding: const EdgeInsets.only(bottom: 12),
            child: QuizOptionButton(
              option: option,
              showFeedback: true,
              onSelected: () {},
            ),
          ),
        ),
      ],
    );
  }
}

class _QuizImageCard extends StatelessWidget {
  const _QuizImageCard({
    required this.imageUrl,
    required this.description,
  });

  final String imageUrl;
  final String description;

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2,
      clipBehavior: Clip.antiAlias,
      child: Stack(
        children: [
          Positioned.fill(
            child: CachedNetworkImage(
              imageUrl: imageUrl,
              fit: BoxFit.contain,
              placeholder: (context, _) => const Center(
                child: CircularProgressIndicator(),
              ),
              errorWidget: (context, _, __) => const Center(
                child: Icon(Icons.broken_image, size: 48),
              ),
            ),
          ),
          Positioned(
            left: 16,
            right: 16,
            bottom: 16,
            child: DecoratedBox(
              decoration: BoxDecoration(
                color: Colors.black.withValues(alpha: 0.6),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
                child: Text(
                  description,
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
