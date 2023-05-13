import 'package:eurovision_app/core/app_core.dart';
import 'package:eurovision_app/core/constants.dart';
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
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: Container(
            padding: const EdgeInsets.only(top: 12, left: 12, right: 12),
            decoration: BoxDecoration(
                border: Border.all(), borderRadius: BorderRadius.circular(12)),
            child: TextField(
              controller: _usernameController,
            ),
          ),
        ),
        Expanded(
          flex: 5,
          child: Container(),
        ),
        GestureDetector(
          onTap: () async {
            await ApplicationCore()
                .authBloc
                .logIn(username: _usernameController.text);
          },
          child: Container(
            height: 60,
            width: 60,
            decoration: BoxDecoration(
              color: euroBlue,
              shape: BoxShape.circle,
            ),
            child: Center(
              child: Icon(
                Icons.play_arrow,
                color: euroPink,
                size: 50,
              ),
            ),
          ),
        ),
        // ElevatedButton(
        //   onPressed: () async {
        //     await ApplicationCore()
        //         .authBloc
        //         .logIn(username: _usernameController.text);
        //   },
        //   child: Text("NEXT"),
        // ),
        Expanded(
          flex: 25,
          child: Container(),
        ),
      ],
    );
  }
}
