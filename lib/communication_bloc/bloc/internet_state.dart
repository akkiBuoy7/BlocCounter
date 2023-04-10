part of 'internet_bloc.dart';

@immutable
abstract class InternetState {}

class InternetLoading extends InternetState {}

class InternetConnected extends InternetState {
  final ConnectivityType connectionType;

  InternetConnected({required this.connectionType});
}

class InternetDisconnected extends InternetState {}