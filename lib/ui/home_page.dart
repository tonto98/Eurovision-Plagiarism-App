import 'package:eurovision_app/blocs/ordering/ordering_bloc.dart';
import 'package:eurovision_app/core/app_core.dart';
import 'package:eurovision_app/core/constants.dart';
import 'package:eurovision_app/models/user.dart';
import 'package:eurovision_app/repository/voting_repo.dart';
import 'package:eurovision_app/ui/ordering_page.dart';
import 'package:eurovision_app/ui/results_page.dart';
import 'package:eurovision_app/ui/voting_page.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({
    super.key,
  });

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int contentIndex = 0;
  OrderingBloc orderingBloc = OrderingBloc();

  Widget _getContent() {
    switch (contentIndex) {
      case 0:
        return VotingContent();
      case 1:
        return OrderContent(
          orderingBloc: orderingBloc,
        );
      default:
        return const Text("invalid index");
    }
  }

  void _pointsToOrder() {
    var a = ApplicationCore().countriesBloc.getCountriesSorted();
    int order = 0;
    VotingRepository.setOrder(
      a.map(
        (e) {
          order++;
          return OrderItem(
            countryId: e.id!,
            orderNumber: order,
          );
        },
      ).toList(),
    ).then((value) => ApplicationCore().authBloc.refresnUserData());
    Navigator.of(context).pop(); // Zatvara dialog
  }

  void debounce() {
    taps++;
    if (taps >= 3) {
      ApplicationCore().authBloc.logOut();
    }
    Future.delayed(const Duration(seconds: 2), () {
      taps = 0;
    });
  }

  int taps = 0;

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
          onDoubleTap: () => debounce(),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                'EUROVISION 2024',
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
              Icons.leaderboard,
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
              Stack(
                children: [
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
                  Positioned(
                    bottom: 0,
                    right: 0,
                    child: Transform.translate(
                      offset: Offset(10, 10),
                      child: GestureDetector(
                        onTap: () {
                          print("aaaaaaaa");
                          showDialog(
                            context: context,
                            builder: (context) {
                              return AlertDialog(
                                title: Text('POZOR!'),
                                content: Text(
                                    'Jeste li sigurni da želite pregaziti listu "ORDER" sa listom sortiranom po zasada dodijeljenim bodovima?'),
                                actions: <Widget>[
                                  TextButton(
                                    onPressed: _pointsToOrder,
                                    child: Text('Da'),
                                  ),
                                  TextButton(
                                    onPressed: () {
                                      Navigator.of(context)
                                          .pop(); // Zatvara dialog
                                    },
                                    child: Text('Ne'),
                                  ),
                                ],
                              );
                            },
                          );
                        },
                        child: Container(
                          height: 35,
                          width: 35,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: euroPink,
                          ),
                          child: Center(
                            child: Icon(
                              Icons.copy,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                    ),
                  )
                ],
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
        padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 5),
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
