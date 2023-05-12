import 'package:eurovision_app/blocs/countries/countries_bloc.dart';
import 'package:eurovision_app/blocs/countries/countries_state.dart';
import 'package:eurovision_app/core/app_core.dart';
import 'package:eurovision_app/ui/ordering_page.dart';
import 'package:eurovision_app/ui/voting_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomePage extends StatefulWidget {
  const HomePage({
    super.key,
  });

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int contentIndex = 0;

  Widget _getContent() {
    switch (contentIndex) {
      case 0:
        return VotingContent();
      case 1:
        return OrderContent();
      default:
        return const Text("invalid index");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // backgroundColor: Colors.red,
      appBar: AppBar(
        backgroundColor: Colors.amber,
        title: Column(
          children: [
            Text('aaaaaaaaaa'),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton(
                  onPressed: () {
                    setState(() {
                      contentIndex = 0;
                    });
                  },
                  child: const Text("VOTING"),
                ),
                ElevatedButton(
                  onPressed: () {
                    setState(() {
                      contentIndex = 1;
                    });
                  },
                  child: const Text("ORDER"),
                ),
              ],
            ),
          ],
        ),
      ),
      body: _getContent(),
    );
  }
}
