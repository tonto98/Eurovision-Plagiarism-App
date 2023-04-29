import 'package:eurovision_app/core/app_core.dart';
import 'package:flutter/material.dart';

class AuthPage extends StatefulWidget {
  const AuthPage({super.key});

  @override
  State<AuthPage> createState() => _AuthPageState();
}

class _AuthPageState extends State<AuthPage> {
  final TextEditingController _usernameController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          flex: 5,
          child: Container(),
        ),
        Expanded(flex: 30, child: Image.asset("assets/esc-logo-big.png")),
        Expanded(
          flex: 5,
          child: Container(),
        ),
        const Padding(
          padding: EdgeInsets.all(20.0),
          child: Text(
            "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.",
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 18),
          ),
        ),
        Expanded(
          flex: 5,
          child: Container(),
        ),
        Expanded(
          flex: 15,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: TextField(
              controller: _usernameController,
            ),
          ),
        ),
        Expanded(
          flex: 5,
          child: Container(),
        ),
        ElevatedButton(
          onPressed: () async {
            await ApplicationCore()
                .authBloc
                .logIn(username: _usernameController.text);
          },
          child: Text("NEXT"),
        ),
        Expanded(
          flex: 25,
          child: Container(),
        ),
      ],
    );
  }
}
