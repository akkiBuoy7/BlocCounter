part of 'counter_cubit.dart';


abstract class CounterCubitState {
  int counterValue;

  CounterCubitState(this.counterValue);
}

class CounterCubitInitialState extends CounterCubitState {
  int counterValue1;

  CounterCubitInitialState({required this.counterValue1}) : super(counterValue1);
}

class CounterCubitIncrementState extends CounterCubitState {
  int counterValue1;

  CounterCubitIncrementState({required this.counterValue1}) : super(counterValue1);
}

class CounterCubitDecrementState extends CounterCubitState {
  int counterValue1;

  CounterCubitDecrementState({required this.counterValue1}) : super(counterValue1);
}