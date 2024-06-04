import 'package:flutter/foundation.dart'show immutable;

typedef CloseLoadingScreen = bool Function();
typedef UpdateLoadingScreen = bool Function(String text);

@immutable
class LoadingScreeningController {
  final CloseLoadingScreen close;
  final UpdateLoadingScreen update;

  const LoadingScreeningController({
    required this.close,
    required this.update,
  });
}
