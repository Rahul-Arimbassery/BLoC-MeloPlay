import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:hive/hive.dart';
import 'package:musicuitest/globalpage.dart';
import 'package:musicuitest/widgets/playlistitems.dart';
import 'package:on_audio_query/on_audio_query.dart';

import '../models/playlistnamearray.dart';

final OnAudioQuery _audioQuery = OnAudioQuery();
List<int> globalcurrentIndexarray = [];
List<bool> press = List.generate(100, (index) => false);
List<int> indexesPlaylist1 = [];

class AddtoPlaylist extends StatefulWidget {
  const AddtoPlaylist({super.key});

  @override
  State<AddtoPlaylist> createState() => _AddtoPlaylistState();
}

class _AddtoPlaylistState extends State<AddtoPlaylist> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add Songs'),
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back,
            color: Colors.amber,
          ),
          onPressed: () async {
            setState(() {
              Navigator.of(context)
                  .pop(); // Navigate back to the previous screen
            });
          },
        ),
      ),
      body: Container(
        child: _buildListView(),
      ),
    );
  }

  Widget _buildListView() {
    return Column(
      children: [
        Expanded(
          child: Padding(
            padding: const EdgeInsets.all(15.0),
            child: Stack(
              children: [
                ListView.separated(
                  itemCount: allfilePaths
                      .length, // set the number of ListTiles to create
                  separatorBuilder: (BuildContext context, int index) {
                    return const SizedBox(
                      height:
                          4, // set the desired height of the space between each ListTile
                    );
                  },
                  itemBuilder: (BuildContext context, int index) {
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
                            onTap: () {},
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
                                artistNames[index] ?? "No Artist",
                                overflow: TextOverflow.ellipsis,
                              ),
                              tileColor:
                                  const Color.fromARGB(255, 250, 250, 251),
                              trailing: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  IconButton(
                                    onPressed: () async {
                                      setState(() {
                                        press[index] = !press[index];
                                      });
                                      //if (!press[index]) {
                                      if (press[index]) {
                                        await addSongs(index);
                                      } else {
                                        await removeSongs(index);
                                        Fluttertoast.showToast(
                                          msg: 'Song Removed from Playlist',
                                          backgroundColor: const Color.fromARGB(
                                              255, 27, 164, 179),
                                        );
                                      }
                                    },
                                    icon: !press[index]
                                        ? const Icon(Icons.add_box)
                                        : const Icon(Icons.remove_circle),
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
              ],
            ),
          ),
        ),
      ],
    );
  }

  Future<void> addSongs(int index) async {
    var box1 = await Hive.openBox<Playlistarray>('playlistsarray');
    var playlistArray1 = box1.get(globalplaylistName);
    indexesPlaylist1 = playlistArray1!.playlistIndexarray;

    if (!indexesPlaylist1.contains(index)) {
      setState(() {
        indexesPlaylist1.add(index);
        currentIndexarray.add(index);
      });

      var box = await Hive.openBox<Playlistarray>('playlistsarray');
      var playlistArray = Playlistarray(
        playlistName: globalplaylistName,
        playlistIndexarray: indexesPlaylist1,
      );
      await box.put(playlistArray.playlistName, playlistArray);

      Fluttertoast.showToast(
        msg: 'Song added to playlist',
        backgroundColor: const Color.fromARGB(255, 27, 164, 179),
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.CENTER,
      );
    } else {
      Fluttertoast.showToast(
        msg: 'Song already in playlist',
        backgroundColor: const Color.fromARGB(255, 138, 11, 11),
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.CENTER,
      );
    }
  }

  removeSongs(int index) async {
    setState(() {
      indexesPlaylist1.remove(index);
      currentIndexarray.remove(index);
    });

    var box = await Hive.openBox<Playlistarray>('playlistsarray');
    var playlistArray = Playlistarray(
      playlistName: globalplaylistName,
      playlistIndexarray: indexesPlaylist1,
    );
    await box.put(playlistArray.playlistName, playlistArray);
  }
}
