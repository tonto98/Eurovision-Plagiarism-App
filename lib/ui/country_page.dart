import 'package:eurovision_app/blocs/voting/voting_bloc.dart';
import 'package:eurovision_app/blocs/voting/voting_state.dart';
import 'package:eurovision_app/core/app_core.dart';
import 'package:eurovision_app/models/country.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

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
          ScoringWidget(
            countryId: widget.country.id!,
          )
        ],
      ),
    );
  }
}

class ScoringWidget extends StatefulWidget {
  final int countryId;
  const ScoringWidget({
    super.key,
    required this.countryId,
  });

  @override
  State<ScoringWidget> createState() => _ScoringWidgetState();
}

class _ScoringWidgetState extends State<ScoringWidget> {
  VotingBloc votingBloc = VotingBloc();
  bool isLoading = false;
  void onTap(int point) {
    votingBloc.castVote(widget.countryId, point);
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<VotingBloc, VotingState>(
      bloc: votingBloc,
      builder: (context, state) {
        if (state is VotingLoading) {
          isLoading = true;
        } else {
          isLoading = false;
        }
        return IgnorePointer(
          ignoring: isLoading,
          child: Stack(
            children: [
              Opacity(
                opacity: isLoading ? 0.5 : 1,
                child: Column(
                  children: [
                    Row(
                      children: List.generate(
                        5,
                        (index) => ScoringButton(
                          index + 1,
                          isSelected: (index + 1) ==
                              ApplicationCore()
                                  .authBloc
                                  .getPointsForCountry(widget.countryId),
                          onTap: onTap,
                        ),
                      ),
                    ),
                    Row(
                      children: List.generate(
                        5,
                        (index) => ScoringButton(
                          index + 6,
                          isSelected: (index + 6) ==
                              ApplicationCore()
                                  .authBloc
                                  .getPointsForCountry(widget.countryId),
                          onTap: onTap,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              // isLoading
              //     ? Container(
              //         height: 80,
              //         width: 5 * 44,
              //         decoration: BoxDecoration(
              //           color: Colors.transparent,
              //           borderRadius: const BorderRadius.only(
              //             topLeft: Radius.circular(10),
              //             topRight: Radius.circular(10),
              //             bottomLeft: Radius.circular(10),
              //             bottomRight: Radius.circular(10),
              //           ),
              //           boxShadow: [
              //             BoxShadow(
              //               color: Colors.grey.withOpacity(0.5),
              //               spreadRadius: 5,
              //               blurRadius: 7,
              //               offset: const Offset(
              //                   0, 0), // changes position of shadow
              //             ),
              //           ],
              //         ),
              //       )
              //     : Container()
            ],
          ),
        );
      },
    );
  }
}

class ScoringButton extends StatelessWidget {
  final int point;
  final bool isSelected;
  final Function(int) onTap;
  const ScoringButton(
    this.point, {
    required this.isSelected,
    required this.onTap,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        onTap(point);
      },
      child: Container(
        margin: const EdgeInsets.all(4),
        padding: const EdgeInsets.all(4),
        height: 35,
        width: 35,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(9999),
          border: Border.all(width: 1, color: Colors.black),
          color: isSelected ? Colors.blue[300] : Colors.white,
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
