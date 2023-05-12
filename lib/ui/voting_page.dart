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
          return ListView(
              children: List.generate(
                  state.countries.length,
                  (index) =>
                      CountryItemWidget(country: state.countries[index])));
        } else {
          return Container(
            child: Text("error :c"),
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
        height: 100,
        margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
        padding: const EdgeInsets.all(5),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.5),
              spreadRadius: 5,
              blurRadius: 7,
              offset: Offset(0, 1), // changes position of shadow
            ),
          ],
        ),
        child: Row(
          children: [
            Expanded(
              flex: 30,
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  image: DecorationImage(
                    image: Image.asset("assets/artists/HR.png").image,
                  ),
                ),
                // child: Image.asset("assets/artists/HR.png"),
              ),
            ),
            Expanded(
              flex: 50,
              child: Padding(
                padding: const EdgeInsets.all(5.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      widget.country.name!,
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      widget.country.artist!,
                      style: TextStyle(
                        fontSize: 18,
                      ),
                    ),
                    Text(
                      widget.country.song!,
                      style: TextStyle(
                        fontSize: 18,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Expanded(
              flex: 20,
              child: Center(
                  child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(),
                  Container(
                    height: 52,
                    width: 52,
                    decoration: const BoxDecoration(
                      shape: BoxShape.circle,
                      color: Color.fromRGBO(255, 0, 255, 1),
                    ),
                    child: Center(
                      child: Container(
                        height: 45,
                        width: 45,
                        decoration: const BoxDecoration(
                          shape: BoxShape.circle,
                          color: Colors.white,
                        ),
                        child: Center(
                          child: Container(
                            height: 38,
                            width: 38,
                            decoration: const BoxDecoration(
                              shape: BoxShape.circle,
                              color: Color.fromRGBO(255, 0, 255, 1),
                            ),
                            child: Center(
                              child: FittedBox(
                                fit: BoxFit.cover,
                                child: ApplicationCore()
                                            .authBloc
                                            .getPointsForCountry(
                                                widget.country.id!) ==
                                        null
                                    ? const Icon(
                                        Icons.arrow_right_alt_rounded,
                                        color: Colors.white,
                                      )
                                    : Text(
                                        ApplicationCore()
                                            .authBloc
                                            .getPointsForCountry(
                                                widget.country.id!)
                                            .toString(),
                                        style: const TextStyle(
                                            color: Colors.white,
                                            fontWeight: FontWeight.bold),
                                      ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  Container(),
                  // Text(
                  //   (ApplicationCore()
                  //               .authBloc
                  //               .getPointsForCountry(widget.country.id!) ??
                  //           0)
                  //       .toString(),
                  // ),
                ],
              )),
            ),
          ],
        ),
      ),
    );
  }
}
