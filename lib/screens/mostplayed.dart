import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:on_audio_query/on_audio_query.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../globalpage.dart';
import 'nowplaying.dart';

late SharedPreferences _prefsMostPlayed;
List<int> songIds = [];
Map<int, int> playCountMap = {};

class MostPlayedPage extends StatefulWidget {
  const MostPlayedPage({Key? key}) : super(key: key);

  @override
  State<MostPlayedPage> createState() => _MostPlayedPageState();
}

class _MostPlayedPageState extends State<MostPlayedPage> {
  final OnAudioQuery _audioQuery = OnAudioQuery();

  @override
  void initState() {
    super.initState();
    initialize();
  }

  Future<void> initialize() async {
    await _initPreferences();
    updatePlayCount(mostPlayedsongID);
    await getMostPlayedSongs();
  }

  Future<void> _initPreferences() async {
    _prefsMostPlayed = await SharedPreferences.getInstance();
    setState(() {
      songIds =
          _prefsMostPlayed.getStringList('songIds')?.map(int.parse).toList() ??
              [];
      playCountMap = { for (var id in songIds) id : _prefsMostPlayed.getInt('$id') ?? 0 };
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        shadowColor: const Color.fromARGB(255, 27, 164, 179),
        elevation: 10,
        backgroundColor: Colors.black,
        automaticallyImplyLeading: false,
        title: Text(
          'Most Played',
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
    if (songIds.isEmpty) {
      return Center(
        child: Text(
          'No played Items',
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
                  itemCount: songIds.length,
                  separatorBuilder: (BuildContext context, int index) {
                    return const SizedBox(
                      height: 4,
                    );
                  },
                  itemBuilder: (BuildContext context, int index) {
                    int currentindex = songIds[index];
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
                              ),
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

  void updatePlayCount(List<int> songIds) {
    setState(() {
      for (int songId in songIds) {
        if (playCountMap.containsKey(songId)) {
          playCountMap[songId] = playCountMap[songId]! + 1;
        } else {
          playCountMap[songId] = 1;
        }
      }
    });
  }

  Future<void> getMostPlayedSongs() async {
    setState(() {
      songIds = playCountMap.keys.toList();
      songIds.sort((a, b) => playCountMap[b]!.compareTo(playCountMap[a]!));
      songIds = songIds.take(10).toList();
    });
    await _saveMostPlayedSongs();
  }

  Future<void> _saveMostPlayedSongs() async {
    _prefsMostPlayed = await SharedPreferences.getInstance();
    await _prefsMostPlayed.setStringList(
      'songIds',
      songIds.map((e) => e.toString()).toList(),
    );
    for (int songId in songIds) {
      await _prefsMostPlayed.setInt('$songId', playCountMap[songId]!);
    }
  }
}
