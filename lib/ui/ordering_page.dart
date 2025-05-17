import 'package:eurovision_app/blocs/ordering/ordering_bloc.dart';
import 'package:eurovision_app/blocs/ordering/ordering_state.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:eurovision_app/core/app_core.dart';
import 'package:eurovision_app/core/constants.dart';
import 'package:eurovision_app/models/country.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class OrderContent extends StatefulWidget {
  final OrderingBloc orderingBloc;
  const OrderContent({
    super.key,
    required this.orderingBloc,
  });

  @override
  State<OrderContent> createState() => _OrderContentState();
}

class _OrderContentState extends State<OrderContent> {
  bool _isLoading = false;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<OrderingBloc, OrderingState>(
      bloc: widget.orderingBloc,
      builder: (context, state) {
        if (state is OrderingReady) {
          _isLoading = false;
        } else {
          _isLoading = true;
        }
        return Opacity(
          opacity: _isLoading ? 0.2 : 1,
          child: IgnorePointer(
            ignoring: _isLoading,
            child: ReorderableListView(
              buildDefaultDragHandles: false,
              onReorder: (oldIndex, newIndex) {
                widget.orderingBloc.onOrderUpdate(oldIndex, newIndex);
              },
              children: List.generate(
                widget.orderingBloc.orders.length,
                (index) {
                  Country country = ApplicationCore()
                      .countriesBloc
                      .getCountryById(
                          widget.orderingBloc.orders[index].countryId);
                  return Stack(
                    key: ValueKey(widget.orderingBloc.orders[index]),
                    children: [
                      // margin: const EdgeInsets.all(15),
                      Container(
                          height: 100,
                          alignment: Alignment.center,
                          margin: const EdgeInsets.symmetric(
                              horizontal: 12, vertical: 12),
                          padding: const EdgeInsets.all(5),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(10),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey.withOpacity(0.5),
                                spreadRadius: 5,
                                blurRadius: 7,
                                offset:
                                    Offset(0, 1), // changes position of shadow
                              ),
                            ],
                          ),
                          child: Row(
                            children: [
                              Expanded(
                                flex: 30,
                                child: Stack(
                                  children: [
                                    Container(
                                      decoration: BoxDecoration(
                                        borderRadius: const BorderRadius.all(
                                          Radius.circular(10),
                                        ),
                                        image: DecorationImage(
                                          fit: BoxFit.cover,
                                          image: Image.asset(
                                                  "assets/artists/${country.code}.jpg")
                                              .image,
                                        ),
                                      ),
                                      // child: Image.asset("assets/artists/HR.png"),
                                    ),
                                    Positioned(
                                      bottom: 1,
                                      right: 1,
                                      child: Container(
                                        height: 40,
                                        width: 40,
                                        clipBehavior: Clip.antiAlias,
                                        decoration: const BoxDecoration(
                                          shape: BoxShape.circle,
                                          color: Colors.red,
                                        ),
                                        child: SvgPicture.asset(
                                          "assets/flags/${country.code!.toUpperCase()}.svg",
                                          fit: BoxFit.cover,
                                        ),
                                      ),
                                    )
                                  ],
                                ),
                              ),
                              Expanded(
                                flex: 50,
                                child: Padding(
                                  padding: const EdgeInsets.all(5.0),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        country.name!,
                                        style: TextStyle(
                                          fontSize: 20,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      Text(
                                        country.artist!,
                                        style: TextStyle(
                                          fontSize: 16,
                        overflow: TextOverflow.ellipsis,
                                        ),
                                      ),
                                      Text(
                                        country.song!,
                                        style: TextStyle(
                                          fontSize: 16,
                        overflow: TextOverflow.ellipsis,
                                        ),
                                        maxLines: 1,
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              Expanded(
                                flex: 20,
                                child: Center(
                                  child: Column(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Container(),
                                      Container(
                                        height: 52,
                                        width: 52,
                                        decoration: BoxDecoration(
                                          shape: BoxShape.circle,
                                          color: euroBlue,
                                        ),
                                        child: Center(
                                          child: Container(
                                            height: 45,
                                            width: 45,
                                            decoration: BoxDecoration(
                                              shape: BoxShape.circle,
                                              color: Colors.white,
                                            ),
                                            child: Center(
                                              child: Container(
                                                height: 38,
                                                width: 38,
                                                decoration: BoxDecoration(
                                                  shape: BoxShape.circle,
                                                  color: euroBlue,
                                                ),
                                                child: Center(
                                                  child: FittedBox(
                                                    fit: BoxFit.cover,
                                                    child: Text(
                                                      widget
                                                          .orderingBloc
                                                          .orders[index]
                                                          .orderNumber
                                                          .toString(),
                                                      style: const TextStyle(
                                                        color: Colors.white,
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        fontSize: 18,
                                                      ),
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
                                  ),
                                ),
                              ),
                            ],
                          )
                          // child: Text(
                          //   "country ${orderingBloc.orders[index].countryId} | order: ${orderingBloc.orders[index].orderNumber} | $index",
                          //   style: const TextStyle(fontSize: 30),
                          // ),
                          ),

                      Positioned(
                        right: 10,
                        child: ReorderableDragStartListener(
                          index: index,
                          child: Container(
                            height: 40,
                            width: 40,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: euroPink,
                            ),
                            child: Stack(
                              children: const [
                                Positioned(
                                  top: 2,
                                  left: 0,
                                  right: 0,
                                  child: Icon(
                                    Icons.arrow_upward,
                                    color: Colors.white,
                                  ),
                                ),
                                Positioned(
                                  bottom: 2,
                                  left: 0,
                                  right: 0,
                                  child: Icon(
                                    Icons.arrow_downward,
                                    color: Colors.white,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      )
                    ],
                  );
                },
              ),
            ),
          ),
        );
      },
    );
  }
}
