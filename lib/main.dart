import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'screens/login_screen.dart';
import 'screens/settings_screen.dart';
import 'providers/session_provider.dart';

void main() {
  runApp(ProviderScope(child: MyApp()));
}

class MyApp extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isLoggedIn = ref.watch(sessionProvider);

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: isLoggedIn ? SettingsScreen() : LoginScreen(),
    );
  }
}
