import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
// import 'package:userintegration_sqflite/common/constant/string_res.dart';
import 'package:userintegration_sqflite/main.dart';

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  testWidgets('Register User Test', (WidgetTester widgetTester) async {
    final Finder fname = find.byKey(Key('firstName'));
    final Finder email = find.byKey(Key('EmailAddress'));
    // final Finder dob = find.byKey(Key('DOB'));
    // final Finder address = find.byKey(Key('Address'));
    // final Finder password = find.byKey(Key('Password'));
    // final Finder cPassword = find.byKey(Key('ConfirmPassword'));
    final Finder register = find.byKey(Key('RegistrationKey'));

    await widgetTester.pumpWidget(MyApp());

    await widgetTester.pumpAndSettle();

    await widgetTester.tap(fname);
    await widgetTester.enterText(fname, 'Integration Test');
    await widgetTester.tap(email);
    await widgetTester.enterText(email, 'test@gmail.com');
    // await widgetTester.tap(dob);
    // await widgetTester.enterText(dob, '2020-11-01');
    // await widgetTester.tap(find.byKey(Key('Address')));
    // await widgetTester.enterText(address, 'Address of Integration Test');
    // await widgetTester.tap(find.byKey(Key('Password')));
    // await widgetTester.enterText(password, 'Test@12345');
    // await widgetTester.tap(find.byKey(Key('ConfirmPassword')));
    // await widgetTester.enterText(cPassword, 'Test@12345');

    await widgetTester.tap(register);
    print('Registration Button is Tapped Print from Test case');

    await widgetTester.pumpAndSettle(Duration(seconds: 5));
  });
}
