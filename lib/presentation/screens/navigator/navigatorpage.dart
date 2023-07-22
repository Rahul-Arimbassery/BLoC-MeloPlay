////// Stateless and BLoC Logic Implemented
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:marquee/marquee.dart';
import 'package:musicuitest/bloc/navigator/bloc/navigator_bloc_bloc.dart';
import 'package:musicuitest/presentation/screens/home/homepage.dart';
import 'package:musicuitest/presentation/screens/favorites/favoritepage.dart';
import 'package:musicuitest/presentation/screens/mostplayed/mostplayed.dart';
import 'package:musicuitest/presentation/screens/nowplaying/nowplaying.dart';
import 'package:musicuitest/presentation/screens/playlist/playlistpage.dart';
import 'package:musicuitest/presentation/screens/recent/recentpage.dart';
import 'package:musicuitest/presentation/screens/settings/settingpage.dart';
import 'package:on_audio_query/on_audio_query.dart';

import '../../../utils/globalpage.dart';

bool miniPlayerindex = false;
int songNameindex = 0;
bool pagestatus = false;
final OnAudioQuery _audioQuery = OnAudioQuery();

// ignore: must_be_immutable
class NavigatorPage extends StatelessWidget {
  NavigatorPage({Key? key}) : super(key: key);

  final List<Widget> _pages = [
    const HomePage(), // Add your home page widget here
    const FavoritePage(), // Add your favorite page widget here
    RecentPage(), // Add your recent page widget here
    const PlaylistPage(), // Add your playlist page widget here
    MostPlayedPage(), // Add your most played page widget here
  ];

