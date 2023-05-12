import 'package:eurovision_app/core/app_core.dart';
import 'package:eurovision_app/models/user.dart';
import 'package:eurovision_app/repository/voting_repo.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'ordering_state.dart';

class OrderingBloc extends Cubit<OrderingState> {
  OrderingBloc() : super(OrderingLoading()) {
    ApplicationCore().authBloc.stream.listen((event) {
      ApplicationCore().countriesBloc.updateCountriesState();
      orders = [...ApplicationCore().authBloc.user!.orderItems];
      _sortByOrder();
      emit(OrderingReady(orders));
    });
    orders = [...ApplicationCore().authBloc.user!.orderItems];
    _sortByOrder();
    emit(OrderingReady(orders));
  }

  List<OrderItem> orders = [];

  void onOrderUpdate(int oldIndex, int newIndex) async {
    emit(OrderingLoading());
    await Future.delayed(Duration(milliseconds: 300));
    if (newIndex > oldIndex) newIndex--;

    final item = orders.removeAt(oldIndex);
    orders.insert(newIndex, item);

    _matchOrderToIndex();

    emit(OrderingReady(orders));

    await VotingRepository.setOrder(orders);
    ApplicationCore().authBloc.refresnUserData();
  }

  void _matchOrderToIndex() {
    for (var element in orders) {
      element.orderNumber = 2;
    }
    for (var i = 0; i < orders.length; i++) {
      orders[i].orderNumber = i + 1;
    }
  }

  void _sortByOrder() {
    orders.sort((a, b) {
      if (a.orderNumber < b.orderNumber) {
        return -1;
      } else if (a.orderNumber > b.orderNumber) {
        return 1;
      } else {
        return 0;
      }
    });
  }
}
