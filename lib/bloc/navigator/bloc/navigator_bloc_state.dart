part of 'navigator_bloc_bloc.dart';

@immutable
abstract class NavigatorBlocState {}

class NavigatorBlocInitial extends NavigatorBlocState {}

class PageNavigateSuccess extends NavigatorBlocState {
  final int currentIndex;

  PageNavigateSuccess({required this.currentIndex});
}

class SkipPreviousState extends NavigatorBlocState {
  final int songNameindexnew;

  SkipPreviousState({required this.songNameindexnew});
}

class SkipNextState extends NavigatorBlocState {
  final int songNameindexnewone;

  SkipNextState({required this.songNameindexnewone});
}

class StopMiniPlayerState extends NavigatorBlocState {
  final bool showMiniPlayer;

  StopMiniPlayerState({required this.showMiniPlayer});
}

class PlayPauseState extends NavigatorBlocState {
  final bool isPlaying1;

  PlayPauseState({required this.isPlaying1});
}