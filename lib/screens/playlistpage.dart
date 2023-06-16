import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hive/hive.dart';
import 'package:musicuitest/homepage.dart';
import 'package:musicuitest/screens/navigatorpage.dart';
import 'package:musicuitest/widgets/playlistitems.dart';

import '../models/playlist.dart';
import '../models/playlistnamearray.dart';
import '../widgets/addtoplaylist.dart';

List<int> indexesPlaylist = [];

class PlaylistPage extends StatefulWidget {
  const PlaylistPage({super.key});

  @override
  State<PlaylistPage> createState() => _PlaylistPageState();
}

class _PlaylistPageState extends State<PlaylistPage> {
  String playlistName = '';
  List<String> playlistNames = [];
  bool deletePressed = false;

  @override
  void initState() {
    super.initState();
    getPlaylists();
  }

  void getPlaylists() async {
    final playlistBox = Hive.box<Playlist>('playlists');
    setState(() {
      playlistNames =
          playlistBox.values.map((playlist) => playlist.playlistName).toList();
    });
  }

  void showAddPlaylistDialog() async {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Add Playlist'),
          content: Container(
            decoration: BoxDecoration(
              border: Border.all(color: Colors.black, width: 1.5),
              borderRadius: BorderRadius.circular(20),
            ),
            child: TextField(
              onChanged: (value) {
                setState(() {
                  playlistName = value;
                });
              },
              decoration: const InputDecoration(
                hintText: 'Enter playlist name',
                contentPadding:
                    EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                border: InputBorder.none,
              ),
            ),
          ),
          actions: [
            ElevatedButton(
              onPressed: () async {
                setState(() {
                  playlistNames.add(playlistName);
                });

                Navigator.pop(context); // Close the dialog

                final playlistBox = Hive.box<Playlist>('playlists');
                final playlist = Playlist(
                  playlistName: playlistName,
                  playlistIndex: playlistBox.length,
                );

                setState(() async {
                  await playlistBox.add(playlist);
                });
              },
              child: const Text('Create'),
            ),
            TextButton(
              onPressed: () {
                Navigator.pop(context); // Close the dialog
              },
              child: const Text('Close'),
            ),
          ],
        );
      },
    );
  }

  void deletePlaylist(int index) async {
    final playlistBox = Hive.box<Playlist>('playlists');
    await playlistBox.deleteAt(index);
    setState(() {
      playlistNames.removeAt(index);
    });
  }

  Future<void> openPlaylist(int index) async {
    if (!deletePressed) {
      if (pagestatus != true) {
        if (!indexesPlaylist.contains(playlistIndex)) {
          setState(() {
            indexesPlaylist.add(playlistIndex);
            playlistNames.add(playlistNames[index]);
            press[index] = false;
          });

          Fluttertoast.showToast(
            msg: 'Song Added to Playlist Successfully!!!',
            backgroundColor: const Color.fromARGB(255, 27, 164, 179),
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.CENTER,
          );

          var box = await Hive.openBox<Playlistarray>('playlistsarray');
          var playlistArray = Playlistarray(
            playlistName: playlistNames[index],
            playlistIndexarray: indexesPlaylist,
          );

          await box.put(playlistArray.playlistName, playlistArray);

          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const NavigatorPage(),
            ),
          );
        } else {
          Fluttertoast.showToast(
            msg: 'Song is already in the playlist!',
            backgroundColor: const Color.fromARGB(255, 138, 11, 11),
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.CENTER,
          );
        }
      }

      // Perform the navigation logic to open the playlist
      if (pagestatus == true) {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => PlaylistDetailPage(
              playlistName: playlistNames[index],
            ),
          ),
        );
      }
    } else {
      deletePlaylist(index);
      deletePressed = false; // Reset the flag after deletion
    }
  }

  void _showEditPlaylistDialog(int index) async {
    final playlistBox = Hive.box<Playlist>('playlists');
    String updatedName = playlistNames[index];
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Edit Playlist Name'),
          content: Container(
            decoration: BoxDecoration(
              border: Border.all(color: Colors.black, width: 1.5),
              borderRadius: BorderRadius.circular(20),
            ),
            child: TextField(
              onChanged: (value) {
                updatedName = value; // Update the value of the local variable
              },
              controller: TextEditingController(text: playlistNames[index]),
              decoration: const InputDecoration(
                hintText: 'Enter playlist name',
                contentPadding:
                    EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                border: InputBorder.none,
              ),
            ),
          ),
          actions: [
            ElevatedButton(
              onPressed: () async {
                setState(() {
                  playlistNames[index] = updatedName; // Update the UI
                });
                Navigator.pop(context); // Close the dialog
                final playlist = Playlist(
                  playlistName: updatedName,
                  playlistIndex: index,
                );
                await playlistBox.putAt(index, playlist);
              },
              child: const Text('Save'),
            ),
            TextButton(
              onPressed: () {
                Navigator.pop(
                    context); // Close the dialog // Update the database
              },
              child: const Text('Cancel'),
            ),
          ],
        );
      },
    );
  }

  void _deletePlaylist(int index) {
    final playlistBox = Hive.box<Playlist>('playlists');
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Delete Playlist'),
          content: const Text('Are you sure you want to delete this playlist?'),
          actions: [
            ElevatedButton(
              onPressed: () async {
                setState(() {
                  playlistNames.removeAt(index);
                });
                Navigator.pop(context); // Close the dialog
                await playlistBox.deleteAt(index);
              },
              child: const Text('Delete'),
            ),
            TextButton(
              onPressed: () {
                Navigator.pop(context); // Close the dialog
              },
              child: const Text('Cancel'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        //automaticallyImplyLeading: true,
        shadowColor: const Color.fromARGB(255, 27, 164, 179),
        elevation: 10,
        backgroundColor: Colors.black,
        title: Expanded(
          child: Row(
            children: [
              //const Text('PLAYLIST'),
              Text(
                'Playlist     ',
                style: GoogleFonts.acme(
                  textStyle: const TextStyle(fontSize: 22),
                ),
              ),
              const SizedBox(width: 90),
              const Text(
                'CREATE',
                style: TextStyle(
                  color: Color.fromARGB(255, 27, 164, 179),
                  fontSize: 11.5,
                ),
              ),
              IconButton(
                icon: const Icon(Icons.add_box, size: 35),
                color: Colors.white,
                onPressed: () {
                  showAddPlaylistDialog(); // Show the add playlist dialog
                },
              ),
            ],
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Container(
          alignment: Alignment.center,
          child: Column(
            children: [
              if (playlistNames.isEmpty)
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      '',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Color.fromARGB(255, 27, 164, 179),
                      ),
                    ),
                    const SizedBox(height: 22),
                    Text(
                      'Playlist is Empty.Create One.',
                      style: GoogleFonts.acme(
                        textStyle: const TextStyle(fontSize: 20),
                      ),
                    ),
                  ],
                ),
              if (playlistNames.isNotEmpty)
                Column(
                  children: List<Widget>.generate(
                    (playlistNames.length / 2).ceil(),
                    (index) {
                      final startIndex = index * 2;
                      final endIndex = startIndex + 1;
                      if (endIndex < playlistNames.length) {
                        return Row(
                          children: [
                            Expanded(
                              child: Padding(
                                padding: const EdgeInsets.all(20.0),
                                child: Center(
                                    child: _buildPlaylistContainer(startIndex)),
                              ),
                            ),
                            Expanded(
                              child: Padding(
                                padding: const EdgeInsets.all(20.0),
                                child: Center(
                                    child: _buildPlaylistContainer(endIndex)),
                              ),
                            ),
                          ],
                        );
                      } else {
                        return Padding(
                          padding: const EdgeInsets.all(20.0),
                          child: Center(
                              child: _buildPlaylistContainer(startIndex)),
                        );
                      }
                    },
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildPlaylistContainer(int index) {
    bool deletePressed = false; // Flag to track delete button press
    String editedName = playlistNames[index]; // Edited playlist name

    return GestureDetector(
      onTap: () {
        if (!deletePressed) {
          openPlaylist(index);
        }
      },
      child: Container(
        height: 150,
        width: 250,
        margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
        decoration: BoxDecoration(
          color: Colors.blueGrey,
          borderRadius: BorderRadius.circular(8),
        ),
        child: Stack(
          alignment: Alignment.center,
          children: [
            Image.asset(
              'asset/images/music-band.png',
              height: 100,
              width: 100,
            ),
            Positioned(
              top: 0,
              left: 0,
              right: 0,
              child: Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: Colors.black.withOpacity(0.5),
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(8),
                    topRight: Radius.circular(8),
                  ),
                ),
                child: Text(
                  playlistNames[index],
                  style: const TextStyle(color: Colors.white, fontSize: 16),
                  textAlign: TextAlign.center,
                ),
              ),
            ),
            Positioned(
              bottom: 0,
              left: 0,
              right: 0,
              child: Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: Colors.black.withOpacity(0.5),
                  borderRadius: const BorderRadius.only(
                    bottomLeft: Radius.circular(8),
                    bottomRight: Radius.circular(8),
                  ),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    IconButton(
                      icon: const Icon(Icons.delete),
                      color: Colors.white,
                      onPressed: () {
                        _deletePlaylist(index);
                      },
                    ),
                    IconButton(
                      icon: const Icon(Icons.edit),
                      color: Colors.white,
                      onPressed: () {
                        _showEditPlaylistDialog(index);
                      },
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
