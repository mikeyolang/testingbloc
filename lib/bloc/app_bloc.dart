import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:testingbloc/apis/login_api.dart';
import 'package:testingbloc/apis/notes_api.dart';
import 'package:testingbloc/bloc/actions.dart';
import 'package:testingbloc/bloc/app_state.dart';
import 'package:testingbloc/models.dart';

class AppBloc extends Bloc<AppAction, AppState> {
  final LoginApiProtocol loginApi;
  final NotesApiProtocol notesApi;

  AppBloc({
    required this.loginApi,
    required this.notesApi,
  }) : super(const AppState.empty()) {
    on<LoginAction>(
      (event, emit) async {
        // Start Loading
        emit(
          const AppState(
            loginHandle: null,
            fetchedNotes: null,
            isLoading: true,
            loginError: null,
          ),
        );
        // Log the user in
        final loginHandle = await loginApi.login(
          email: event.email,
          password: event.password,
        );
        emit(
          AppState(
            loginHandle: loginHandle,
            fetchedNotes: null,
            isLoading: false,
            loginError: loginHandle == null ? LoginErrors.invalidHandle : null,
          ),
        );
      },
    );
    on<LoadNotesAction>(
      (event, emit) async {
        // Start loading
        emit(
          AppState(
            loginHandle: state.loginHandle,
            fetchedNotes: null,
            isLoading: true,
            loginError: null,
          ),
        );
        final loginHandle = state.loginHandle;
        if (loginHandle != const LoginHandle.fooBar()) {
          // Invalid login handle, cannot fetch notes
          emit(
            AppState(
              loginHandle: loginHandle,
              fetchedNotes: null,
              isLoading: false,
              loginError: LoginErrors.invalidHandle,
            ),
          );
          return;
        }
        // We have a valid login handle and we want to fetch notes
        final notes =  await notesApi.getNotes(loginHandle: loginHandle!);
        emit(
           AppState(
            loginHandle: loginHandle,
            fetchedNotes: notes,
            isLoading: true,
            loginError: null,
          ),
        );
      },
    );
  }
}
