import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../providers/auth_provider.dart';

class SettingsScreen extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(title: Text("Settings")),
      body: Center(
        child: ElevatedButton(
          onPressed: () {
            ref.read(sessionProvider.notifier).logout();
          },
          child: Text("Logout"),
        ),
      ),
    );
  }
}