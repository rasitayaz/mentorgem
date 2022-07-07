import 'package:flutter/material.dart';
import 'package:mentorgem/pages/onboarding_page.dart';

void main() {
  runApp(const App());
}

class App extends StatelessWidget {
  const App({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(),
      home: const OnboardingPage(),
    );
  }
}
