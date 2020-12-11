import 'package:carpet2/startScreen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

main() {
  group("first Screen", () {
    
  });
  testWidgets('start Screen test', (WidgetTester tester) async {
    final startButton = find.byKey(ValueKey('Start Button'));

    await tester.pumpWidget(MaterialApp(home: StartScreen()));
    // await tester.tap(find.byType(RaisedButton));
    expect(startButton, findsOneWidget);
  });
  testWidgets('check text apperance', (WidgetTester tester) async {
    final otpText = find.byKey(ValueKey('Otp Message'));
    final startButton = find.byKey(ValueKey('Start Button'));

    await tester.pumpWidget(MaterialApp(home: StartScreen()));
    await tester.tap(startButton);
    await tester.pump();
    await tester.pumpAndSettle(Duration(seconds: 3));
    expect(otpText, findsOneWidget);
  });
}
