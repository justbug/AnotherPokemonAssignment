# Quickstart – Pokemon Silhouette Quiz

1. **Install dependencies**
   ```bash
   cd flutter_another_pokemon_assignment
   flutter pub get
   ```

2. **Configure Supabase credentials**
   - Add the following to a new file `lib/config/supabase_keys.dart` (to be created by implementation):
     ```dart
     const supabaseUrl = String.fromEnvironment('SUPABASE_URL');
     const supabaseAnonKey = String.fromEnvironment('SUPABASE_ANON_KEY');
     ```
   - Provide compile-time values via `--dart-define` for local runs.

3. **Bootstrap app with Supabase**
   - Ensure `Supabase.initialize(url: supabaseUrl, anonKey: supabaseAnonKey)` is called before `runApp`.

4. **Launch quiz screen**
   ```bash
   flutter run --dart-define=SUPABASE_URL=... --dart-define=SUPABASE_ANON_KEY=...
   ```
   - Select the `Quiz` tab in the bottom navigation bar to access “Who’s That Pokémon”.

5. **Run automated tests**
   ```bash
   flutter test test/quiz/ # folder to be added in implementation
   ```
   - Tests should cover bloc logic (round generation, countdown) and repository integration (Supabase client wrapper).
