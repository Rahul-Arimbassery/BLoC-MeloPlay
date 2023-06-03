import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:marquee/marquee.dart';
import 'package:musicuitest/homepage.dart';
import 'package:musicuitest/screens/favoritepage.dart';
import 'package:musicuitest/screens/mostplayed.dart';
import 'package:musicuitest/screens/nowplaying.dart';
import 'package:musicuitest/screens/playlistpage.dart';
import 'package:musicuitest/screens/recentpage.dart';
import 'package:musicuitest/screens/settingpage.dart';
import 'package:on_audio_query/on_audio_query.dart';

import '../globalpage.dart';

bool miniPlayerindex = false;
int songNameindex = 0;
bool pagestatus = false;
final OnAudioQuery _audioQuery = OnAudioQuery();

class NavigatorPage extends StatefulWidget {
  const NavigatorPage({Key? key}) : super(key: key);

  @override
  State<NavigatorPage> createState() => _NavigatorPageState();
}

class _NavigatorPageState extends State<NavigatorPage> {
  final List<Widget> _pages = [
    const HomePage(), // Add your home page widget here
    const FavoritePage(), // Add your favorite page widget here
    const RecentPage(), // Add your recent page widget here
    const PlaylistPage(), // Add your playlist page widget here
    const MostPlayedPage(), // Add your most played page widget here
    const SettingsPage(), // Add your settings page widget here
  ];

  int _currentIndex = 0;
  bool isPlaying1 = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 4, 0, 0),
      body: SafeArea(
        child: Stack(
          children: [
            Positioned(
              left: 18,
              right: 210, // for emulator
              top: 1,
              child: Container(
                height: 55,
                decoration: const BoxDecoration(
                  color: Color.fromARGB(255, 253, 251, 251),
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(100),
                    topRight: Radius.circular(30),
                  ),
                ),
                child: Center(
                  child: Text(
                    'MeloPlay',
                    style: GoogleFonts.acme(
                        textStyle: const TextStyle(
                          fontSize: 22,
                        ),
                        fontWeight: FontWeight.bold),
                  ),
                ),
              ),
            ),
            Positioned(
              //left: 130,  //for mobile
              left: 180, //for emulator
              right: 0,
              top: 10,
              child: Container(
                height: 55,
                decoration: const BoxDecoration(
                  color: Color.fromARGB(255, 5, 5, 5),
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(30),
                    topRight: Radius.circular(30),
                  ),
                ),
                child: const Center(
                  child: Text(
                    '🪘  🪕  🎸  🎶  🎷  🎺',
                    style: TextStyle(
                        fontSize: 12,
                        color: Color.fromARGB(255, 6, 6, 6),
                        fontWeight: FontWeight.bold),
                  ),
                ),
              ),
            ),
            Positioned.fill(
              top: 55,
              child: _pages[_currentIndex],
            ),
            Positioned(
              // when press on miniplayer go back to nowplaying
              left: 18,
              right: 0,
              bottom: 0,
              child: Visibility(
                visible: showMiniPlayer,
                child: GestureDetector(
                  onTap: () {
                    miniPlayerindex = true;
                    Navigator.pop(context, index1);
                  },
                  child: Container(
                    height: 60,
                    decoration: const BoxDecoration(
                      color: Colors.black,
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(90),
                        topRight: Radius.circular(0),
                        bottomLeft: Radius.circular(0),
                        bottomRight: Radius.circular(0),
                      ),
                    ),
                    child: Padding(
                      //padding: const EdgeInsets.all(8.0),
                      padding: const EdgeInsets.only(
                        left: 15.0,
                        top: 10,
                        bottom: 6,
                        right: 3,
                      ),
                      child: Row(
                        children: [
                          const SizedBox(
                            width: 10,
                          ),
                          !showMiniPlayer
                              ? const Text(
                                  'Now Playing',
                                  style: TextStyle(
                                    fontSize: 8,
                                    color: Colors.white,
                                  ),
                                )                       
                              : Expanded(
                                  child: Row(
                                    children: [
                                      QueryArtworkWidget(
                                        artworkQuality: FilterQuality.high,
                                        controller: _audioQuery,
                                        id: ids[songNameindex],
                                        type: ArtworkType.AUDIO,
                                        nullArtworkWidget: const Icon(
                                          Icons.music_note,
                                          color: Colors.amber,
                                          size: 30,
                                        ),
                                        artworkBorder: BorderRadius.circular(
                                            30), // Set the desired height // Set the desired aspect ratio
                                      ),
                                      const SizedBox(width: 2),
                                      Expanded(                                   
                                        child: Marquee(
                                          text: songNames[songNameindex],
                                          style: const TextStyle(
                                            fontSize: 12,
                                            fontWeight: FontWeight.bold,
                                            color: Colors.white,
                                          ),
                                          scrollAxis: Axis.horizontal,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          blankSpace: 20.0,
                                          velocity: 25.0,
                                          pauseAfterRound:
                                              const Duration(seconds: 1),
                                          showFadingOnlyWhenScrolling: true,
                                        ),
                                      ),
                                    ],
                                  ),
                                  
                                ),
                          const SizedBox(
                            width: 5,
                          ),
                          IconButton(
                            onPressed: () {
                              setState(() {
                                songNameindex = songNameindex + 1;
                                skipPrevious1();
                              });
                            },
                            icon: const Icon(
                              Icons.skip_previous,
                              color: Colors.amber,
                            ),
                          ),
                          IconButton(
                            onPressed: () {
                              playMusic1();
                              setState(() {
                                isPlaying1 = !isPlaying1;
                              });
                            },
                            icon: Icon(
                              isPlaying1 ? Icons.play_arrow : Icons.pause,
                              color: isPlaying1
                                  ? Colors.amber
                                  : const Color.fromARGB(255, 27, 164, 179),
                              size: 30,
                            ),
                          ),
                          IconButton(
                            onPressed: () {
                              setState(() {
                                songNameindex = songNameindex + 1;
                                skipNext1();
                              });
                            },
                            icon: const Icon(
                              Icons.skip_next,
                              color: Colors.amber,
                            ),
                          ),
                          const SizedBox(
                            width: 0,
                          ),
                          IconButton(
                            onPressed: () {
                              setState(() {
                                showMiniPlayer = false;
                              });
                              stopMiniplayer();
                            },
                            icon: const Icon(
                              Icons.stop_circle_outlined,
                              color: Colors.amber,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: (int index) {
          setState(() {
            _currentIndex = index;
            pagestatus = true;
          });
        },
        //backgroundColor: Colors.black,
        selectedItemColor: const Color.fromARGB(255, 27, 164, 179),
        unselectedItemColor: const Color.fromARGB(255, 5, 5, 5),
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.favorite),
            label: 'Favorite',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.music_note),
            label: 'Recent',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.playlist_add_check),
            label: 'Playlist',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.play_circle_rounded),
            label: 'Most Played',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.settings),
            label: 'Settings',
          ),
        ],
      ),
    );
  }
}
