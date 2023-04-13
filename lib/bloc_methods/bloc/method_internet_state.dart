part of 'method_internet_bloc.dart';

@immutable
abstract class MethodInternetState {
}

class MethodInternetLoadingState extends MethodInternetState {}

class MethodInternetConnectedState extends MethodInternetState {
  final MethodConnectivityType connectionType;

  MethodInternetConnectedState({required this.connectionType});
}

class MethodInternetDisconnectedState extends MethodInternetState {}

