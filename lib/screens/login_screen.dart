import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../providers/auth_provider.dart';

class LoginScreen extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final session = ref.watch(sessionProvider);

    return Scaffold(
      appBar: AppBar(title: Text("EcoPatrol - Login")),
      body: Center(
        child: ElevatedButton(
          onPressed: () {
            ref.read(sessionProvider.notifier).login();
          },
          child: Text("Login"),
        ),
      ),
    );
  }
}
