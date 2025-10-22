import 'dart:convert';

import 'package:supabase_flutter/supabase_flutter.dart';

import '../config/supabase_keys.dart';
import '../models/quiz/quiz_models.dart';

/// Unified service to manage Supabase initialization and quiz operations
class SupabaseService {
  static final SupabaseService _instance = SupabaseService._internal();
  factory SupabaseService() => _instance;
  SupabaseService._internal();

  bool _isInitialized = false;
  String? _errorMessage;

  /// Whether Supabase has been successfully initialized
  bool get isInitialized => _isInitialized;

  /// Error message if initialization failed, null if successful
  String? get errorMessage => _errorMessage;

  /// Initialize Supabase and store the result
  Future<void> initialize() async {
    if (!hasSupabaseConfig) {
      _errorMessage = 'Missing Supabase configuration. Provide SUPABASE_URL and SUPABASE_ANON_KEY via --dart-define.';
      return;
    }

    try {
      await Supabase.initialize(
        url: supabaseUrl,
        anonKey: supabaseAnonKey,
      );
      _isInitialized = true;
      _errorMessage = null;
    } catch (error) {
      _errorMessage = 'Failed to connect to Supabase. Please verify credentials and network connectivity.\n$error';
      _isInitialized = false;
    }
  }

  /// Get the Supabase client (only available if initialized)
  SupabaseClient get client {
    if (!_isInitialized) {
      throw StateError('Supabase is not initialized. Call initialize() first.');
    }
    return Supabase.instance.client;
  }

  // Quiz-related methods

  Future<List<PokemonQuizEntry>> fetchPokemonList({int limit = 100}) async {
    final response = await client.functions.invoke(
      'pokemon',
      method: HttpMethod.get,
      queryParameters: {
        'limit': '$limit',
        'offset': '0',
      },
    );

    final payload = _parseJson(response);
    final rawData = payload['data'];
    if (rawData is! List) {
      throw QuizServiceException('Invalid list payload shape.');
    }

    final entries = rawData
        .map((e) => PokemonQuizEntry.fromJson(Map<String, dynamic>.from(e)))
        .toList();
    return entries;
  }

  Future<PokemonQuizDetail> fetchPokemonDetail(int id) async {
    final response = await client.functions.invoke(
      'pokemon/$id',
      method: HttpMethod.get,
    );

    final payload = _parseJson(response);
    return PokemonQuizDetail.fromJson(
      Map<String, dynamic>.from(payload),
    );
  }

  Map<String, dynamic> _parseJson(FunctionResponse response) {
    final status = response.status;
    if (status >= 400) {
      throw QuizServiceException(
        'Supabase returned status $status with error: ${response.data}',
        statusCode: status,
      );
    }

    if (response.data case final Map<String, dynamic> map) {
      return map;
    }

    if (response.data case final String text) {
      return jsonDecode(text) as Map<String, dynamic>;
    }

    throw QuizServiceException('Unexpected response format.');
  }
}

/// Exception for quiz service operations
class QuizServiceException implements Exception {
  QuizServiceException(this.message, {this.statusCode});

  final String message;
  final int? statusCode;

  @override
  String toString() =>
      'QuizServiceException(statusCode: $statusCode, message: $message)';
}
