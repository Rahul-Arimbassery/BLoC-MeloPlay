import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hive/hive.dart';
import 'package:musicuitest/globalpage.dart';
import 'package:musicuitest/homepage.dart';
import 'package:musicuitest/screens/navigatorpage.dart';
import 'package:musicuitest/widgets/addtoplaylist.dart';
import 'package:on_audio_query/on_audio_query.dart';

import '../models/playlistnamearray.dart';
import '../screens/nowplaying.dart';
import '../screens/playlistpage.dart';

final OnAudioQuery _audioQuery = OnAudioQuery();
List<int> currentIndexarray = [];

late String globalplaylistName;

class PlaylistDetailPage extends StatefulWidget {
  final String playlistName;

  const PlaylistDetailPage({super.key, required this.playlistName});

  @override
  State<PlaylistDetailPage> createState() => _PlaylistDetailPageState();
}

class _PlaylistDetailPageState extends State<PlaylistDetailPage> {
  //List<int> currentIndexarray = [];
  int count = 0;

  @override
  void initState() {
    super.initState();
    initializePlaylist();
  }

  initializePlaylist() async {
    setState(() async {
      await readplaylistDB();
    }); // Trigger a rebuild after initializing the playlist
  }

  readplaylistDB() async {
    globalplaylistName = widget.playlistName;
    var box = await Hive.openBox<Playlistarray>('playlistsarray');
    var playlistArray = box.get(widget.playlistName);
    if (playlistArray != null) {
      var allIndexes = playlistArray.playlistIndexarray;
      var filteredIndexes = <int>[];

      for (var index in allIndexes) {
        if (playlistArray.playlistName == widget.playlistName) {
          filteredIndexes.add(index);
        }
      }

      setState(() {
        currentIndexarray = filteredIndexes;
      });
    }
  }

  updatePlaylistDB() async {
    var box = await Hive.openBox<Playlistarray>('playlistsarray');
    var playlistArray = Playlistarray(
      playlistName: widget.playlistName,
      playlistIndexarray: currentIndexarray,
    );
    await box.put(playlistArray.playlistName, playlistArray);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          widget.playlistName,
          style: GoogleFonts.acme(
            textStyle: const TextStyle(fontSize: 22),
          ),
        ),
        //Text(widget.playlistName),
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back,
            color: Colors.amber,
          ),
          onPressed: () async {
            await updatePlaylistDB();
            Navigator.of(context).pop(); // Navigate back to the previous screen
          },
        ),
        actions: [
          IconButton(
              onPressed: () {
                //await updatePlaylistDB();
                //_openBottomSheet(context);
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const AddtoPlaylist(),
                  ),
                ).then((value) {
                  // This code will run when you navigate back from AddtoPlaylist page
                  setState(() {
                    readplaylistDB(); // Perform any necessary actions or updates on the returned page
                  });
                });
              },
              icon: const Icon(
                Icons.playlist_add,
                color: Colors.amber,
              ))
        ],
      ),
      //body: const ListViewPage(),
      body: Container(
        decoration: const BoxDecoration(
            gradient: RadialGradient(
          colors: [
            Color.fromARGB(255, 61, 61, 58),
            Color.fromARGB(255, 254, 254, 253),
          ],
          center: Alignment.topLeft,
          radius: 1.2,
        )),
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          //child: indexesPlaylist.isEmpty
          child: currentIndexarray.isEmpty
              ? const Center(
                  child: Text(
                    'No items in playlist.',
                    style: TextStyle(fontSize: 16.0),
                  ),
                )
              : ListView.separated(
                  //itemCount: indexesPlaylist.length,
                  itemCount: currentIndexarray.length,

                  separatorBuilder: (BuildContext context, int index) {
                    return const SizedBox(
                      height:
                          4, // set the desired height of the space between each ListTile
                    );
                  },
                  itemBuilder: (context, index) {
                    //int currentindex = indexesPlaylist[index];
                    int currentindex =
                        currentIndexarray[index]; //updating index here
                    return ClipRRect(
                      borderRadius: BorderRadius.circular(
                          25.0), // set the desired border radius value
                      child: Card(
                        color: const Color.fromARGB(255, 190, 188, 188),
                        elevation: 3.0,
                        shadowColor: const Color.fromARGB(255, 188, 184, 184),
                        child: SizedBox(
                          height: 70.0, // set the desired height of the Card
                          width: double
                              .infinity, // set the width to match the parent ListView
                          child: InkWell(
                            onTap: () {
                              //_audioPlayer.stop();
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => NowPlaying(
                                    index: currentindex,
                                  ),
                                ),
                              );
                            },
                            child: ListTile(
                              leading: QueryArtworkWidget(
                                controller: _audioQuery,
                                id: ids[currentindex],
                                type: ArtworkType.AUDIO,
                                nullArtworkWidget: const Icon(
                                  Icons.music_note,
                                  color: Colors.amber,
                                  size: 50,
                                ),
                              ),
                              title: Text(
                                songNames[currentindex],
                                overflow: TextOverflow.ellipsis,
                              ),
                              subtitle: Text(
                                artistNames[currentindex]!,
                                overflow: TextOverflow.ellipsis,
                              ),
                              tileColor:
                                  const Color.fromARGB(255, 250, 250, 251),
                              trailing: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  IconButton(
                                    onPressed: () {
                                      setState(() {
                                        indexesPlaylist.remove(currentindex);
                                        currentIndexarray.remove(currentindex);
                                        press[currentindex] = false;
                                        //updatePlaylistDB();
                                      });
                                      Fluttertoast.showToast(
                                        msg: 'Song Removed from Playlist',
                                        backgroundColor: const Color.fromARGB(
                                            255, 27, 164, 179),
                                      );
                                    },
                                    icon: const Icon(
                                      Icons.delete_outline_rounded,
                                      color: Color.fromARGB(255, 27, 164, 179),
                                    ),
                                  ),
                                ],
                              ), // set the background color based on the view mode
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
