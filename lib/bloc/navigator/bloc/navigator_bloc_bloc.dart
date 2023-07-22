import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'navigator_bloc_event.dart';
part 'navigator_bloc_state.dart';

class NavigatorBlocBloc extends Bloc<NavigatorBlocEvent, NavigatorBlocState> {
  NavigatorBlocBloc() : super(NavigatorBlocInitial()) {
    on<PageNavigateEvent>((event, emit) {
      emit(PageNavigateSuccess(currentIndex: event.currentIndex));
    });

    on<SkipPreviousEvent>((event, emit) {
      emit(SkipPreviousState(songNameindexnew: (event.songNameindexnew) + 1));
    });

    on<SkipNextEvent>((event, emit) {
      emit(SkipNextState(songNameindexnewone: (event.songNameindexnewone) + 1));
    });

    on<StopMiniPlayerEvent>((event, emit) {
      emit(StopMiniPlayerState(showMiniPlayer: event.showMiniPlayer));
    });

    on<PlayPauseEvent>((event, emit) {
      emit(PlayPauseState(isPlaying1: !(event.isPlaying1)));
    });
  }
}
