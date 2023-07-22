part of 'favorite_bloc.dart';

class FavoriteEvent {}

class DeleteFavoriteEvent extends FavoriteEvent {
  final int currentindex;

  DeleteFavoriteEvent({required this.currentindex});
}
