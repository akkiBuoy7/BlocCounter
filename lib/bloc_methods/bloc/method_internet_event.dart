part of 'method_internet_bloc.dart';

@immutable
abstract class MethodInternetEvent {}

class MethodInitialInternetEvent extends MethodInternetEvent{}

class MethodInternetDisconnectedEvent extends MethodInternetEvent{

}

class MethodInternetConnectedEvent extends MethodInternetEvent{

  final MethodConnectivityType connectionType;

  MethodInternetConnectedEvent(this.connectionType);
}

