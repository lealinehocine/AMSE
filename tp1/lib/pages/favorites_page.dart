import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tp1/pages/media_detail_page.dart';
import '../main.dart';
import '../models/media.dart';

class FavoritesPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var appState = context.watch<MyAppState>();

    if (appState.favorites.isEmpty) {
      return Center(
        child: Text('Pas encore de favori'),
      );
    }

    return ListView.builder(
      itemCount: appState.favorites.length,
      itemBuilder: (context, index) {
        var media = appState.favorites[index];
        bool isFavorite = appState.isFavorite(media);

        return Card(
          margin: const EdgeInsets.all(10),
          child: ListTile(
            contentPadding: const EdgeInsets.all(10),
            leading: Image.asset(
              media.imageUrl,
              width: 100, // Taille plus grande des affiches
              height: 150,
              fit: BoxFit.cover,
            ),
            title: Text(media.title),
            subtitle: Text(media.genre),
            trailing: ElevatedButton.icon(
              onPressed: () {
                appState.toggleFavorite(media); // Enlever des favoris
              },
              icon: Icon(isFavorite ? Icons.favorite : Icons.favorite_border),
              label: Text('Unlike'),
            ),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => MediaDetailPage(media: media),
                ),
              );
            },
          ),
        );
      },
    );
  }
}
