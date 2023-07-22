part of 'favorite_bloc.dart';

@immutable
abstract class FavoriteState {}

class FavoriteInitial extends FavoriteState {}

class FavoriteUpdated extends FavoriteState {
  final List<int> indexes;

  FavoriteUpdated(this.indexes);
}