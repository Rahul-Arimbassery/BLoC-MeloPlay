part of 'search_bloc_bloc.dart';

class SearchBlocState {}

class SearchBlocInitial extends SearchBlocState {}

class SearchScreenstate extends SearchBlocState {
  final String searchQuery;
  final List<String> filteredSongNames;
  final List<int> filteredIds;

  SearchScreenstate({
    required this.searchQuery,
    required this.filteredSongNames,
    required this.filteredIds,
  });
}
