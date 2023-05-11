import 'package:flutter/material.dart';

class NowPlaying extends StatefulWidget {
  const NowPlaying({super.key});

  @override
  State<NowPlaying> createState() => _NowPlayingState();
}

class _NowPlayingState extends State<NowPlaying> {
  double seekBarValue = 0.2;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 251, 249, 249),
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 233, 230, 230),
        title: Container(
          width: 370,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            color: const Color.fromARGB(255, 251, 249, 249),
          ),
          child: Row(
            children: [
              IconButton(
                onPressed: () {},
                icon: const Icon(Icons.arrow_circle_left),
                color: Colors.black,
              ),
              const SizedBox(
                width: 78,
              ),
              const Text(
                "Now Playing",
                style: TextStyle(color: Colors.black),
              ),
              const SizedBox(
                width: 75,
              ),
            ],
          ),
        ),
      ),
      body: Column(
        children: [
          Row(
            children: [
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: Container(
                  width: 370,
                  height: 300,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(40),
                    color: const Color.fromARGB(255, 239, 234, 234),
                  ),
                  child: Column(
                    children: [
                      Image.asset(
                        "asset/images/music-band.png",
                        width: 350,
                      ),
                      const Text(
                        "Song Name",
                        style: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
          Row(
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 20, right: 20),
                child: Container(
                  width: 370,
                  height: 30,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(40),
                    color: const Color.fromARGB(255, 239, 234, 234),
                  ),
                  child: Slider(
                    value: seekBarValue,
                    min: 0.0, // Minimum value of the seek bar
                    max: 1.0, // Maximum value of the seek bar
                    onChanged: (newValue) {
                      setState(() {
                        seekBarValue = newValue;
                      });
                    },
                    activeColor:
                        Colors.blue, // Color of the seek bar when active
                    inactiveColor:
                        Colors.grey, // Color of the seek bar when inactive
                  ),
                ),
              ),
            ],
          ),
          Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 22, right: 20, top: 20),
                child: Row(
                  children: [
                    Container(
                      width: 60,
                      height: 50,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(40),
                        color: const Color.fromARGB(255, 239, 234, 234),
                      ),
                      child: IconButton(
                        onPressed: () {},
                        icon: const Icon(
                          Icons.skip_previous,
                          color: Colors.black,
                          size: 30,
                        ),
                      ),
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    Container(
                      width: 40,
                      height: 40,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(40),
                        color: const Color.fromARGB(255, 239, 234, 234),
                      ),
                      child: IconButton(
                        onPressed: () {},
                        icon: const Icon(
                          Icons.fast_rewind,
                          color: Colors.black,
                          size: 20,
                        ),
                      ),
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    Container(
                      width: 120,
                      height: 50,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(40),
                        color: const Color.fromARGB(255, 239, 234, 234),
                      ),
                      child: IconButton(
                        onPressed: () {},
                        icon: const Icon(
                          Icons.play_arrow,
                          color: Colors.black,
                          size: 30,
                        ),
                      ),
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    Container(
                      width: 40,
                      height: 40,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(40),
                        color: const Color.fromARGB(255, 239, 234, 234),
                      ),
                      child: IconButton(
                        onPressed: () {},
                        icon: const Icon(
                          Icons.fast_forward,
                          color: Colors.black,
                          size: 20,
                        ),
                      ),
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    Container(
                      width: 60,
                      height: 50,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(40),
                        color: const Color.fromARGB(255, 239, 234, 234),
                      ),
                      child: IconButton(
                        onPressed: () {},
                        icon: const Icon(
                          Icons.skip_next,
                          color: Colors.black,
                          size: 30,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.only(left: 70, right: 20, top: 20),
            child: Row(
              children: [
                Column(
                  children: [
                    Container(
                      width: 40,
                      height: 40,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(40),
                        color: const Color.fromARGB(255, 239, 234, 234),
                      ),
                      child: IconButton(
                        onPressed: () {},
                        icon: const Icon(
                          Icons.shuffle,
                          color: Colors.black,
                          size: 20,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  width: 35,
                ),
                Column(
                  children: [
                    Container(
                      width: 40,
                      height: 40,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(40),
                        color: const Color.fromARGB(255, 239, 234, 234),
                      ),
                      child: IconButton(
                        onPressed: () {},
                        icon: const Icon(
                          Icons.favorite,
                          color: Colors.black,
                          size: 20,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  width: 35,
                ),
                Column(
                  children: [
                    Container(
                      width: 40,
                      height: 40,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(40),
                        color: const Color.fromARGB(255, 239, 234, 234),
                      ),
                      child: IconButton(
                        onPressed: () {},
                        icon: const Icon(
                          Icons.playlist_add,
                          color: Colors.black,
                          size: 20,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  width: 35,
                ),
                Column(
                  children: [
                    Container(
                      width: 40,
                      height: 40,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(40),
                        color: const Color.fromARGB(255, 239, 234, 234),
                      ),
                      child: IconButton(
                        onPressed: () {},
                        icon: const Icon(
                          Icons.repeat,
                          color: Colors.black,
                          size: 20,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}