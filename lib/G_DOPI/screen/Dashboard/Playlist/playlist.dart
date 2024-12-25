import 'package:flutter/material.dart';
import 'create_playlist.dart'; // Import the CreatePlaylistScreen
import 'popup_playlist.dart'; // Import the PlaylistModal
import 'edit_playlist.dart'; // Import the EditPlaylistScreen

class Playlist extends StatefulWidget {
  const Playlist({super.key});

  @override
  State<Playlist> createState() => _PlaylistScreenState();
}

class _PlaylistScreenState extends State<Playlist> {
  List<Map<String, dynamic>> playlists = [
    {
      'title': 'Mathematics',
      'courses': [
        {
          'image': 'assets/images/mathematics.jpg',
          'name': 'Mathematics',
          'author': 'T.Heak Dyna',
          'progress': 2,
        },
      ],
    },
    {
      'title': 'H',
      'courses': [],
    },
  ];

  // Function to add a new playlist
  void addPlaylist(String title) {
    setState(() {
      playlists.add({'title': title, 'courses': []});
    });
  }

  // Function to delete a playlist
  void deletePlaylist(int index) {
    setState(() {
      playlists.removeAt(index);
    });
  }

  // Function to edit a playlist
  void editPlaylist(int index, String newTitle) {
    setState(() {
      playlists[index]['title'] = newTitle;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('My Lists'),
        actions: [
          IconButton(
            onPressed: () async {
              final title = await Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const CreatePlaylistScreen(),
                ),
              );
              if (title != null && title.trim().isNotEmpty) {
                addPlaylist(title.trim());
              }
            },
            icon: const Icon(Icons.add),
          ),
        ],
      ),
      body: ListView.builder(
        itemCount: playlists.length,
        itemBuilder: (context, index) {
          final playlist = playlists[index];
          final courses = playlist['courses'] as List;
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Playlist Title
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      playlist['title'],
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Row(
                      children: [
                        IconButton(
                          icon: const Icon(Icons.edit),
                          onPressed: () async {
                            final newTitle = await Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => EditPlaylistScreen(
                                  currentTitle: playlist['title'],
                                ),
                              ),
                            );
                            if (newTitle != null && newTitle.trim().isNotEmpty) {
                              editPlaylist(index, newTitle.trim());
                            }
                          },
                        ),
                        IconButton(
                          icon: const Icon(Icons.delete),
                          onPressed: () {
                            deletePlaylist(index);
                          },
                        ),
                      ],
                    ),
                  ],
                ),
                if (courses.isNotEmpty)
                  Column(
                    children: courses.map((course) {
                      return Card(
                        elevation: 3,
                        margin: const EdgeInsets.only(top: 8.0),
                        child: Row(
                          children: [
                            // Course Image
                            Image.network(
                              course['image'],
                              width: 80,
                              height: 80,
                              fit: BoxFit.cover,
                            ),
                            const SizedBox(width: 12),
                            // Course Details
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    course['name'],
                                    style: const TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  Text(
                                    course['author'],
                                    style: const TextStyle(
                                      fontSize: 14,
                                      color: Colors.grey,
                                    ),
                                  ),
                                  const SizedBox(height: 4),
                                  // Progress bar and percentage
                                  Row(
                                    children: [
                                      Expanded(
                                        child: LinearProgressIndicator(
                                          value: course['progress'] / 100,
                                          backgroundColor: Colors.grey.shade300,
                                          color: Colors.blue,
                                        ),
                                      ),
                                      const SizedBox(width: 8),
                                      Text('${course['progress']}%'),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      );
                    }).toList(),
                  ),
                const Divider(height: 24, thickness: 1),
              ],
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          final newPlaylists = await Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const PlaylistModal()),
          );
          if (newPlaylists != null) {
            setState(() {
              playlists = newPlaylists;
            });
          }
        },
        child: const Icon(Icons.playlist_add),
      ),
    );
  }
}