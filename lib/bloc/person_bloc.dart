// ignore_for_file: camel_case_extensions

import 'dart:convert';
import 'dart:io';

import 'package:bloc/bloc.dart';


import 'bloc_acions.dart';
import 'person.dart';

Future<Iterable<Person>> getPersons(String url) {
  return HttpClient()
      .getUrl(Uri.parse(url))
      .then((req) => req.close())
      .then((res) => res.transform(utf8.decoder).join())
      .then((str) => json.decode(str) as List<dynamic>)
      .then((list) => list.map((e) => Person.fromJson(e)));
}

// The Aplication state
class FetchResult {
  final Iterable<Person> persons;
  final bool isRetrieveFromCache;

  FetchResult({
    required this.persons,
    required this.isRetrieveFromCache,
  });

  @override
  String toString() =>
      "Fetch result (isRetrieveFromCache = $isRetrieveFromCache, person = $persons)";

  @override
  bool operator ==(covariant FetchResult other) =>
      persons.isEqualToIgnoringOrdering(other.persons) &&
      isRetrieveFromCache == other.isRetrieveFromCache;

  @override
  int get hashCode => Object.hash(
        persons,
        isRetrieveFromCache,
      );
}

extension isEqualToIgnoringOrder<T> on Iterable<T> {
  bool isEqualToIgnoringOrdering(Iterable<T> other) =>
      length == other.length &&
      {...this}.intersection({...other}).length == length;
}

class PersonBloc extends Bloc<LoadAction, FetchResult?> {
  final Map<String, Iterable<Person>> _cache = {};
  PersonBloc() : super(null) {
    on<LoadPersonAction>((event, emit) async {
      final url = event.url;
      if (_cache.containsKey(url)) {
        final cachedPersons = _cache[url]!;
        final result = FetchResult(
          persons: cachedPersons,
          isRetrieveFromCache: true,
        );
        emit(result);
      } else {
        final loader = event.loader;
        final persons = await loader(url);
        _cache[url] = persons;
        final result = FetchResult(
          persons: persons,
          isRetrieveFromCache: false,
        );
        emit(result);
      }
    });
  }
}
