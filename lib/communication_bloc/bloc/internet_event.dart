part of 'internet_bloc.dart';

@immutable
abstract class InternetEvent {}

class InitialInternetEvent extends InternetEvent{

}

class InternetDisconnectedEvent extends InternetEvent{

}

class InternetConnectedEvent extends InternetEvent{

  final ConnectivityType connectionType;

  InternetConnectedEvent(this.connectionType);
}