import 'package:flutter/foundation.dart' show immutable;
import 'package:testingbloc/home.dart';

@immutable
abstract class LoadAction {
  const LoadAction();
}

// Action for loading the actual person JSON
@immutable
class LoadPersonAction extends LoadAction {
  final String url;
  final PersonsLoader loader;
  const LoadPersonAction({
    required this.url,
    required this.loader,
  }) : super();
}
