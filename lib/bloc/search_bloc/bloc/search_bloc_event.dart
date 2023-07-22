part of 'search_bloc_bloc.dart';

class SearchBlocEvent {}

class InitialSearch extends SearchBlocEvent {}

class SearchLogic extends SearchBlocEvent {
  final String searchQuery;
  final List<String> filteredSongNames;
  final List<int> filteredIds;

  SearchLogic(
      {required this.filteredSongNames,
      required this.searchQuery,
      required this.filteredIds});
}
