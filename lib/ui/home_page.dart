import 'package:eurovision_app/blocs/countries/countries_bloc.dart';
import 'package:eurovision_app/blocs/countries/countries_state.dart';
import 'package:eurovision_app/core/app_core.dart';
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
      body: CustomScrollView(
        slivers: [
          const SliverAppBar(
            backgroundColor: Colors.amber,
            title: Text('tu stavit lijepu sliku \nsa tekstom stagod'),
            expandedHeight: 30,
            collapsedHeight: 150,
          ),
          SliverAppBar(
            backgroundColor: Colors.green,
            title: Row(
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
                    ApplicationCore().authBloc.logOut();
                    setState(() {
                      contentIndex = 1;
                    });
                  },
                  child: const Text("ORDER"),
                ),
              ],
            ),
            floating: true,
          ),
          _getContent(),
        ],
      ),
    );
  }
}

class OrderContent extends StatelessWidget {
  const OrderContent({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CountriesBloc, CountriesState>(
      builder: (context, state) {
        return SliverList(
          delegate: SliverChildBuilderDelegate(
            (BuildContext context, int index) {
              return Card(
                margin: const EdgeInsets.all(15),
                child: Container(
                  color: Colors.red[100 * (index % 9 + 1)],
                  height: 80,
                  alignment: Alignment.center,
                  child: Text(
                    "Item $index",
                    style: const TextStyle(fontSize: 30),
                  ),
                ),
              );
            },
            childCount: 1000, // 1000 list items
          ),
        );
      },
    );
  }
}
