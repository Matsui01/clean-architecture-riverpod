import 'package:dio/dio.dart';

abstract class BaseState {
  dynamic data;
  final DioException? dioException;

  BaseState({
    this.data,
    this.dioException,
  });
}

class StateLoading extends BaseState {
  StateLoading();
}

class StateSuccess<T> extends BaseState {
  StateSuccess({super.data});
}

class StateFailed extends BaseState {
  StateFailed({super.dioException});
}
