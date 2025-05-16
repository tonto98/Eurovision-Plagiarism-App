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
        Image.asset("assets/esc_logo_big.jpg"),
        Expanded(
          flex: 1,
          child: Center(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 36.0),
              child: Text(
                "Dobrodošli na našu aplikaciju za interni odabir pjesme za Euroviziju! \nMolimo vas da unesete svoje korisničko ime kako biste mogli glasati.",
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
              ),
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: Container(
            padding: const EdgeInsets.only(top: 12, left: 12, right: 12),
            decoration: BoxDecoration(
                border: Border.all(), borderRadius: BorderRadius.circular(12)),
            child: TextField(
              decoration: InputDecoration(hintText: "Korisničko ime"),
              controller: _usernameController,
            ),
          ),
        ),
        SizedBox(
          height: 20,
        ),
        GestureDetector(
          onTap: () async {
            if (_usernameController.text.isNotEmpty) {
              await ApplicationCore()
                  .authBloc
                  .logIn(username: _usernameController.text);
            } else {
              ScaffoldMessenger.of(context)
                ..hideCurrentSnackBar()
                ..showSnackBar(
                    SnackBar(content: Text("Barem neko ime smisli!")));
            }
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
          flex: 2,
          child: Center(
            child: Text(
              "Hvala vam na sudjelovanju! <3",
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.w700),
            ),
          ),
        ),
      ],
    );
  }
}
