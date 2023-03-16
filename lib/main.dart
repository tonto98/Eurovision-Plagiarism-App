import 'package:eurovision_app/blocs/auth/auth_bloc.dart';
import 'package:eurovision_app/blocs/auth/auth_state.dart';
import 'package:eurovision_app/core/app_core.dart';
import 'package:eurovision_app/ui/auth_page.dart';
import 'package:eurovision_app/ui/home_page.dart';
import 'package:eurovision_app/ui/loading_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() async {
  await ApplicationCore().onCreate();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Eurovision App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Scaffold(
        // appBar: AppBar(
        //   backgroundColor: const Color.fromRGBO(254, 213, 0, 1),
        //   title: const Text(
        //     "Eurovision Plagiarism 2023",
        //     style: TextStyle(
        //       fontWeight: FontWeight.bold,
        //       fontSize: 25,
        //       color: Color.fromRGBO(0, 68, 255, 1),
        //       fontFamily: 'Eurovision',
        //     ),
        //   ),
        //   leading: Image.asset("assets/esc-logo.jpg"),
        //   actions: const [Icon(Icons.settings)],
        // ),
        body: BlocProvider(
          create: (context) => ApplicationCore().authBloc,
          child: BlocBuilder<AuthBloc, AuthState>(
            builder: (context, state) {
              if (state is AuthStateInitial) {
                return const LoadingPage();
              } else if (state is AuthStateFail) {
                return AuthPage();
              } else {
                return const HomePage();
              }
            },
          ),
        ),
      ),
    );
  }
}