  int _currentIndex = 0;
  bool isPlaying1 = false;
  var selectedItemColor1 = const Color.fromARGB(255, 27, 164, 179);
  var unselectedItemColor1 = const Color.fromARGB(255, 5, 5, 5);
  var previousindex;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => NavigatorBlocBloc(),
      child: Scaffold(
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
                left: 170, //for emulator
                right: 10,
                top: 10,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Center(
                      child: Text(
                        '🪘  🪕  🎸  🪘  🎷  🎺',
                        style: TextStyle(
                          fontSize: 12,
                          color: Color.fromARGB(255, 6, 6, 6),
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    IconButton(
                      icon: const Icon(
                        Icons.settings,
                        color: Color.fromARGB(255, 191, 195, 188),
                        size: 22,
                      ),
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const SettingsPage(),
                          ),
                        );
                      },
                    ),
                  ],
                ),
              ),
              BlocBuilder<NavigatorBlocBloc, NavigatorBlocState>(
                builder: (context, state) {
                  if (state is PageNavigateSuccess) {
                    _currentIndex = state.currentIndex;
                  }
                  return Positioned.fill(
                    top: 55,
                    child: _pages[_currentIndex],
                  );
                },
              ),
              Positioned(
                // when press on miniplayer go back to nowplaying
                left: 18,
                right: 0,
                bottom: 0,
                child: BlocBuilder<NavigatorBlocBloc, NavigatorBlocState>(
                  builder: (context, state) {
                    if (state is StopMiniPlayerState) {
                      showMiniPlayer = state.showMiniPlayer;
                    }
                    return Visibility(
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
                              topLeft: Radius.circular(45),
                              topRight: Radius.circular(0),
                              bottomLeft: Radius.circular(5),
                              bottomRight: Radius.circular(0),
                            ),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.only(
                              left: 08.0,
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
                                        child: BlocBuilder<NavigatorBlocBloc,
                                            NavigatorBlocState>(
                                          builder: (context, state) {
                                            if (state is SkipPreviousState) {
                                              songNameindex =
                                                  state.songNameindexnew - 2;
                                            }
                                            if (state is SkipNextState) {
                                              songNameindex =
                                                  state.songNameindexnewone;
                                            }
                                            return Row(
                                              children: [
                                                QueryArtworkWidget(
                                                  artworkQuality:
                                                      FilterQuality.high,
                                                  controller: _audioQuery,
                                                  id: ids[songNameindex],
                                                  type: ArtworkType.AUDIO,
                                                  nullArtworkWidget: const Icon(
                                                    Icons.music_note,
                                                    color: Colors.amber,
                                                    size: 30,
                                                  ),
                                                  artworkBorder:
                                                      BorderRadius.circular(
                                                          30), // Set the desired height // Set the desired aspect ratio
                                                ),
                                                const SizedBox(width: 2),
                                                Expanded(
                                                  child: Marquee(
                                                    text: songNames[
                                                        songNameindex],
                                                    style: const TextStyle(
                                                      fontSize: 12,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      color: Colors.white,
                                                    ),
                                                    scrollAxis: Axis.horizontal,
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .center,
                                                    blankSpace: 20.0,
                                                    velocity: 25.0,
                                                    pauseAfterRound:
                                                        const Duration(
                                                            seconds: 1),
                                                    showFadingOnlyWhenScrolling:
                                                        true,
                                                  ),
                                                ),
                                              ],
                                            );
                                          },
                                        ),
                                      ),
                                const SizedBox(
                                  width: 5,
                                ),
                                Builder(builder: (context) {
                                  return IconButton(
                                    onPressed: () {
                                      BlocProvider.of<NavigatorBlocBloc>(
                                              context)
                                          .add(
                                        SkipPreviousEvent(
                                            songNameindexnew: songNameindex),
                                      );

                                      skipPrevious1();
                                    },
                                    icon: const Icon(
                                      Icons.skip_previous,
                                      color: Colors.amber,
                                    ),
                                  );
                                }),
                                IconButton(
                                  onPressed: () {
                                    playMusic1();
                                    BlocProvider.of<NavigatorBlocBloc>(context)
                                        .add(
                                      PlayPauseEvent(isPlaying1: isPlaying1),
                                    );
                                  },
                                  icon: BlocBuilder<NavigatorBlocBloc,
                                      NavigatorBlocState>(
                                    builder: (context, state) {
                                      if (state is PlayPauseState) {
                                        isPlaying1 = state.isPlaying1;
                                      }
                                      return Icon(
                                        isPlaying1
                                            ? Icons.play_arrow
                                            : Icons.pause,
                                        color: isPlaying1
                                            ? Colors.amber
                                            : const Color.fromARGB(
                                                255, 27, 164, 179),
                                        size: 30,
                                      );
                                    },
                                  ),
                                ),
                                Builder(builder: (context) {
                                  return IconButton(
                                    onPressed: () {
                                      BlocProvider.of<NavigatorBlocBloc>(
                                              context)
                                          .add(
                                        SkipNextEvent(
                                            songNameindexnewone: songNameindex),
                                      );
                                      skipNext1();
                                    },
                                    icon: const Icon(
                                      Icons.skip_next,
                                      color: Colors.amber,
                                    ),
                                  );
                                }),
                                const SizedBox(
                                  width: 0,
                                ),
                                IconButton(
                                  onPressed: () {
                                    BlocProvider.of<NavigatorBlocBloc>(context)
                                        .add(
                                      StopMiniPlayerEvent(
                                          showMiniPlayer: false),
                                    );

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
                    );
                  },
                ),
              ),
            ],
          ),
        ),
        bottomNavigationBar: BlocBuilder<NavigatorBlocBloc, NavigatorBlocState>(
          builder: (context, state) {
            //--------Extra builder is used to avoid context issue in BLoC----------
            if (state is PageNavigateSuccess) {
              selectedItemColor1 = const Color.fromARGB(255, 27, 164, 179);
              unselectedItemColor1 = const Color.fromARGB(255, 5, 5, 5);
            }
            return Builder(builder: (context) {
              return BottomNavigationBar(
                currentIndex: _currentIndex,
                onTap: (int index) {
                  _currentIndex = index;
                  BlocProvider.of<NavigatorBlocBloc>(context).add(
                    PageNavigateEvent(currentIndex: _currentIndex),
                  );
                  pagestatus = false;
                  if (_currentIndex == 3) {
                    pagestatus = true;
                  }
                },
                selectedItemColor: selectedItemColor1,
                unselectedItemColor: unselectedItemColor1,
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
                ],
              );
            });
          },
        ),
      ),
    );
  }
}
