import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:musicuitest/screens/navigatorpage.dart';
import 'package:permission_handler/permission_handler.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key});

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  bool _permissionsGranted = false;

  @override
  void initState() {
    super.initState();
    requestPermissions();
  }

  Future<void> requestPermissions() async {
    final PermissionStatus status = await Permission.storage.request();
    setState(() {
      _permissionsGranted = status.isGranted;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: LayoutBuilder(
        builder: (BuildContext context, BoxConstraints constraints) {
          if (_permissionsGranted) {
            // Permissions granted, navigate to the home page
            return const NavigatorPage();
          } else {
            // Permissions not granted, show the splash screen
            return Container(
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
          }
        },
      ),
    );
  }
}
