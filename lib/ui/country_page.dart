import 'package:eurovision_app/core/app_core.dart';
import 'package:eurovision_app/models/country.dart';
import 'package:flutter/material.dart';

class CountryPage extends StatefulWidget {
  final Country country;
  const CountryPage({
    super.key,
    required this.country,
  });

  @override
  State<CountryPage> createState() => _CountryPageState();
}

class _CountryPageState extends State<CountryPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Column(
        children: [
          Container(
            height: 200,
            width: double.infinity,
            color: Colors.red,
            child: Center(
              child: Text("header sa naslovom xdd \n\n${widget.country.name}"),
            ),
          ),
          Text(widget.country.artist!),
          Text(widget.country.song!),
          Text(
              "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book."),
          ScoringWidget()
        ],
      ),
    );
  }
}

class ScoringWidget extends StatefulWidget {
  const ScoringWidget({super.key});

  @override
  State<ScoringWidget> createState() => _ScoringWidgetState();
}

class _ScoringWidgetState extends State<ScoringWidget> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(children: List.generate(5, (index) => ScoringButton(index + 1))),
        Row(children: List.generate(5, (index) => ScoringButton(index + 6))),
      ],
    );
  }
}

class ScoringButton extends StatelessWidget {
  final int point;
  const ScoringButton(
    this.point, {
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        ApplicationCore().authBloc.addCountryScore() // todo do this shit da ima imalo smisla, probs novi bloc..
      },
      child: Container(
        margin: EdgeInsets.all(4),
        padding: EdgeInsets.all(4),
        height: 35,
        width: 35,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(9999),
          border: Border.all(width: 1, color: Colors.black),
        ),
        child: Center(
          child: Text(
            point.toString(),
          ),
        ),
      ),
    );
  }
}
