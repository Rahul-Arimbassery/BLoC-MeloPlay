import 'package:flutter/material.dart';

class AddPlaylistPage extends StatefulWidget {
  @override
  _AddPlaylistPageState createState() => _AddPlaylistPageState();
}

class _AddPlaylistPageState extends State<AddPlaylistPage> {
  bool showTextField = false;
  TextEditingController _textEditingController = TextEditingController();

  @override
  void dispose() {
    _textEditingController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Create Playlist'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (showTextField)
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Row(
                  children: [
                    Expanded(
                      child: TextField(
                        controller: _textEditingController,
                        decoration: const InputDecoration(
                          hintText: 'Enter playlist name',
                        ),
                      ),
                    ),
                    IconButton(
                      onPressed: () {
                        setState(() {
                          showTextField = false;
                          _textEditingController.clear();
                        });
                      },
                      icon: const Icon(Icons.cancel),
                      color: Colors.red,
                    ),
                    IconButton(
                      onPressed: () {
                        // Perform the playlist creation logic here
                        //add to playlist page
                        // Perform the playlist creation logic here

                        setState(() {
                          showTextField = false;
                          _textEditingController.clear();
                        });
                      },
                      icon: const Icon(Icons.add_box),
                      color: Colors.green,
                    ),
                  ],
                ),
              ),
            IconButton(
              onPressed: () {
                setState(() {
                  showTextField = true;
                });
              },
              icon: const Icon(
                Icons.playlist_add,
                size: 40,
                color: Colors.black,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
