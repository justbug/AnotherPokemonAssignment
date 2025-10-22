import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'blocs/blocs.dart';
import 'pages/main_navigation_page.dart';
import 'services/supabase_service.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Initialize Supabase service
  final supabaseService = SupabaseService();
  await supabaseService.initialize();

  // Always run the main app regardless of Supabase status
  runApp(MyApp(supabaseService: supabaseService));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key, required this.supabaseService});

  final SupabaseService supabaseService;

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
        home: MainNavigationPage(supabaseService: supabaseService),
      ),
    );
  }
}

