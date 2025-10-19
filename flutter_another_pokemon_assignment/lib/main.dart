import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'blocs/blocs.dart';
import 'pages/main_navigation_page.dart';

void main() {
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
