// test/widget_test.dart - Updated Test for Online Consultant App

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:i_locket/main.dart';

void main() {
  testWidgets('App loads splash screen', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(const OnlineConsultantApp());

    // Verify that splash screen is shown with "Hallo" text
    expect(find.text('Hallo'), findsOneWidget);
    
    // Verify the stethoscope icon exists
    expect(find.byIcon(Icons.monitor_heart_outlined), findsOneWidget);
  });

  testWidgets('Navigate to login screen after splash', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(const OnlineConsultantApp());

    // Wait for splash screen duration (2.5 seconds)
    await tester.pumpAndSettle(const Duration(seconds: 3));

    // Verify that we're now on the login screen
    expect(find.text('Login'), findsOneWidget);
    expect(find.text('Please Login to Online Consultant'), findsOneWidget);
  });

  testWidgets('Login screen has all required fields', (WidgetTester tester) async {
    // Build our app
    await tester.pumpWidget(const OnlineConsultantApp());
    
    // Wait for navigation to login screen
    await tester.pumpAndSettle(const Duration(seconds: 3));

    // Verify email field exists
    expect(find.text('Email*'), findsOneWidget);
    expect(find.byIcon(Icons.email_outlined), findsOneWidget);

    // Verify password field exists
    expect(find.text('Password*'), findsOneWidget);
    expect(find.byIcon(Icons.lock_outline), findsOneWidget);

    // Verify Remember Me checkbox exists
    expect(find.text('Remember Me'), findsOneWidget);

    // Verify Forgot Password link exists
    expect(find.text('Forgot Password?'), findsOneWidget);

    // Verify Login button exists
    expect(find.widgetWithText(ElevatedButton, 'Login'), findsOneWidget);

    // Verify Register link exists
    expect(find.text('Register Here'), findsOneWidget);
  });

  testWidgets('Password visibility toggle works', (WidgetTester tester) async {
    // Build our app
    await tester.pumpWidget(const OnlineConsultantApp());
    
    // Wait for navigation to login screen
    await tester.pumpAndSettle(const Duration(seconds: 3));

    // Find the password field
    final passwordField = find.widgetWithText(TextFormField, 'Password');
    expect(passwordField, findsOneWidget);

    // Find the visibility toggle button
    final visibilityButton = find.byIcon(Icons.visibility_off_outlined);
    expect(visibilityButton, findsOneWidget);

    // Tap the visibility button
    await tester.tap(visibilityButton);
    await tester.pump();

    // Verify icon changed to visibility (password shown)
    expect(find.byIcon(Icons.visibility_outlined), findsOneWidget);
  });

  testWidgets('Remember Me checkbox toggles', (WidgetTester tester) async {
    // Build our app
    await tester.pumpWidget(const OnlineConsultantApp());
    
    // Wait for navigation to login screen
    await tester.pumpAndSettle(const Duration(seconds: 3));

    // Find the checkbox
    final checkbox = find.byType(Checkbox);
    expect(checkbox, findsOneWidget);

    // Verify initial state is unchecked
    Checkbox checkboxWidget = tester.widget(checkbox);
    expect(checkboxWidget.value, false);

    // Tap the checkbox
    await tester.tap(checkbox);
    await tester.pump();

    // Verify checkbox is now checked
    checkboxWidget = tester.widget(checkbox);
    expect(checkboxWidget.value, true);
  });

  testWidgets('Login button shows validation errors', (WidgetTester tester) async {
    // Build our app
    await tester.pumpWidget(const OnlineConsultantApp());
    
    // Wait for navigation to login screen
    await tester.pumpAndSettle(const Duration(seconds: 3));

    // Tap login button without filling fields
    await tester.tap(find.widgetWithText(ElevatedButton, 'Login'));
    await tester.pump();

    // Verify validation error messages appear
    expect(find.text('Please enter your email'), findsOneWidget);
    expect(find.text('Please enter your password'), findsOneWidget);
  });

  testWidgets('Email validation works', (WidgetTester tester) async {
    // Build our app
    await tester.pumpWidget(const OnlineConsultantApp());
    
    // Wait for navigation to login screen
    await tester.pumpAndSettle(const Duration(seconds: 3));

    // Find email field and enter invalid email
    final emailField = find.widgetWithIcon(TextFormField, Icons.email_outlined);
    await tester.enterText(emailField, 'invalidemail');

    // Tap login button
    await tester.tap(find.widgetWithText(ElevatedButton, 'Login'));
    await tester.pump();

    // Verify validation error for invalid email
    expect(find.text('Please enter a valid email'), findsOneWidget);
  });
}