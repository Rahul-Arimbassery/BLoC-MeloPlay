import 'package:flutter/material.dart';
import 'package:musicuitest/homepage.dart';
import 'package:musicuitest/screens/navigatorpage.dart';
import 'package:musicuitest/screens/playlistpage.dart';
import 'package:on_audio_query/on_audio_query.dart';

import '../globalpage.dart';
import '../screens/nowplaying.dart';

final OnAudioQuery _audioQuery = OnAudioQuery();

class SearchPage extends StatefulWidget {
  final List<String> songNames;
  final List<int> ids; // Add the list of IDs

  const SearchPage({Key? key, required this.songNames, required this.ids})
      : super(key: key);

  @override
  _SearchPageState createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  List<String> filteredSongNames = [];
  List<int> filteredIds = []; // Store filtered IDs

  @override
  void initState() {
    super.initState();
    filteredSongNames = widget.songNames;
    filteredIds = widget.ids; // Initialize filtered IDs with all IDs
  }

  @override
  void dispose() {
    FocusScope.of(context).unfocus();
    super.dispose();
  }

  // Implement search logic and update the filteredSongNames and filteredIds lists
  void search(String query) {
    setState(() {
      filteredSongNames = widget.songNames
          .where((songName) =>
              songName.toLowerCase().contains(query.toLowerCase()))
          .toList();
      filteredIds = widget.ids
          .where((id) => filteredSongNames
              .contains(widget.songNames[widget.ids.indexOf(id)]))
          .toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const NavigatorPage(),
              ),
            );
          },
        ),
        title: TextField(
          onChanged: search,
          decoration: const InputDecoration(
            hintText: 'Search...',
            border: InputBorder.none,
          ),
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
          child: ListView.separated(
            itemCount: filteredSongNames.length,
            separatorBuilder: (BuildContext context, int index) {
              return const SizedBox(
                height:
                    4, // set the desired height of the space between each ListTile
              );
            },
            itemBuilder: (BuildContext context, int index) {
              final originalIndex =
                  widget.songNames.indexOf(filteredSongNames[index]);
              return ClipRRect(
                borderRadius: BorderRadius.circular(
                    25.0), // set the desired border radius value
                child: Card(
                  color: const Color.fromARGB(255, 252, 251, 251),
                  elevation: 3.0,
                  shadowColor: const Color.fromARGB(255, 252, 251, 251),
                  child: SizedBox(
                    height: 70.0, // set the desired height of the Card
                    width: double
                        .infinity, // set the width to match the parent ListView
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
                      child: Expanded(
                        child: ListTile(
                          leading: QueryArtworkWidget(
                            controller: _audioQuery,
                            id: filteredIds[
                                index], // Parse the ID as an integer
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
                          tileColor: const Color.fromARGB(255, 250, 250,
                              251), // set the background color based on the view mode
                          trailing: PopupMenuButton<String>(
                            icon: const Icon(
                              Icons.align_vertical_bottom,
                              size: 18,
                              color: Color.fromARGB(255, 27, 164, 179),
                            ),
                            onSelected: (value) {
                              if (value == 'favorite') {
                                songPresent = 1;
                                // Add your first button functionality here
                                addtoFavoritedb(index);
                                //favFunction(widget.index);
                              } else if (value == 'playlist') {
                                // Add your second button functionality here
                                playlistIndex = index; //for playlist add
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => const PlaylistPage(),
                                  ),
                                );
                              }
                            },
                            shape: const RoundedRectangleBorder(
                              borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(60),
                              ),
                            ),
                            //color: const Color.fromARGB(255, 27, 164, 179),
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
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
