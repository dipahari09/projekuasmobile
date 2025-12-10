import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

final sessionProvider = StateNotifierProvider<SessionNotifier, bool>((ref) {
  return SessionNotifier();
});

class SessionNotifier extends StateNotifier<bool> {
  SessionNotifier() : super(false) {
  _loadSession();
  }

  Future<void> _loadSession() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('isLoggedIn', true);
    state = true;
  }

  Future<void> logout() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove('isLoggedIn');
    state = false;
  }

  Future<void> login() async {}
}