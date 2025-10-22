/// Supabase configuration values
const String supabaseUrl = 'https://dkpzswukjnigtkokting.supabase.co';
/// The anon and publishable keys secure the public components of your application. Public components run in environments where it is impossible to secure any secrets.
/// Safe to expose online: web page, mobile or desktop app, GitHub actions, CLIs, source code.
/// https://supabase.com/docs/guides/api/api-keys
const String supabaseAnonKey = 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6ImRrcHpzd3Vram5pZ3Rrb2t0aW5nIiwicm9sZSI6ImFub24iLCJpYXQiOjE3NjExMTM3NTcsImV4cCI6MjA3NjY4OTc1N30.YMqlLt3FFukI-IzY66YwUBQMd0XpGSXBfFFsRdUUo4o';

/// Simple helpers to verify configuration at runtime
bool get hasSupabaseConfig => supabaseUrl.isNotEmpty && supabaseAnonKey.isNotEmpty;
