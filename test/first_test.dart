
import 'package:carpet2/startScreen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets('start Screen test', (WidgetTester tester) async {
    final startButton = find.byKey(Key('Start Button'));
    final otpText = find.byKey(Key('Otp Message'));
    await tester.pumpWidget(MaterialApp(home: StartScreen()));
    expect(startButton, findsOneWidget);
    await tester.tap(startButton);
    print('hey it has passed the tap start');
    await tester.pump();
    await tester.pumpAndSettle(Duration(seconds: 5));

    expect(otpText, findsOneWidget);

    
  });
}
