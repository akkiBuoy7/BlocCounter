part of 'counter_bloc.dart';

abstract class CounterBlocState {
  int counterValue;

  CounterBlocState(this.counterValue);
}

class CounterBlocInitialState extends CounterBlocState {
  int counterValue1;

  CounterBlocInitialState({required this.counterValue1}) : super(counterValue1);
}

class CounterBlocIncrementState extends CounterBlocState {
  int counterValue1;

  CounterBlocIncrementState({required this.counterValue1}) : super(counterValue1);
}

class CounterBlocDecrementState extends CounterBlocState {
  int counterValue1;

  CounterBlocDecrementState({required this.counterValue1}) : super(counterValue1);
}
