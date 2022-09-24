import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hacknu_mobile/feature/auth/bloc/auth_bloc.dart';
import 'package:hacknu_mobile/navigation/authenitcated_app.dart';
import 'package:hacknu_mobile/navigation/loading_page.dart';
import 'package:hacknu_mobile/navigation/unauthenticated_app.dart';

class App extends StatefulWidget {
  const App({super.key});

  @override
  State<App> createState() => _AppState();
}

class _AppState extends State<App> {
  final AuthBloc _authBloc = AuthBloc();

  @override
  void initState() {
    super.initState();
    _authBloc.add(InitAuthEvent());
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider<AuthBloc>(
      create: (context) => _authBloc,
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        home: BlocBuilder<AuthBloc, AuthState>(
          builder: (context, state) {
            if (state is AuthenticatedAuthState) {
              return const AuthenticatedApp();
            }
            if (state is LoadingAuthState) {
              return const LoadingPage();
            }
            return const UnauthenticatedApp();
          },
        ),
      ),
    );
  }
}
