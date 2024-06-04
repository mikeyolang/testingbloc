import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:testingbloc/apis/login_api.dart';
import 'package:testingbloc/apis/notes_api.dart';
import 'package:testingbloc/bloc/actions.dart';
import 'package:testingbloc/bloc/app_bloc.dart';
import 'package:testingbloc/bloc/app_state.dart';
import 'package:testingbloc/dialogs/generic_dialog.dart';
import 'package:testingbloc/dialogs/loading_screen.dart';
import 'package:testingbloc/models.dart';
import 'package:testingbloc/strings.dart';
import 'package:testingbloc/views/iterable_listview.dart';
import 'package:testingbloc/views/loginview.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AppBloc(
        loginApi: LoginApi(),
        notesApi: NotesApi(),
      ),
      child: Scaffold(
        appBar: AppBar(
          title: const Text(homepage),
        ),
        body: BlocConsumer<AppBloc, AppState>(
          listener: (context, appstate) {
            // Loading Screen
            if (appstate.isLoading) {
              LoadingScreen.instance().show(
                context: context,
                text: pleaseWait,
              );
            } else {
              LoadingScreen.instance().hide();
            }
            // Display Possible errors
            final loginError = appstate.loginError;

            if (loginError != null) {
              showGenericDialog(
                context: context,
                title: loginErrorDialogTitle,
                content: loginErrorDialogContent,
                optionsBuilder: () => {
                  ok: true,
                },
              );
            }
            // If we are loggin but we no fetched notes, fetch them nw
            if (appstate.isLoading == false &&
                appstate.loginError == null &&
                appstate.loginHandle == const LoginHandle.fooBar() &&
                appstate.fetchedNotes == null) {
              context.read<AppBloc>().add(
                    const LoadNotesAction(),
                  );
            }
          },
          builder: (context, appstate) {
            final notes = appstate.fetchedNotes;
            if (notes == null) {
              return LoginView(
                onLoginTapped: (email, password) {
                  context.read<AppBloc>().add(
                        LoginAction(
                          email: email,
                          password: password,
                        ),
                      );
                },
              );
            } else {
              return notes.toListView();
            }
          },
        ),
      ),
    );
  }
}
