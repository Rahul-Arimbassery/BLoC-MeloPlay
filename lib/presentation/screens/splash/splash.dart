//stateless
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:musicuitest/presentation/screens/navigator/navigatorpage.dart';
import 'package:permission_handler/permission_handler.dart';

class SplashScreen extends StatelessWidget {
  Future<PermissionStatus> requestPermissions() async {
    final PermissionStatus status = await Permission.storage.request();
    return status;
  }

  Widget buildSplashScreen(BuildContext context) {
    return Scaffold(
      body: Container(
        color: const Color.fromARGB(255, 253, 253, 253),
        child: Padding(
          padding: EdgeInsets.all(MediaQuery.of(context).size.width * 0.05),
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
                    width: MediaQuery.of(context).size.width * 0.8,
                    height: MediaQuery.of(context).size.height * 0.4,
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<PermissionStatus>(
      future: requestPermissions(),
      builder:
          (BuildContext context, AsyncSnapshot<PermissionStatus> snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          // Permissions are being requested, show a loading indicator or any desired widget
          return Center(
            child: CircularProgressIndicator(),
          );
        } else {
          final PermissionStatus permissionStatus = snapshot.data!;
          if (permissionStatus.isGranted) {
            // Permissions granted, navigate to the home page or perform any additional actions
            return NavigatorPage();
          } else {
            // Permissions denied or restricted, show the appropriate screen or take necessary actions
            return Scaffold(
              body: Container(
                color: Colors
                    .red, // Customize the color for the permission denied state
                child: Center(
                  child: Text(
                    'Permission Denied!',
                    style: TextStyle(
                      fontSize: 20,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            );
          }
        }
      },
    );
  }
}
