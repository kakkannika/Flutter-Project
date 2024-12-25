import 'package:flutter/material.dart';

class EditPlaylistScreen extends StatelessWidget {
  final String currentTitle;

  const EditPlaylistScreen({Key? key, required this.currentTitle}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final TextEditingController _controller = TextEditingController(text: currentTitle);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Edit Playlist'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _controller,
              decoration: const InputDecoration(
                labelText: 'Playlist Title',
              ),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                Navigator.pop(context, _controller.text);
              },
              child: const Text('Save'),
            ),
          ],
        ),
      ),
    );
  }
}