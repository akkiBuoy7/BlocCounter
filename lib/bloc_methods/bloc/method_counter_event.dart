part of 'method_counter_bloc.dart';


@immutable
abstract class MethodCounterEvent {}


class InitialMethodCounterEvent extends MethodCounterEvent{

}

class IncrementMethodCounterEvent extends MethodCounterEvent{

}

class DecrementMethodCounterEvent extends MethodCounterEvent{

}