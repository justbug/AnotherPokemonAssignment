import 'package:flutter/material.dart';
import 'pokemon_list_page.dart';
import 'favorites_page.dart';
import 'quiz_page.dart';
import '../services/supabase_service.dart';

/// Main navigation page
/// Uses BottomNavigationBar to switch between Pokemon list and favorites list
class MainNavigationPage extends StatefulWidget {
  const MainNavigationPage({super.key, required this.supabaseService});

  final SupabaseService supabaseService;

  @override
  State<MainNavigationPage> createState() => _MainNavigationPageState();
}

class _MainNavigationPageState extends State<MainNavigationPage> {
  int _currentIndex = 0;

  List<Widget> get _pages => [
    const PokemonListPage(),
    const FavoritesPage(),
    // Conditionally show Quiz or error based on Supabase initialization
    widget.supabaseService.isInitialized 
      ? const QuizPage()
      : _QuizSupabaseErrorView(
          title: 'Quiz Unavailable',
          message: widget.supabaseService.errorMessage ?? 'Unknown error',
        ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(
        index: _currentIndex,
        children: _pages,
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
        type: BottomNavigationBarType.fixed,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.list),
            label: 'List',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.favorite),
            label: 'Favorites',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.quiz),
            label: 'Quiz',
          ),
        ],
      ),
    );
  }
}

class _QuizSupabaseErrorView extends StatelessWidget {
  const _QuizSupabaseErrorView({
    required this.title,
    required this.message,
  });

  final String title;
  final String message;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
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
            const SizedBox(height: 16),
            Text(
              'Please restart the app to retry.',
              style: Theme.of(context).textTheme.bodySmall,
            ),
          ],
        ),
      ),
    );
  }
}
