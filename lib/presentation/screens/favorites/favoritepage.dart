// import 'package:flutter/material.dart';
// import 'package:google_fonts/google_fonts.dart';
// import 'package:hive/hive.dart';
// import 'package:musicuitest/utils/globalpage.dart';
// import 'package:musicuitest/presentation/screens/home/homepage.dart';
// import 'package:musicuitest/presentation/screens/nowplaying/nowplaying.dart';
// import 'package:on_audio_query/on_audio_query.dart';
// import 'package:fluttertoast/fluttertoast.dart';

// import '../../../models/allsongs.dart';

// final OnAudioQuery _audioQuery = OnAudioQuery();

// List<bool> isFavoriteChanged = List.generate(100, (index) => false);

// class FavoritePage extends StatefulWidget {
//   const FavoritePage({Key? key});

//   @override
//   State<FavoritePage> createState() => _FavoritePageState();
// }

// class _FavoritePageState extends State<FavoritePage> {
//   List<int> indexes = [];

//   @override
//   void initState() {
//     super.initState();
//     readFavoritedb().then((resultIndexes) {
//       setState(() {
//         indexes = resultIndexes;
//       });
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         shadowColor: const Color.fromARGB(255, 27, 164, 179),
//         elevation: 10,
//         backgroundColor: Colors.black,
//         automaticallyImplyLeading: false,
//         title: Text(
//           'Favorite Songs',
//           style: GoogleFonts.acme(
//             textStyle: const TextStyle(fontSize: 22),
//           ),
//         ),
//       ),
//       body: Container(
//         decoration: const BoxDecoration(
//             gradient: RadialGradient(
//           colors: [
//             Color.fromARGB(255, 61, 61, 58),
//             Color.fromARGB(255, 254, 254, 253),
//           ],
//           center: Alignment.topLeft,
//           radius: 1.2,
//         ),),
//         child: indexes.isEmpty
//             ? Center(
//                 child: Text(
//                   'No Favorite Songs !!',
//                   style: GoogleFonts.acme(
//                     textStyle: const TextStyle(fontSize: 22),
//                   ),
//                 ),
//               )
//             : Padding(
//                 padding: const EdgeInsets.all(12.0),
//                 child: ListView.separated(
//                   itemCount: indexes.length,
//                   separatorBuilder: (BuildContext context, int index) {
//                     return const SizedBox(
//                       height:
//                           4, // set the desired height of the space between each ListTile
//                     );
//                   },
//                   itemBuilder: (context, index) {
//                     int currentindex = indexes[index];
//                     return ClipRRect(
//                       borderRadius: BorderRadius.circular(
//                           25.0), // set the desired border radius value
//                       child: Card(
//                         color: const Color.fromARGB(255, 190, 188, 188),
//                         elevation: 3.0,
//                         shadowColor: const Color.fromARGB(255, 188, 184, 184),
//                         child: SizedBox(
//                           height: 70.0, // set the desired height of the Card
//                           width: double
//                               .infinity, // set the width to match the parent ListView
//                           child: InkWell(
//                             onTap: () {
//                               Navigator.push(
//                                 context,
//                                 MaterialPageRoute(
//                                   builder: (context) => NowPlaying(
//                                     index: currentindex,
//                                   ),
//                                 ),
//                               );
//                             },
//                             child: ListTile(
//                               leading: QueryArtworkWidget(
//                                 controller: _audioQuery,
//                                 id: ids[currentindex],
//                                 type: ArtworkType.AUDIO,
//                                 nullArtworkWidget: const Icon(
//                                   Icons.music_note,
//                                   color: Colors.amber,
//                                   size: 50,
//                                 ),
//                               ),
//                               title: Text(
//                                 songNames[currentindex],
//                                 overflow: TextOverflow.ellipsis,
//                               ),
//                               subtitle: Text(
//                                 artistNames[currentindex]!,
//                                 overflow: TextOverflow.ellipsis,
//                               ),
//                               tileColor:
//                                   const Color.fromARGB(255, 250, 250, 251),
//                               trailing: Row(
//                                 mainAxisSize: MainAxisSize.min,
//                                 children: [
//                                   IconButton(
//                                     onPressed: () {
//                                       setState(() {
//                                         indexes.remove(currentindex);
//                                       });
//                                       deleteSongFromFavorite(currentindex);
//                                       Fluttertoast.showToast(
//                                         msg: 'Song Removed from Favorites',
//                                         backgroundColor: const Color.fromARGB(
//                                             255, 27, 164, 179),
//                                       );
//                                     },
//                                     icon: const Icon(
//                                       Icons.delete_outline_rounded,
//                                       color: Color.fromARGB(255, 27, 164, 179),
//                                     ),
//                                   ),
//                                 ],
//                               ), // set the background color based on the view mode
//                             ),
//                           ),
//                         ),
//                       ),
//                     );
//                   },
//                 ),
//               ),
//       ),
//     );
//   }

