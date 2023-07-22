//Stateless and Implemented BLoC

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:musicuitest/bloc/recent_bloc/recent_bloc_bloc.dart';
import 'package:on_audio_query/on_audio_query.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../utils/globalpage.dart';
import '../nowplaying/nowplaying.dart';

final OnAudioQuery _audioQuery = OnAudioQuery();
List<int> recentSongsList = [];
late SharedPreferences prefsrecent;

class RecentPage extends StatelessWidget {
  const RecentPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => RecentBlocBloc(context),
      child: Scaffold(
        appBar: AppBar(
          actions: [
            BlocBuilder<RecentBlocBloc, RecentBlocState>(
              builder: (context, state) {
                return IconButton(
                  onPressed: () {
                    BlocProvider.of<RecentBlocBloc>(context)
                        .add(RecentEvent(context: context));
                    //_clearRecentSongs(context);
                  },
                  icon: const Icon(Icons.clear_all_rounded),
                );
              },
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
      ),
    );
  }

  Widget _buildListView() {
    return FutureBuilder<List<int>>(
      future: loadRecentArray(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(
            child: CircularProgressIndicator(),
          );
        } else if (snapshot.hasError) {
          return Center(
            child: Text('Error loading recent songs.'),
          );
        } else {
          final recentArray = snapshot.data ?? [];
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
                        itemCount: recentArray.length,
                        separatorBuilder: (BuildContext context, int index) {
                          return const SizedBox(
                            height: 4,
                          );
                        },
                        itemBuilder: (BuildContext context, int index) {
                          int currentindex = recentArray[index];
                          return ClipRRect(
                            borderRadius: BorderRadius.circular(25.0),
                            child: Card(
                              color: const Color.fromARGB(255, 252, 251, 251),
                              elevation: 3.0,
                              shadowColor:
                                  const Color.fromARGB(255, 252, 251, 251),
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
                                    tileColor: const Color.fromARGB(
                                        255, 250, 250, 251),
                                    trailing: Row(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        IconButton(
                                          onPressed: () async {
                                            Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                builder: (context) =>
                                                    NowPlaying(
                                                  index: currentindex,
                                                ),
                                              ),
                                            );
                                          },
                                          icon: const Icon(
                                            Icons.play_arrow,
                                            size: 30,
                                            color: Color.fromARGB(
                                                255, 27, 164, 179),
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
      },
    );
  }

  Future<List<int>> loadRecentArray() async {
    prefsrecent = await SharedPreferences.getInstance();
    return prefsrecent.getStringList('recentArray')?.map(int.parse).toList() ??
        [];
  }
}

Future<void> saveRecentArray() async {
  prefsrecent = await SharedPreferences.getInstance();
  await prefsrecent.setStringList(
      'recentArray', recentArray.map((e) => e.toString()).toList());
}
