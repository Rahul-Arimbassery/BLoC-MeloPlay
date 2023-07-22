import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:musicuitest/presentation/screens/navigator/navigatorpage.dart';
import 'package:musicuitest/presentation/screens/nowplaying/nowplaying.dart';
import 'package:musicuitest/presentation/screens/recent/recentpage.dart';

part 'recent_bloc_event.dart';
part 'recent_bloc_state.dart';

class RecentBlocBloc extends Bloc<RecentBlocEvent, RecentBlocState> {
  final BuildContext context;
  RecentBlocBloc(this.context) : super(RecentBlocInitial()) {
    on<RecentEvent>((event, emit) {
      _clearRecentSongs(context);
    });
  }
}

void _clearRecentSongs(BuildContext context) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: const Text('Clear Recent Songs'),
        content: const Text('Are you sure you want to clear the recent songs?'),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(context);
            },
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () {
              recentArray.clear();
              saveRecentArray();
              Navigator.pop(context);
              Fluttertoast.showToast(
                msg: 'All Recent Songs Cleared!!!',
                backgroundColor: const Color.fromARGB(255, 27, 164, 179),
                toastLength: Toast.LENGTH_SHORT,
                gravity: ToastGravity.CENTER,
              );
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => NavigatorPage(),
                ),
              );
            },
            child: const Text('Clear'),
          ),
        ],
      );
    },
  );
}
