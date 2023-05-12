import 'package:eurovision_app/blocs/ordering/ordering_bloc.dart';
import 'package:eurovision_app/blocs/ordering/ordering_state.dart';
import 'package:eurovision_app/blocs/voting/voting_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class OrderContent extends StatefulWidget {
  const OrderContent({super.key});

  @override
  State<OrderContent> createState() => _OrderContentState();
}

class _OrderContentState extends State<OrderContent> {
  OrderingBloc orderingBloc = OrderingBloc();
  bool _isLoading = false;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<OrderingBloc, OrderingState>(
      bloc: orderingBloc,
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
                orderingBloc.onOrderUpdate(oldIndex, newIndex);
              },
              children: List.generate(
                orderingBloc.orders.length,
                (index) {
                  return Stack(
                    key: ValueKey(orderingBloc.orders[index]),
                    children: [
                      Card(
                        margin: const EdgeInsets.all(15),
                        child: Container(
                          color: Colors.red[100 * (index % 9 + 1)],
                          height: 80,
                          alignment: Alignment.center,
                          child: Text(
                            "country ${orderingBloc.orders[index].countryId} | order: ${orderingBloc.orders[index].orderNumber} | $index",
                            style: const TextStyle(fontSize: 30),
                          ),
                        ),
                      ),
                      Positioned(
                        right: 10,
                        child: ReorderableDragStartListener(
                          index: index,
                          child: Container(
                            height: 40,
                            width: 40,
                            color: Colors.blue,
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
