import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:meta/meta.dart';

import '../../communication_bloc/utility/constants.dart';
import '../utility/method_constants.dart';

part 'method_internet_event.dart';
part 'method_internet_state.dart';

class MethodInternetBloc extends Bloc<MethodInternetEvent, MethodInternetState> {

  final Connectivity connectivity;
  StreamSubscription? connectivityStreamSubscription;

  MethodInternetBloc(this.connectivity) : super(MethodInternetLoadingState()) {

      monitorInternetConnection();

      on<MethodInternetConnectedEvent>((event, emit) {
        if(event.connectionType == MethodConnectivityType.WIFI){
          emit(MethodInternetConnectedState(connectionType: MethodConnectivityType.WIFI));
        }else if(event.connectionType == MethodConnectivityType.MOBILE){
          emit(MethodInternetConnectedState(connectionType: MethodConnectivityType.MOBILE));
        }
      });
      on<MethodInternetDisconnectedEvent>((event, emit) {
        emit(MethodInternetDisconnectedState());
      });


  }


  StreamSubscription<ConnectivityResult> monitorInternetConnection() {
    return connectivityStreamSubscription =
        connectivity.onConnectivityChanged.listen((connectivityResult) {
          if (connectivityResult == ConnectivityResult.wifi) {
            add(MethodInternetConnectedEvent(MethodConnectivityType.WIFI));

          } else if (connectivityResult == ConnectivityResult.mobile) {
            add(MethodInternetConnectedEvent(MethodConnectivityType.MOBILE));

          } else if (connectivityResult == ConnectivityResult.none) {
            add(MethodInternetDisconnectedEvent());

          }
        });
  }

  @override
  Future<void> close() {
    connectivityStreamSubscription?.cancel();
    return super.close();
  }
}
