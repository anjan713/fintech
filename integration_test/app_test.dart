import 'package:carpet2/autosmsScreen.dart';
import 'package:carpet2/startScreen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  testWidgets("failing test example", (WidgetTester tester) async {
    // await tester.pumpWidget(StartScreen());
    final startButton = find.byKey(Key('Start Button'));
    final otpText = find.byKey(Key('Otp Message'));
    await tester.pumpWidget(MaterialApp(home: StartScreen()));
    expect(startButton, findsOneWidget);
    await tester.tap(startButton);
    print('hey it has passed the tap start');
    await tester.pump();
    await tester.pumpAndSettle(Duration(seconds: 5));

    expect(otpText, findsOneWidget);

    final phoneField = find.byKey(Key('Phone Field'));
    expect(phoneField, findsOneWidget);
    await tester.tap(phoneField);
    await tester.pump();
    await tester.enterText(phoneField, '9948441044');
    final verifyButton = find.byKey(Key('Verify Button'));
    expect(verifyButton, findsOneWidget);
    await tester.tap(verifyButton);
    await tester.pump();
    await tester.pumpAndSettle(Duration(seconds: 10));
    final verificationText = find.byKey(Key('Verification Text'));
    expect(verificationText, findsOneWidget);

    
  });
}
//Command to run the test
// flutter drive \
//   --driver=test_driver/integration_test.dart \
//   --target=integration_test/app_test.dart;
