import 'package:eurovision_app/blocs/countries/countries_bloc.dart';
import 'package:eurovision_app/blocs/countries/countries_state.dart';
import 'package:eurovision_app/core/app_core.dart';
import 'package:eurovision_app/core/constants.dart';
import 'package:eurovision_app/ui/ordering_page.dart';
import 'package:eurovision_app/ui/results_page.dart';
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
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(
            bottom: Radius.circular(10),
          ),
        ),
        backgroundColor: euroBlue,
        title: GestureDetector(
          onDoubleTap: () => ApplicationCore().authBloc.logOut(),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                'EUROVISION 2023',
                style: TextStyle(
                    color: euroPink, fontWeight: FontWeight.bold, fontSize: 26),
              )
            ],
          ),
        ),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.of(context).push(MaterialPageRoute(builder: (context) {
                return const ResultsPage();
              }));
            },
            icon: Icon(
              Icons.paste,
              color: euroPink,
              size: 28,
            ),
          )
        ],
      ),
      body: Column(
        children: [
          SizedBox(
            height: 15,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              TabButton(
                onTap: (index) {
                  setState(() {
                    contentIndex = index;
                  });
                },
                text: "POINTS",
                index: 0,
                isSelected: contentIndex == 0,
              ),
              TabButton(
                onTap: (index) {
                  setState(() {
                    contentIndex = index;
                  });
                },
                text: "ORDER",
                index: 1,
                isSelected: contentIndex == 1,
              ),
            ],
          ),
          SizedBox(
            height: 15,
          ),
          Expanded(
            child: _getContent(),
          ),
        ],
      ),
    );
  }
}

class TabButton extends StatelessWidget {
  final bool isSelected;
  final int index;
  final String text;
  final Function(int) onTap;
  const TabButton({
    super.key,
    required this.isSelected,
    required this.index,
    required this.text,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => onTap(index),
      child: Container(
        width: MediaQuery.of(context).size.width * 0.3,
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: isSelected ? euroBlue : Colors.white,
          borderRadius: BorderRadius.circular(9999),
          boxShadow: !isSelected
              ? [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.5),
                    spreadRadius: 5,
                    blurRadius: 7,
                    offset: Offset(0, 1), // changes position of shadow
                  ),
                ]
              : [],
        ),
        child: Center(
          child: Text(
            text,
            style: TextStyle(
              fontSize: 24,
              color: isSelected ? Colors.white : euroBlue,
            ),
          ),
        ),
      ),
    );
  }
}
