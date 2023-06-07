import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
//import 'package:musicuitest/homepage.dart';
import 'package:musicuitest/screens/navigatorpage.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({Key? key});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: Future.delayed(
          const Duration(seconds: 3)), // add a delay of 5 seconds
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          // show the splash screen while waiting for the delay
          return Scaffold(
            body: LayoutBuilder(
              builder: (BuildContext context, BoxConstraints constraints) {
                return Container(
                  //color: const Color.fromARGB(255, 160, 159, 163),
                  color: const Color.fromARGB(255, 253, 253, 253),
                  child: Padding(
                    padding: EdgeInsets.all(constraints.maxWidth * 0.05),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const SizedBox(height: 60),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              'Play Your Perfect Music',
                              style: GoogleFonts.acme(
                                textStyle: const TextStyle(
                                  fontSize: 20,
                                  color: Color.fromARGB(255, 27, 164, 179),
                                  fontWeight: FontWeight.normal,
                                ),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 120),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              'MeloPlay',
                              style: GoogleFonts.acme(
                                textStyle: const TextStyle(
                                  fontSize: 60,
                                  color: Color.fromARGB(255, 8, 8, 8),
                                  fontWeight: FontWeight.w300,
                                ),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 60),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Image.asset(
                              "asset/images/music-band.png",
                              width: constraints.maxWidth * 0.8,
                              height: constraints.maxHeight * 0.4,
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          );
        } else {
          // navigate to the home page after the delay
          return const NavigatorPage();
        }
      },
    );
  }
}
