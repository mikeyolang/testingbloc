import 'package:flutter/foundation.dart' show immutable;
import 'package:testingbloc/models.dart';

@immutable
class AppState {
  final bool isLoading;
  final LoginErrors? loginError;
  final LoginHandle? loginHandle;
  final Iterable<Note>? fetchedNotes;

  const AppState({
    required this.loginHandle,
    required this.fetchedNotes,
    required this.isLoading,
    required this.loginError,
  });

  const AppState.empty()
      : isLoading = false,
        loginError = null,
        loginHandle = null,
        fetchedNotes = null;
  @override
  String toString() => {
        'isLoading': isLoading,
        'loginError': loginError,
        'loginHandle': loginHandle,
        'fetchedNotes': fetchedNotes,
      }.toString();
}
