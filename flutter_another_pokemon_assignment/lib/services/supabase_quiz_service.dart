import 'dart:convert';

import 'package:supabase_flutter/supabase_flutter.dart';

import '../models/quiz/quiz_models.dart';

class QuizServiceException implements Exception {
  QuizServiceException(this.message, {this.statusCode});

  final String message;
  final int? statusCode;

  @override
  String toString() =>
      'QuizServiceException(statusCode: $statusCode, message: $message)';
}

class SupabaseQuizService {
  SupabaseQuizService({SupabaseClient? client})
      : _client = client ?? Supabase.instance.client;

  final SupabaseClient _client;

  Future<List<PokemonQuizEntry>> fetchPokemonList({int limit = 100}) async {
    final response = await _client.functions.invoke(
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
    final response = await _client.functions.invoke(
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
