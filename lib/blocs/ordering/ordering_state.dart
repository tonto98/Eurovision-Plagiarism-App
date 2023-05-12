import 'package:eurovision_app/models/user.dart';

abstract class OrderingState {}

class OrderingReady extends OrderingState {
  final List<OrderItem> orders;
  OrderingReady(this.orders);
}

class OrderingLoading extends OrderingState {}
