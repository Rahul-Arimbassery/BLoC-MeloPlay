import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hive/hive.dart';
import 'package:musicuitest/utils/globalpage.dart';
import 'package:musicuitest/presentation/screens/nowplaying/nowplaying.dart';
import 'package:musicuitest/presentation/screens/playlist/playlistpage.dart';
import 'package:musicuitest/presentation/screens/playlist/addtoplaylist.dart';
import 'package:musicuitest/controller/searchpage.dart';
import 'package:on_audio_query/on_audio_query.dart';
import '../../../models/allsongs.dart';
import 'package:shared_preferences/shared_preferences.dart';

int playlistIndex = 0;
final OnAudioQuery _audioQuery = OnAudioQuery();
SharedPreferences? _prefs;
List<int> recentList = [];
late List<bool> _isPressedList;

class HomePage extends StatefulWidget {
  const HomePage({
    Key? key,
  }) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  bool _hasPermission = false;
  bool _isGrid = false; // new variable to keep track of the view mode
  Future<List<SongModel>>? _futureResult;

  @override
  void initState() {
    super.initState();
    initializePreferences();
    LogConfig logConfig = LogConfig(logType: LogType.DEBUG);
    _audioQuery.setLogConfig(logConfig);
    checkAndRequestPermissions();
    _futureResult = fetchMP3Songs();
  }

  Future<void> initializePreferences() async {
    _prefs = await SharedPreferences.getInstance();
    // Load the saved button states from shared preferences
    loadButtonStates();
  }

  void loadButtonStates() {
    int itemCount = 100;
    setState(() {
      _isPressedList = List.generate(
        itemCount,
        (index) => _prefs!.getBool('buttonState$index') ?? false,
      );
    });
  }

