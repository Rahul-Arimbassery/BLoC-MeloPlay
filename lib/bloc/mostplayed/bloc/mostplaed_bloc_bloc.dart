import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:musicuitest/presentation/screens/nowplaying/nowplaying.dart';

part 'mostplaed_bloc_event.dart';
part 'mostplaed_bloc_state.dart';

class MostplaedBlocBloc extends Bloc<MostplaedBlocEvent, MostplaedBlocState> {
  
  final BuildContext context;
  MostplaedBlocBloc(this.context) : super(MostplaedBlocInitial()) {
    

    on<NavigateEvent>((event, emit) {
            Navigator.push(
        context,
        MaterialPageRoute(builder: (context) =>  NowPlaying(
          index: event.currentindex,
        )),
      );
    });
  }
}
