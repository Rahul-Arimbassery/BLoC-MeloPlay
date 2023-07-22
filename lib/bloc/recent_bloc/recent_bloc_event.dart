part of 'recent_bloc_bloc.dart';

class RecentBlocEvent {}

class RecentEvent extends RecentBlocEvent {
  final context;

  RecentEvent({required this.context});
}