  checkAndRequestPermissions({bool retry = false}) async {
    _hasPermission = await _audioQuery.checkAndRequest(
      retryRequest: retry,
    );
    _hasPermission ? setState(() {}) : null;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        shadowColor: const Color.fromARGB(255, 27, 164, 179),
        elevation: 10,
        backgroundColor: Colors.black,
        automaticallyImplyLeading: false,
        title: Row(
          children: [
            Text(
              'All Songs',
              style: GoogleFonts.acme(
                textStyle: const TextStyle(fontSize: 22),
              ),
            ),
            const SizedBox(
              width: 130,
            ),
            IconButton(
              icon: const Icon(Icons.search),
              color: Colors.white,
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => SearchPage(
                      songNames: songNames,
                      ids: ids,
                    ),
                  ),
                );
                // Implement your search functionality here
              },
            ),
            IconButton(
              color: Colors.white,
              icon: _isGrid
                  ? const Icon(Icons.view_list)
                  : const Icon(Icons
                      .grid_view), // toggle the icon based on the view mode
              onPressed: () {
                setState(() {
                  _isGrid = !_isGrid; // toggle the view mode
                });
              },
            ),
          ],
        ),
      ),
      backgroundColor: const Color.fromARGB(255, 251, 251, 252),
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
        child: SafeArea(
          child: Center(
            child: !_hasPermission
                ? noAccessToLibraryWidget()
                : FutureBuilder<List<SongModel>>(
                    future: _futureResult,
                    builder: (context, item) {
                      if (item.hasError) {
                        return Text(item.error.toString());
                      }

                      if (item.connectionState == ConnectionState.waiting) {
                        return const CircularProgressIndicator();
                      }

                      if (item.data == null || item.data!.isEmpty) {
                        return const Text("No MP3 songs found!");
                      }

                      return _isGrid
                          ? _buildGridView(item)
                          : _buildListView(item);
                    },
                  ),
          ),
        ),
      ),
    );
  }

  Future<List<SongModel>> fetchMP3Songs() async {
    List<SongModel> allSongs = await _audioQuery.querySongs(
      sortType: null,
      orderType: OrderType.ASC_OR_SMALLER,
      uriType: UriType.EXTERNAL,
      ignoreCase: true,
    );

    //Filter the songs to keep only MP3 files.
    List<SongModel> mp3Songs = allSongs.where((song) {
      String? filePath = song.data;
      return filePath.toLowerCase().endsWith('.mp3');
    }).toList();

    allfilePaths = mp3Songs.map((song) => song.data).toList();
    songNames = mp3Songs.map((song) => song.title).toList();
    artistNames = mp3Songs.map((song) => song.artist).toList();
    ids = mp3Songs.map((song) => song.id).toList();

    return mp3Songs;
  }

  Widget noAccessToLibraryWidget() {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: const Color.fromARGB(255, 253, 251, 251).withOpacity(0.5),
      ),
      padding: const EdgeInsets.all(20),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Text("Application doesn't have access to the library"),
          const SizedBox(height: 10),
          ElevatedButton(
            onPressed: () => checkAndRequestPermissions(retry: true),
            child: const Text("Allow"),
          ),
        ],
      ),
    );
  }

  Widget _buildListView(item) {
    return Column(
      children: [
        Expanded(
          child: Padding(
            padding: const EdgeInsets.all(15.0),
            child: Stack(
              children: [
                ListView.separated(
                  itemCount: item
                      .data!.length, // set the number of ListTiles to create
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
                            onTap: () async {
                              //recentList.add(index);
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => NowPlaying(
                                    index: index,
                                  ),
                                ),
                              );
                              //await addtoRecent(index);
                            },
                            child: ListTile(
                              leading: QueryArtworkWidget(
                                controller: _audioQuery,
                                id: item.data![index].id,
                                type: ArtworkType.AUDIO,
                                nullArtworkWidget: const Icon(
                                  Icons.music_note,
                                  color: Colors.amber,
                                  size: 50,
                                ),
                              ),
                              title: Text(
                                item.data![index].title,
                                overflow: TextOverflow.ellipsis,
                              ),
                              subtitle: Text(
                                item.data![index].artist ?? "No Artist",
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
                                        _isPressedList[index] =
                                            !_isPressedList[index];
                                        press[index] = true;
                                      });
                                      if (_isPressedList[index]) {
                                        addtoFavoritedb(index);
                                      } else {
                                        deleteSongFromFavorite(index);
                                        Fluttertoast.showToast(
                                          msg: 'Song Removed from Favorites',
                                          backgroundColor: const Color.fromARGB(
                                              255, 27, 164, 179),
                                          toastLength: Toast.LENGTH_SHORT,
                                          gravity: ToastGravity.BOTTOM,
                                        );
                                      }
                                      // Save the button state to shared preferences
                                      _prefs?.setBool('buttonState$index',
                                          _isPressedList[index]);
                                    },
                                    icon: Container(
                                      color: _isPressedList[index]
                                          ? Colors.white
                                          : Colors.transparent,
                                      child: Icon(
                                        Icons.favorite,
                                        color: _isPressedList[index]
                                            ? const Color.fromARGB(
                                                255, 27, 164, 179)
                                            : const Color.fromARGB(
                                                255, 139, 135, 135),
                                      ),
                                    ),
                                  ),
                                  IconButton(
                                    onPressed: () {
                                      playlistIndex = index; //for playlist add
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) =>
                                              const PlaylistPage(),
                                        ),
                                      );
                                      Fluttertoast.showToast(
                                        msg: 'Select playlist to add song',
                                        backgroundColor: const Color.fromARGB(
                                            255, 27, 164, 179),
                                      );
                                    },
                                    icon: const Icon(Icons.playlist_add),
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

  Widget _buildGridView(item) {
    return Column(
      children: [
        Expanded(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: GridView.count(
              crossAxisCount: 2,
              crossAxisSpacing: 13,
              mainAxisSpacing: 22,
              childAspectRatio: 0.80,
              children: List.generate(item.data!.length, (index) {
                return Material(
                  color: const Color.fromARGB(255, 252, 252, 252),
                  elevation: 20, // add an elevation of 20
                  shadowColor: const Color.fromARGB(255, 123, 122, 119),
                  borderRadius: BorderRadius.circular(15.0),
                  child: InkWell(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => NowPlaying(index: index),
                        ),
                      );
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: const Color.fromARGB(255, 145, 145, 146),
                          style: BorderStyle.solid,
                          width: 1,
                        ),
                        borderRadius: BorderRadius.circular(15.0),
                      ),
                      child: Column(
                        children: [
                          Expanded(
                            child: Center(
                              child: QueryArtworkWidget(
                                controller: _audioQuery,
                                id: item.data![index].id,
                                type: ArtworkType.AUDIO,
                                nullArtworkWidget: const Icon(
                                  Icons.music_note,
                                  color: Colors.amber,
                                  size: 50,
                                ),
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(5.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Center(
                                  child: Text(
                                    item.data![index].title,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ),
                                const SizedBox(height: 8),
                                Center(
                                  child: Text(
                                    item.data![index].artist ?? "No Artist",
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ),
                                const SizedBox(height: 8),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    IconButton(
                                      onPressed: () {
                                        setState(() {
                                          _isPressedList[index] =
                                              !_isPressedList[index];
                                        });
                                        if (_isPressedList[index]) {
                                          //addtoFavoritedb(index);
                                          addtoFavoritedb(index);
                                        } else {
                                          deleteSongFromFavorite(index);
                                        }
                                        // Save the button state to shared preferences
                                        _prefs?.setBool('buttonState$index',
                                            _isPressedList[index]);
                                      },
                                      icon: Container(
                                        color: _isPressedList[index]
                                            ? Colors.white
                                            : Colors.transparent,
                                        child: Icon(
                                          Icons.favorite,
                                          color: _isPressedList[index]
                                              ? const Color.fromARGB(
                                                  255, 27, 164, 179)
                                              : Colors.grey,
                                        ),
                                      ),
                                    ),
                                    IconButton(
                                      onPressed: () {
                                        playlistIndex =
                                            index; //for playlist add
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) =>
                                                const PlaylistPage(),
                                          ),
                                        );
                                        Fluttertoast.showToast(
                                          msg: 'Select playlist to add song',
                                          backgroundColor: const Color.fromARGB(
                                              255, 27, 164, 179),
                                        );
                                      },
                                      icon: const Icon(Icons.playlist_add),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              }),
            ),
          ),
        ),
      ],
    );
  }
}

favFunction(int index) {
  _isPressedList[index] = !_isPressedList[index];
  _prefs?.setBool('buttonState$index', _isPressedList[index]);
}

void removeFromFavoritedb(int index) async {
  var favorite = await Hive.openBox<AllSongs>('allSongs');
  favorite.deleteAt(index);
}

Future<void> deleteSongFromFavorite(int songID) async {
  var favorite = await Hive.openBox<AllSongs>('allSongs');
  for (int i = 0; i < favorite.length; i++) {
    var song = favorite.getAt(i);
    if (song != null && song.songID == songID) {
      await favorite.deleteAt(i);
      _isPressedList[songID] = false;
      _prefs?.setBool('buttonState$songID', _isPressedList[songID]);
      break;
    }
  }
}

addtoFavoritedb(int index) async {
  var favorite = await Hive.openBox<AllSongs>('allSongs');
  if (favorite.values.any((song) => song.songID == index)) {
    Fluttertoast.showToast(
      msg: 'Song is already present in the favorite List',
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.BOTTOM,
      backgroundColor: const Color.fromARGB(255, 199, 52, 29),
      textColor: Colors.white,
    );
  } else {
    favorite.add(AllSongs(songID: index));
    Fluttertoast.showToast(
      msg: 'Song added to the favorite Sucessfully!!',
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.BOTTOM,
      backgroundColor: const Color.fromARGB(255, 27, 164, 179),
      textColor: Colors.white,
    );
    if (songPresent == 1) {
      favFunction(index);
      songPresent = 0;
    }
  }
}