//   Future<List<int>> readFavoritedb() async {
//     var favorite = await Hive.openBox<AllSongs>('allSongs');
//     indexes.clear();
//     for (int i = 0; i < favorite.length; i++) {
//       var song = favorite.getAt(i);
//       if (song != null) {
//         indexes.add(song.songID);
//       }
//     }
//     return indexes;
//   }

//   void clearFavoritedb() async {
//     var favorite = await Hive.openBox<AllSongs>('allSongs');
//     await favorite.clear();
//   }
// }


/// Implement Block Logic

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hive/hive.dart';
import 'package:musicuitest/bloc/favorite_bloc/bloc/favorite_bloc.dart';
import 'package:musicuitest/utils/globalpage.dart';
import 'package:musicuitest/presentation/screens/nowplaying/nowplaying.dart';
import 'package:on_audio_query/on_audio_query.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../../../models/allsongs.dart';

List<int> indexes = [];

List<bool> isFavoriteChanged = List.generate(100, (index) => false);

class FavoritePage extends StatelessWidget {
  const FavoritePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => FavoriteBloc(),
      child: Scaffold(
        appBar: AppBar(
          shadowColor: const Color.fromARGB(255, 27, 164, 179),
          elevation: 10,
          backgroundColor: Colors.black,
          automaticallyImplyLeading: false,
          title: Text(
            'Favorite Songs',
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
          child: FutureBuilder<List<int>>(
            future: readFavoritedb(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Center(
                  child: CircularProgressIndicator(),
                );
              } else if (snapshot.hasData && snapshot.data!.isEmpty) {
                return Center(
                  child: Text(
                    'No Favorite Songs !!',
                    style: GoogleFonts.acme(
                      textStyle: const TextStyle(fontSize: 22),
                    ),
                  ),
                );
              } else if (snapshot.hasData) {
                indexes = snapshot.data!;
                return Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: BlocBuilder<FavoriteBloc, FavoriteState>(   //Implemented Bloc Builder to rebuild UI
                    builder: (context, state) {
                      return ListView.separated(
                        itemCount: indexes.length,
                        separatorBuilder: (BuildContext context, int index) {
                          return const SizedBox(
                            height:
                                4, // set the desired height of the space between each ListTile
                          );
                        },
                        itemBuilder: (context, index) {
                          int currentindex = indexes[index];
                          return ClipRRect(
                            borderRadius: BorderRadius.circular(25.0),
                            child: Card(
                              color: const Color.fromARGB(255, 190, 188, 188),
                              elevation: 3.0,
                              shadowColor:
                                  const Color.fromARGB(255, 188, 184, 184),
                              child: SizedBox(
                                height: 70.0,
                                width: double.infinity,
                                child: InkWell(
                                  onTap: () {
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
                                      controller: OnAudioQuery(),
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
                                    tileColor: const Color.fromARGB(
                                        255, 250, 250, 251),
                                    trailing: Row(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        IconButton(
                                          onPressed: () {
                                            BlocProvider.of<FavoriteBloc>(
                                                    context)
                                                .add(DeleteFavoriteEvent(
                                                    currentindex:
                                                        currentindex));
                                            Fluttertoast.showToast(
                                              msg:
                                                  'Song Removed from Favorites',
                                              backgroundColor:
                                                  const Color.fromARGB(
                                                      255, 27, 164, 179),
                                            );
                                          },
                                          icon: const Icon(
                                            Icons.delete_outline_rounded,
                                            color: Color.fromARGB(
                                                255, 27, 164, 179),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          );
                        },
                      );
                    },
                  ),
                );
              } else {
                return Center(
                  child: Text(
                    'Error loading favorite songs.',
                    style: GoogleFonts.acme(
                      textStyle: const TextStyle(fontSize: 22),
                    ),
                  ),
                );
              }
            },
          ),
        ),
      ),
    );
  }
}

Future<List<int>> readFavoritedb() async {
  var favorite = await Hive.openBox<AllSongs>('allSongs');
  indexes.clear();
  for (int i = 0; i < favorite.length; i++) {
    var song = favorite.getAt(i);
    if (song != null) {
      indexes.add(song.songID);
    }
  }
  return indexes;
}

void clearFavoritedb() async {
  var favorite = await Hive.openBox<AllSongs>('allSongs');
  await favorite.clear();
}
