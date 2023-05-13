import 'package:eurovision_app/blocs/results/results_bloc.dart';
import 'package:eurovision_app/blocs/results/results_state.dart';
import 'package:eurovision_app/core/app_core.dart';
import 'package:eurovision_app/core/constants.dart';
import 'package:eurovision_app/models/country.dart';
import 'package:eurovision_app/models/results.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'home_page.dart';

class ResultsPage extends StatefulWidget {
  const ResultsPage({super.key});

  @override
  State<ResultsPage> createState() => _ResultsPageState();
}

class _ResultsPageState extends State<ResultsPage> {
  int _contentIndex = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(
            bottom: Radius.circular(10),
          ),
        ),
        backgroundColor: euroBlue,
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              'RESULTS',
              style: TextStyle(
                color: euroPink,
                fontWeight: FontWeight.bold,
                fontSize: 26,
              ),
            )
          ],
        ),
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
                    _contentIndex = index;
                  });
                },
                text: "POINTS",
                index: 0,
                isSelected: _contentIndex == 0,
              ),
              TabButton(
                onTap: (index) {
                  setState(() {
                    _contentIndex = index;
                  });
                },
                text: "ORDER",
                index: 1,
                isSelected: _contentIndex == 1,
              ),
            ],
          ),
          SizedBox(
            height: 15,
          ),
          Expanded(
            child: BlocBuilder<ResultsBloc, ResultsState>(
              bloc: ApplicationCore().resultsBloc,
              builder: (context, state) {
                if (state is ResultsSuccess) {
                  return SingleChildScrollView(
                    child: _contentIndex == 0
                        ? Column(
                            children: state.results.pointlist!
                                .map((e) => ResultPointWidget(item: e))
                                .toList(),
                          )
                        : Column(
                            children: state.results.orderItem!
                                .map((e) => ResultOrderWidget(item: e))
                                .toList(),
                          ),
                  );
                } else {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                }
              },
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          ApplicationCore().resultsBloc.getResults();
        },
        child: Icon(Icons.refresh),
      ),
    );
  }
}

class ResultPointWidget extends StatefulWidget {
  final ResultPointItem item;
  const ResultPointWidget({
    super.key,
    required this.item,
  });

  @override
  State<ResultPointWidget> createState() => _ResultPointWidgetState();
}

class _ResultPointWidgetState extends State<ResultPointWidget> {
  late Country country;
  @override
  void initState() {
    country =
        ApplicationCore().countriesBloc.getCountryById(widget.item.countryId!);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            SizedBox(
              height: 40,
              width: 40,
              child: SvgPicture.asset(
                  "assets/flags/${country.code!.toUpperCase()}.svg"),
            ),
            Text(
              "${country.name} | ${country.artist}",
              style: TextStyle(
                fontSize: 18,
              ),
            ),
            Text(
              "${widget.item.points}",
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 20,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class ResultOrderWidget extends StatefulWidget {
  final ResultOrderItem item;
  const ResultOrderWidget({
    super.key,
    required this.item,
  });

  @override
  State<ResultOrderWidget> createState() => _ResultOrderWidgetState();
}

class _ResultOrderWidgetState extends State<ResultOrderWidget> {
  late Country country;
  @override
  void initState() {
    country =
        ApplicationCore().countriesBloc.getCountryById(widget.item.countryId!);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            SizedBox(
              height: 40,
              width: 40,
              child: SvgPicture.asset(
                  "assets/flags/${country.code!.toUpperCase()}.svg"),
            ),
            Text(
              "${country.name} | ${country.artist}",
              style: TextStyle(
                fontSize: 18,
              ),
            ),
            Text(
              "${widget.item.order}",
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 20,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
