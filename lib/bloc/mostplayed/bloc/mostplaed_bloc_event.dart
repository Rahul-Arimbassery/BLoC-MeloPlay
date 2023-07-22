part of 'mostplaed_bloc_bloc.dart';

class MostplaedBlocEvent {}

class NavigateEvent extends MostplaedBlocEvent {
  final int currentindex;

  NavigateEvent(this.currentindex);
}
