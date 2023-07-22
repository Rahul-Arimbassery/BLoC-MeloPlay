part of 'navigator_bloc_bloc.dart';

class NavigatorBlocEvent {}

class PageNavigateEvent extends NavigatorBlocEvent {
  final int currentIndex;

  PageNavigateEvent({required this.currentIndex});
}

class SkipPreviousEvent extends NavigatorBlocEvent {
  final int songNameindexnew;

  SkipPreviousEvent({required this.songNameindexnew});
}

class SkipNextEvent extends NavigatorBlocEvent {
  final int songNameindexnewone;

  SkipNextEvent({required this.songNameindexnewone});
}

class PlayPauseEvent extends NavigatorBlocEvent {
    final bool isPlaying1;

  PlayPauseEvent({required this.isPlaying1});
}

class StopMiniPlayerEvent extends NavigatorBlocEvent {
  final bool showMiniPlayer;

  StopMiniPlayerEvent({required this.showMiniPlayer});
}
