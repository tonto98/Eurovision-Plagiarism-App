import 'package:eurovision_app/blocs/countries/countries_bloc.dart';
import 'package:eurovision_app/blocs/countries/countries_state.dart';
import 'package:eurovision_app/core/app_core.dart';
import 'package:eurovision_app/models/country.dart';
import 'package:eurovision_app/ui/country_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class VotingContent extends StatelessWidget {
  const VotingContent({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CountriesBloc, CountriesState>(
      bloc: ApplicationCore().countriesBloc,
      builder: (context, state) {
        if (state is CountriesSuccess) {
          return SliverList(
            delegate: SliverChildBuilderDelegate(
              (BuildContext context, int index) {
                return CountryItemWidget(country: state.countries[index]);
              },
              childCount: state.countries.length,
            ),
          );
        } else {
          return SliverList(
            delegate: SliverChildBuilderDelegate(
              (BuildContext context, int index) {
                return Container(
                  child: Text("error :c"),
                );
              },
              childCount: 1,
            ),
          );
        }
      },
    );
  }
}

class CountryItemWidget extends StatefulWidget {
  final Country country;
  const CountryItemWidget({
    super.key,
    required this.country,
  });

  @override
  State<CountryItemWidget> createState() => _CountryItemWidgetState();
}

class _CountryItemWidgetState extends State<CountryItemWidget> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) {
              return CountryPage(country: widget.country);
            },
          ),
        );
      },
      child: Container(
        height: 80,
        margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 12),
        child: Row(
          children: [
            Expanded(
              flex: 30,
              child: Container(
                color: Colors.blue,
                child: Center(
                  child: Text(widget.country.code ?? "??"),
                ),
              ),
            ),
            Expanded(
              flex: 50,
              child: Container(
                color: Colors.red,
                child: Center(
                  child: Column(
                    children: [
                      Text(widget.country.name!),
                      Text(widget.country.artist!),
                      Text(widget.country.song!),
                    ],
                  ),
                ),
              ),
            ),
            Expanded(
              flex: 20,
              child: Container(
                color: Colors.yellow,
                child: Center(
                    child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      (ApplicationCore()
                                  .authBloc
                                  .getPointsForCountry(widget.country.id!) ??
                              0)
                          .toString(),
                      style: TextStyle(color: Colors.transparent),
                    ),
                    Container(
                      height: 40,
                      width: 40,
                      color: Colors.green,
                    ),
                    Text(
                      (ApplicationCore()
                                  .authBloc
                                  .getPointsForCountry(widget.country.id!) ??
                              0)
                          .toString(),
                    ),
                  ],
                )),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
