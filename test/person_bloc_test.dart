// A test for the person bloc

import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:testingbloc/bloc/bloc_acions.dart';
import 'package:testingbloc/bloc/person.dart';
import 'package:testingbloc/bloc/person_bloc.dart';

const mockedPerson1 = [
  Person(
    age: 20,
    name: "Foo",
  ),
  Person(
    age: 30,
    name: "Bar",
  ),
];
const mockedPerson2 = [
  Person(
    age: 20,
    name: "Foo",
  ),
  Person(
    age: 30,
    name: "Bar",
  ),
];
// Defining two mock persons
Future<Iterable<Person>> mockGetPersons1(String _) =>
    Future.value(mockedPerson1);

Future<Iterable<Person>> mockGetPersons2(String _) =>
    Future.value(mockedPerson2);

void main() {
  group(
    "Testing Bloc",
    () {
      // Write our Tests
      late PersonBloc bloc;
      setUp(() {
        bloc = PersonBloc();
      });
      blocTest<PersonBloc, FetchResult?>(
        "Test initial state",
        build: () => bloc,
        verify: (bloc) => expect(bloc.state, null),
      );
      // Fetch mock data(person1) and compare it with FetchResult
      blocTest<PersonBloc, FetchResult?>(
        "Mock retreiving persons from first iterable",
        build: () => bloc,
        act: (bloc) {
          bloc.add(
            const LoadPersonAction(
              url: "dummy_url1",
              loader: mockGetPersons1,
            ),
          );
          bloc.add(
            const LoadPersonAction(
              url: "dummy_url1",
              loader: mockGetPersons1,
            ),
          );
        },
        expect: () => [
          FetchResult(
            persons: mockedPerson1,
            isRetrieveFromCache: false,
          ),
          FetchResult(
            persons: mockedPerson1,
            isRetrieveFromCache: true,
          ),
        ],
      );
      blocTest<PersonBloc, FetchResult?>(
        "Mock retreiving persons from Second iterable",
        build: () => bloc,
        act: (bloc) {
          bloc.add(
            const LoadPersonAction(
              url: "dummy_url2",
              loader: mockGetPersons2,
            ),
          );
          bloc.add(
            const LoadPersonAction(
              url: "dummy_url2",
              loader: mockGetPersons2,
            ),
          );
        },
        expect: () => [
          FetchResult(
            persons: mockedPerson2,
            isRetrieveFromCache: false,
          ),
          FetchResult(
            persons: mockedPerson2,
            isRetrieveFromCache: true,
          ),
        ],
      );
    },
  );
}
