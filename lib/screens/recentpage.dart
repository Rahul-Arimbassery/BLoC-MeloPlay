import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:on_audio_query/on_audio_query.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../globalpage.dart';
import 'nowplaying.dart';

final OnAudioQuery _audioQuery = OnAudioQuery();
List<int> recentSongsList = [];
late SharedPreferences prefsrecent;

class RecentPage extends StatefulWidget {
  const RecentPage({super.key});

  @override
  State<RecentPage> createState() => _RecentPageState();
}

class _RecentPageState extends State<RecentPage> {
  @override
  void initState() {
    //initialize();
    super.initState();
    initialize();
  }

  initialize() async {
    await loadRecentArray(); 
  }

  Future<void> loadRecentArray() async {
    prefsrecent = await SharedPreferences.getInstance();
    setState(() {
      recentArray =
          prefsrecent.getStringList('recentArray')?.map(int.parse).toList() ??
              [];
    });
  }

  void _clearRecentSongs() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Clear Recent Songs'),
          content:
              const Text('Are you sure you want to clear the recent songs?'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                setState(() {
                  recentArray.clear();
                });
                saveRecentArray();
                Navigator.pop(context);
              },
              child: const Text('Clear'),
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
        actions: [
          IconButton(
            onPressed: () {
              _clearRecentSongs();
            },
            icon: const Icon(Icons.clear_all_rounded),
          )
        ],
        shadowColor: const Color.fromARGB(255, 27, 164, 179),
        elevation: 10,
        backgroundColor: Colors.black,
        automaticallyImplyLeading: false,
        title: Text(
          'Recent Songs',
          style: GoogleFonts.acme(
            textStyle: const TextStyle(fontSize: 22),
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
        child: _buildListView(),
      ),
    );
  }

  Widget _buildListView() {
    if (recentArray.isEmpty) {
      return Center(
        child: Text(
          'No Recent Items',
          style: GoogleFonts.acme(
            textStyle: const TextStyle(fontSize: 20),
          ),
        ),
      );
    }
    return Column(
      children: [
        Expanded(
          child: Padding(
            padding: const EdgeInsets.all(15.0),
            child: Stack(
              children: [
                ListView.separated(
                  itemCount: recentArray
                      .length, // set the number of ListTiles to create
                  separatorBuilder: (BuildContext context, int index) {
                    return const SizedBox(
                      height:
                          4, // set the desired height of the space between each ListTile
                    );
                  },
                  itemBuilder: (BuildContext context, int index) {
                    int currentindex = recentArray[index];
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
                                artistNames[currentindex] ?? "No Artist",
                                overflow: TextOverflow.ellipsis,
                              ),
                              tileColor:
                                  const Color.fromARGB(255, 250, 250, 251),
                              trailing: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  IconButton(
                                    onPressed: () async {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) => NowPlaying(
                                            index: currentindex,
                                          ),
                                        ),
                                      );
                                    },
                                    icon: const Icon(
                                      Icons.play_arrow,
                                      size: 30,
                                      color: Color.fromARGB(255, 27, 164, 179),
                                    ),
                                  )
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
}

Future<void> saveRecentArray() async {
  prefsrecent = await SharedPreferences.getInstance();
  await prefsrecent.setStringList(
      'recentArray', recentArray.map((e) => e.toString()).toList());
}
