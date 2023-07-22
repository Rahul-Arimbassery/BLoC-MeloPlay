import 'package:bloc/bloc.dart';
import 'package:musicuitest/controller/searchpage.dart';
import 'package:musicuitest/utils/globalpage.dart';
part 'search_bloc_event.dart';
part 'search_bloc_state.dart';

class SearchBlocBloc extends Bloc<SearchBlocEvent, SearchBlocState> {
  SearchBlocBloc() : super(SearchBlocInitial()) {
    on<InitialSearch>((event, emit) {
      emit(SearchBlocInitial());
    });

    on<SearchLogic>((event, emit) {
      filteredSongNames = songNames
          .where((songName) =>
              songName.toLowerCase().contains(event.searchQuery.toLowerCase()))
          .toList();
      filteredIds = ids
          .where((id) => filteredSongNames.contains(songNames[ids.indexOf(id)]))
          .toList();

      emit(SearchScreenstate(
          searchQuery: event.searchQuery,
          filteredSongNames: event.filteredSongNames,
          filteredIds: event.filteredIds));
    });
  }
}
