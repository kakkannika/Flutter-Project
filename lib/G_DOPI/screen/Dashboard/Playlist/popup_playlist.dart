import 'package:e_learning_app/G_DOPI/screen/Dashboard/Playlist/create_playlist.dart';
import 'package:flutter/material.dart';

class PlaylistModal extends StatefulWidget {
  const PlaylistModal({Key? key}) : super(key: key);

  @override
  _PlaylistModalState createState() => _PlaylistModalState();
}

class _PlaylistModalState extends State<PlaylistModal> {
  // Initial list of playlists
  List<Map<String, dynamic>> playlists = [
    {'title': 'Physics', 'courses': []},
    {'title': 'Chemistry', 'courses': []},
    {'title': 'Mathematics', 'courses': []},
  ];
  // Map to keep track of selected playlists
  Map<String, bool> selectedPlaylists = {};

  @override
  void initState() {
    super.initState();
    // Initialize the selectedPlaylists map
    for (var playlist in playlists) {
      selectedPlaylists[playlist['title']] = false;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Playlists'),
      ),
      body: ListView.builder(
        itemCount: playlists.length,
        itemBuilder: (context, index) {
          return CheckboxListTile(
            title: Text(playlists[index]['title']),
            value: selectedPlaylists[playlists[index]['title']],
            onChanged: (bool? value) {
              setState(() {
                selectedPlaylists[playlists[index]['title']] = value!;
              });
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          final newPlaylist = await Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const CreatePlaylistScreen()),
          );
          if (newPlaylist != null) {
            setState(() {
              playlists.add({'title': newPlaylist, 'courses': []});
              selectedPlaylists[newPlaylist] = true;
            });
            Navigator.pop(context, playlists);
          }
        },
        child: const Icon(Icons.add),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ElevatedButton(
          onPressed: () {
            // Handle saving the course to selected playlists
            List<String> selected = selectedPlaylists.entries
                .where((entry) => entry.value)
                .map((entry) => entry.key)
                .toList();
            Navigator.pop(context, playlists);
          },
          child: const Text('Save Course to Selected Playlists'),
        ),
      ),
    );
  }
}