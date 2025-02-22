import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tp1/models/media.dart';
import 'package:tp1/main.dart'; 

class MediaDetailPage extends StatelessWidget {
  final Media media;

  const MediaDetailPage({Key? key, required this.media}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var appState = Provider.of<MyAppState>(context);
    bool isFavorite = appState.isFavorite(media);

    return Scaffold(
      appBar: AppBar(
        title: Text(media.title),
        backgroundColor: Theme.of(context).colorScheme.primaryContainer,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView(
          children: [
            AspectRatio(
              aspectRatio: 2 / 3,
              child: Image.asset(
                media.imageUrl,
                width: double.infinity,
                fit: BoxFit.contain,
              ),
            ),
            const SizedBox(height: 20),
            
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Text(
                    media.title,
                    style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                  ),
                ),
                ElevatedButton.icon(
                  onPressed: () {
                    appState.toggleFavorite(media);
                  },
                  icon: Icon(isFavorite ? Icons.favorite : Icons.favorite_border),
                  label: Text(isFavorite ? 'Unlike' : 'Like'),
                ),
              ],
            ),
            const SizedBox(height: 10),
            Text(
              "Genre: ${media.genre}",
              style: TextStyle(fontSize: 18, color: Colors.grey),
            ),
            const SizedBox(height: 10),
            Text(
              "Durée: ${media.duration}",
              style: TextStyle(fontSize: 18, color: Colors.grey),
            ),
            const SizedBox(height: 10),
            Text(
              "Date de sortie: ${media.releaseDate}",
              style: TextStyle(fontSize: 18, color: Colors.grey),
            ),
            const SizedBox(height: 10),
            Text(
              "Réalisateur: ${media.director}",
              style: TextStyle(fontSize: 18, color: Colors.grey),
            ),
            const SizedBox(height: 20),
            Text(
              media.description,
              style: TextStyle(fontSize: 16, color: Colors.black87),
            ),
          ],
        ),
      ),
    );
  }
}
