import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tp1/models/media.dart';
import 'package:tp1/services/media_service.dart';
import 'package:tp1/pages/media_detail_page.dart';
import 'package:tp1/main.dart'; // Import pour accéder à MyAppState

class SeriesPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<Media>>(
      future: MediaService().loadMediaData(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return Center(child: Text('Erreur de chargement des données.'));
        } else if (snapshot.hasData) {
          List<Media> movies = snapshot.data!.where((media) => media.type == 'series').toList();

          return ListView.builder(
            itemCount: movies.length,
            itemBuilder: (context, index) {
              var movie = movies[index];
              var appState = Provider.of<MyAppState>(context);
              bool isFavorite = appState.isFavorite(movie);

              return Card(
                margin: const EdgeInsets.all(10),
                child: ListTile(
                  contentPadding: const EdgeInsets.all(10),
                  leading: Image.asset(movie.imageUrl, width: 50, height: 75),
                  title: Text(movie.title),
                  subtitle: Text(movie.genre),
                  trailing: ElevatedButton.icon(
                    onPressed: () {
                      appState.toggleFavorite(movie); // Toggle le favori
                    },
                    icon: Icon(isFavorite ? Icons.favorite : Icons.favorite_border),
                    label: Text('Like'),
                  ),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => MediaDetailPage(media: movie),
                      ),
                    );
                  },
                ),
              );
            },
          );
        } else {
          return Center(child: Text('Aucun film trouvé.'));
        }
      },
    );
  }
}
