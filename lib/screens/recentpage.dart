import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
class RecentPage extends StatefulWidget {
  const RecentPage({super.key});

  @override
  State<RecentPage> createState() => _RecentPageState();
}

class _RecentPageState extends State<RecentPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
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
      body: Container(),
    );
  }
}
