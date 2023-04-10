import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:meta/meta.dart';

import '../../communication_cubit/utility/constants.dart';

part 'internet_event.dart';
part 'internet_state.dart';

class InternetBlocCommunication extends Bloc<InternetEvent, InternetState> {
  final Connectivity connectivity;
  StreamSubscription? connectivityStreamSubscription;

  InternetBlocCommunication(this.connectivity) : super(InternetLoading()) {
    monitorInternetConnection();

    on<InternetConnectedEvent>((event, emit) {
      if(event.connectionType == ConnectivityType.WIFI){
        emit(InternetConnected(connectionType: ConnectivityType.WIFI));
      }else if(event.connectionType == ConnectivityType.MOBILE){
        emit(InternetConnected(connectionType: ConnectivityType.MOBILE));
      }
    });
    on<InternetDisconnectedEvent>((event, emit) {
      emit(InternetDisconnected());
    });
  }

  StreamSubscription<ConnectivityResult> monitorInternetConnection() {
    return connectivityStreamSubscription =
        connectivity.onConnectivityChanged.listen((connectivityResult) {
      if (connectivityResult == ConnectivityResult.wifi) {
        add(InternetConnectedEvent(ConnectivityType.WIFI));

      } else if (connectivityResult == ConnectivityResult.mobile) {
        add(InternetConnectedEvent(ConnectivityType.MOBILE));

      } else if (connectivityResult == ConnectivityResult.none) {
        add(InternetDisconnectedEvent());

      }
    });
  }

  @override
  Future<void> close() {
    connectivityStreamSubscription?.cancel();
    return super.close();
  }
}
