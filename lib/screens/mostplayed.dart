import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class MostPlayedPage extends StatefulWidget {
  const MostPlayedPage({super.key});

  @override
  State<MostPlayedPage> createState() => _MostPlayedPageState();
}

class _MostPlayedPageState extends State<MostPlayedPage> {
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
      body: Container(),
    );
  }
}
