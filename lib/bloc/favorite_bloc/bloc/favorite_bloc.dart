import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:musicuitest/presentation/screens/favorites/favoritepage.dart';
import 'package:musicuitest/presentation/screens/home/homepage.dart';

part 'favorite_event.dart';
part 'favorite_state.dart';

class FavoriteBloc extends Bloc<FavoriteEvent, FavoriteState> {
  FavoriteBloc() : super(FavoriteInitial()) {
    on<DeleteFavoriteEvent>((event, emit) {
      indexes.remove(event.currentindex);
      deleteSongFromFavorite(event.currentindex);
      emit(FavoriteUpdated(indexes));
    });
  }
}
