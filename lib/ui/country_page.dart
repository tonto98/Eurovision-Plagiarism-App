import 'package:eurovision_app/blocs/voting/voting_bloc.dart';
import 'package:eurovision_app/blocs/voting/voting_state.dart';
import 'package:eurovision_app/core/app_core.dart';
import 'package:eurovision_app/core/constants.dart';
import 'package:eurovision_app/models/country.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:url_launcher/url_launcher.dart';

import 'lyrics_page.dart';

class CountryPage extends StatefulWidget {
  final Country country;
  const CountryPage({
    super.key,
    required this.country,
  });

  @override
  State<CountryPage> createState() => _CountryPageState();
}

Future<void> _launchUrl(String song) async {
  List<String> words = song.split(" ");
  String query = "";
  for (var word in words) {
    query += (word + "+");
  }

  String search = "https://www.youtube.com/results?search_query=$query";
  if (!await launchUrl(Uri.parse(search))) {
    print(":/");
    // throw Exception('Could not launch $url');
  }
}

class _CountryPageState extends State<CountryPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Column(
            children: [
              Container(
                height: 200,
                width: double.infinity,
                child: Image.asset(
                  "assets/artists/${widget.country.code}.jpg",
                  fit: BoxFit.cover,
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Text(
                widget.country.artist!,
                style: TextStyle(
                  fontSize: 26,
                  fontWeight: FontWeight.w600,
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Text(
                widget.country.song!,
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.w500,
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  GestureDetector(
                    onTap: () {
                      _launchUrl(widget.country.song!);
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
                  GestureDetector(
                    onTap: () => Navigator.of(context)
                        .push(MaterialPageRoute(builder: (context) {
                      return LyricsPage(country: widget.country);
                    })),
                    child: Container(
                      height: 60,
                      width: 60,
                      decoration: BoxDecoration(
                        color: euroBlue,
                        shape: BoxShape.circle,
                      ),
                      child: Center(
                        child: Icon(
                          Icons.lyrics,
                          color: euroPink,
                          size: 40,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 20,
              ),
              ScoringWidget(
                countryId: widget.country.id!,
              )
            ],
          ),
          Positioned(
            top: 10,
            left: 10,
            child: GestureDetector(
              onTap: () => Navigator.of(context).pop(),
              child: Container(
                height: 45,
                width: 45,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: euroBlue,
                ),
                child: Center(
                  child: Icon(
                    Icons.arrow_back,
                    color: euroPink,
                  ),
                ),
              ),
            ),
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
          child: Opacity(
            opacity: isLoading ? 0.5 : 1,
            child: Center(
              child: Column(
                children: [
                  Row(
                    mainAxisSize: MainAxisSize.min,
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
                    mainAxisSize: MainAxisSize.min,
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
        margin: const EdgeInsets.all(10),
        padding: const EdgeInsets.all(4),
        height: 48,
        width: 48,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(9999),
          // border: Border.all(width: 1, color: Colors.black),
          color: isSelected ? euroYellow : Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.5),
              spreadRadius: 2,
              blurRadius: 4,
              offset: Offset(0, 1), // changes position of shadow
            ),
          ],
        ),
        child: Center(
          child: Text(
            point.toString(),
            style: TextStyle(fontSize: 22),
          ),
        ),
      ),
    );
  }
}
