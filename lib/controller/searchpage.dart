//BLoc - Implemented BLoC Logic and stateless
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:musicuitest/bloc/search_bloc/bloc/search_bloc_bloc.dart';
import 'package:musicuitest/presentation/screens/home/homepage.dart';
import 'package:musicuitest/presentation/screens/navigator/navigatorpage.dart';
import 'package:musicuitest/presentation/screens/nowplaying/nowplaying.dart';
import 'package:musicuitest/presentation/screens/playlist/playlistpage.dart';
import 'package:musicuitest/utils/globalpage.dart';
import 'package:on_audio_query/on_audio_query.dart';

List<String> filteredSongNames = [];
List<int> filteredIds = [];

final OnAudioQuery _audioQuery = OnAudioQuery();

class SearchPage extends StatelessWidget {
  final List<String> songNames;
  final List<int> ids; // Add the list of IDs

  const SearchPage({Key? key, required this.songNames, required this.ids})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => SearchBlocBloc(),
      child: Scaffold(
        appBar: AppBar(
          leading: IconButton(
            icon: const Icon(Icons.arrow_back),
            onPressed: () {
              // Unfocus the text field before navigating back
              FocusScopeNode currentFocus = FocusScope.of(context);
              if (!currentFocus.hasPrimaryFocus) {
                currentFocus.unfocus();
              }

              // Add a 0.5 seconds delay before navigating back
              Future.delayed(const Duration(milliseconds: 100), () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => NavigatorPage(),
                  ),
                );
              });
            },
          ),
          title: BlocBuilder<SearchBlocBloc, SearchBlocState>(
            builder: (context, state) {
              return TextField(
                onChanged: (query) {
                  if (query.isEmpty) {
                    BlocProvider.of<SearchBlocBloc>(context)
                        .add(InitialSearch());
                  } else {
                    BlocProvider.of<SearchBlocBloc>(context).add(
                      SearchLogic(
                          searchQuery: query,
                          filteredSongNames: filteredSongNames,
                          filteredIds: filteredIds),
                    );
                  }
                },
                decoration: const InputDecoration(
                  hintText: 'Search...',
                  border: InputBorder.none,
                ),
              );
            },
          ),
        ),
        body: Container(
          decoration: const BoxDecoration(
            gradient: RadialGradient(
              colors: [
                Color.fromARGB(255, 61, 61, 58),
                Color.fromARGB(255, 254, 254, 253),
              ],
              center: Alignment.topLeft,
              radius: 1.2,
            ),
          ),
          child: Padding(
            padding: const EdgeInsets.all(15.0),
            child: BlocBuilder<SearchBlocBloc, SearchBlocState>(
              builder: (context, state) {
                if (state is SearchScreenstate) {
                  final filteredSongNames = state.filteredSongNames;
                  final filteredIds = state.filteredIds;
                  return ListView.separated(
                    itemCount: filteredSongNames.length,
                    separatorBuilder: (BuildContext context, int index) {
                      return const SizedBox(
                        height: 4,
                      );
                    },
                    itemBuilder: (BuildContext context, int index) {
                      final originalIndex =
                          songNames.indexOf(filteredSongNames[index]);
                      return ClipRRect(
                        borderRadius: BorderRadius.circular(25.0),
                        child: Card(
                          color: const Color.fromARGB(255, 252, 251, 251),
                          elevation: 3.0,
                          shadowColor: const Color.fromARGB(255, 252, 251, 251),
                          child: SizedBox(
                            height: 70.0,
                            width: double.infinity,
                            child: InkWell(
                              onTap: () async {
                                FocusScope.of(context).unfocus();
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => NowPlaying(
                                      index: originalIndex,
                                    ),
                                  ),
                                );
                              },
                              child: ListTile(
                                leading: QueryArtworkWidget(
                                  controller: _audioQuery,
                                  id: filteredIds[index],
                                  type: ArtworkType.AUDIO,
                                  nullArtworkWidget: const Icon(
                                    Icons.music_note,
                                    color: Colors.amber,
                                    size: 50,
                                  ),
                                ),
                                title: Text(
                                  filteredSongNames[index],
                                  overflow: TextOverflow.ellipsis,
                                ),
                                subtitle: Text(
                                  artistNames[index]!,
                                  overflow: TextOverflow.ellipsis,
                                ),
                                tileColor:
                                    const Color.fromARGB(255, 250, 250, 251),
                                trailing: PopupMenuButton<String>(
                                  icon: const Icon(
                                    Icons.align_vertical_bottom,
                                    size: 18,
                                    color: Color.fromARGB(255, 27, 164, 179),
                                  ),
                                  onSelected: (value) {
                                    if (value == 'favorite') {
                                      songPresent = 1;
                                      addtoFavoritedb(index);
                                    } else if (value == 'playlist') {
                                      playlistIndex = index;
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) =>
                                              const PlaylistPage(),
                                        ),
                                      );
                                    }
                                  },
                                  shape: const RoundedRectangleBorder(
                                    borderRadius: BorderRadius.only(
                                      topLeft: Radius.circular(60),
                                    ),
                                  ),
                                  color: Colors.white,
                                  itemBuilder: (BuildContext context) {
                                    return <PopupMenuEntry<String>>[
                                      const PopupMenuItem<String>(
                                        value: 'favorite',
                                        child: Padding(
                                          padding: EdgeInsets.all(10.0),
                                          child: Text(
                                            'Add to Favorite',
                                            textAlign: TextAlign.center,
                                            style: TextStyle(
                                              color: Colors.black,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                        ),
                                      ),
                                      const PopupMenuItem<String>(
                                        value: 'playlist',
                                        child: Padding(
                                          padding: EdgeInsets.all(10.0),
                                          child: Text(
                                            'Add to Playlist',
                                            textAlign: TextAlign.center,
                                            style: TextStyle(
                                              color: Colors.black,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ];
                                  },
                                ),
                              ),
                            ),
                          ),
                        ),
                      );
                    },
                  );
                } else {
                  // Show all songs initially
                  return ListView.separated(
                    itemCount: songNames.length,
                    separatorBuilder: (BuildContext context, int index) {
                      return const SizedBox(
                        height: 4,
                      );
                    },
                    itemBuilder: (BuildContext context, int index) {
                      final originalIndex = index;
                      return ClipRRect(
                        borderRadius: BorderRadius.circular(25.0),
                        child: Card(
                          color: const Color.fromARGB(255, 252, 251, 251),
                          elevation: 3.0,
                          shadowColor: const Color.fromARGB(255, 252, 251, 251),
                          child: SizedBox(
                            height: 70.0,
                            width: double.infinity,
                            child: InkWell(
                              onTap: () async {
                                FocusScope.of(context).unfocus();
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => NowPlaying(
                                      index: originalIndex,
                                    ),
                                  ),
                                );
                              },
                              child: ListTile(
                                leading: QueryArtworkWidget(
                                  controller: _audioQuery,
                                  id: ids[index],
                                  type: ArtworkType.AUDIO,
                                  nullArtworkWidget: const Icon(
                                    Icons.music_note,
                                    color: Colors.amber,
                                    size: 50,
                                  ),
                                ),
                                title: Text(
                                  songNames[index],
                                  overflow: TextOverflow.ellipsis,
                                ),
                                subtitle: Text(
                                  artistNames[index]!,
                                  overflow: TextOverflow.ellipsis,
                                ),
                                tileColor:
                                    const Color.fromARGB(255, 250, 250, 251),
                                trailing: PopupMenuButton<String>(
                                  icon: const Icon(
                                    Icons.align_vertical_bottom,
                                    size: 18,
                                    color: Color.fromARGB(255, 27, 164, 179),
                                  ),
                                  onSelected: (value) {
                                    if (value == 'favorite') {
                                      songPresent = 1;
                                      addtoFavoritedb(index);
                                    } else if (value == 'playlist') {
                                      playlistIndex = index;
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) =>
                                              const PlaylistPage(),
                                        ),
                                      );
                                    }
                                  },
                                  shape: const RoundedRectangleBorder(
                                    borderRadius: BorderRadius.only(
                                      topLeft: Radius.circular(60),
                                    ),
                                  ),
                                  color: Colors.white,
                                  itemBuilder: (BuildContext context) {
                                    return <PopupMenuEntry<String>>[
                                      const PopupMenuItem<String>(
                                        value: 'favorite',
                                        child: Padding(
                                          padding: EdgeInsets.all(10.0),
                                          child: Text(
                                            'Add to Favorite',
                                            textAlign: TextAlign.center,
                                            style: TextStyle(
                                              color: Colors.black,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                        ),
                                      ),
                                      const PopupMenuItem<String>(
                                        value: 'playlist',
                                        child: Padding(
                                          padding: EdgeInsets.all(10.0),
                                          child: Text(
                                            'Add to Playlist',
                                            textAlign: TextAlign.center,
                                            style: TextStyle(
                                              color: Colors.black,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ];
                                  },
                                ),
                              ),
                            ),
                          ),
                        ),
                      );
                    },
                  );
                }
              },
            ),
          ),
        ),
      ),
    );
  }
}
