// Pokemon List Widget Test
// 測試 Pokemon 列表頁面的基本功能

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:flutter_another_pokemon_assignment/main.dart';

void main() {
  testWidgets('Pokemon List Page smoke test', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(const MyApp());

    // Verify that the app bar title is displayed.
    expect(find.text('Pokemon 列表'), findsOneWidget);

    // Verify that loading indicator is shown initially.
    expect(find.byType(CircularProgressIndicator), findsOneWidget);
  });
}
