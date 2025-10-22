import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import 'blocs/blocs.dart';
import 'config/supabase_keys.dart';
import 'pages/main_navigation_page.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  if (!hasSupabaseConfig) {
    runApp(const _SupabaseErrorApp(
      title: 'Missing Supabase configuration',
      message: 'Provide SUPABASE_URL and SUPABASE_ANON_KEY via --dart-define.',
    ));
    return;
  }

  try {
    await Supabase.initialize(
      url: supabaseUrl,
      anonKey: supabaseAnonKey,
    );
  } catch (error) {
    runApp(_SupabaseErrorApp(
      title: 'Failed to connect to Supabase',
      message: 'Please verify credentials and network connectivity.\n$error',
    ));
    return;
  }

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => PokemonListBloc()..add(const PokemonListLoadRequested()),
        ),
        BlocProvider(
          create: (context) => FavoriteBloc(),
        ),
        BlocProvider(
          create: (context) => FavoritesListBloc()
            ..add(const FavoritesListLoadRequested()),
        ),
        BlocProvider(
          create: (context) => QuizBloc(countdownSeconds: 5),
        ),
      ],
      child: MaterialApp(
        title: 'Pokemon List',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
          useMaterial3: true,
        ),
        home: const MainNavigationPage(),
      ),
    );
  }
}

class _SupabaseErrorApp extends StatelessWidget {
  const _SupabaseErrorApp({
    required this.title,
    required this.message,
  });

  final String title;
  final String message;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: title,
      home: Scaffold(
        appBar: AppBar(title: Text(title)),
        body: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: Theme.of(context).textTheme.titleLarge,
              ),
              const SizedBox(height: 12),
              Text(message),
            ],
          ),
        ),
      ),
    );
  }
}
