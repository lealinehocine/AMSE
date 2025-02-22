import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tp1/models/media.dart';
import 'package:tp1/main.dart';
import 'package:tp1/pages/media_detail_page.dart';

class FavoritesPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var appState = Provider.of<MyAppState>(context);
    
    // Définir les filtres (Todo, Film, Serie)
    List<String> filters = ['Tout', 'Films', 'Séries'];

    return DefaultTabController(
      length: filters.length,  // On a 3 onglets
      child: Scaffold(
        backgroundColor: Theme.of(context).colorScheme.background,  // Utilise la couleur de fond définie dans le thème
        appBar: AppBar(
          bottom: TabBar(
            tabs: filters.map((filter) {
              return Tab(
                text: filter,
              );
            }).toList(),
            labelColor: Colors.black,  // Mets les textes des onglets en noir
            unselectedLabelColor: Colors.black, // Mets les textes non sélectionnés en noir aussi
            indicatorColor: Theme.of(context).colorScheme.primary,  // Couleur de l'indicateur
          ),
          backgroundColor: Theme.of(context).colorScheme.primary,  // Couleur de fond de l'AppBar
        ),
        body: TabBarView(
          children: [
            // Onglet "Tout" : Affiche tous les favoris
            FavoriteList(filter: 'all'),
            // Onglet "Film" : Affiche seulement les favoris de type "movie"
            FavoriteList(filter: 'movie'),
            // Onglet "Série" : Affiche seulement les favoris de type "series"
            FavoriteList(filter: 'series'),
          ],
        ),
      ),
    );
  }
}

class FavoriteList extends StatelessWidget {
  final String filter;
  
  // Constructeur
  FavoriteList({required this.filter});

  @override
  Widget build(BuildContext context) {
    var appState = Provider.of<MyAppState>(context);
    
    // Filtrer les favoris en fonction du type sélectionné
    List<Media> filteredFavorites = filter == 'all'
        ? appState.favorites
        : appState.favorites.where((media) => media.type == filter).toList();

    return filteredFavorites.isEmpty
        ? Center(child: Text('Aucun favori trouvé.'))
        : ListView.builder(
            itemCount: filteredFavorites.length,
            itemBuilder: (context, index) {
              var media = filteredFavorites[index];
              bool isFavorite = appState.isFavorite(media);

              return Card(
                margin: const EdgeInsets.all(10),
                child: ListTile(
                  leading: Image.asset(media.imageUrl, width: 50, height: 75),
                  title: Text(media.title),
                  subtitle: Text(media.genre),
                  trailing: IconButton(
                    icon: Icon(
                      isFavorite ? Icons.favorite : Icons.favorite_border,
                      color: isFavorite ? Theme.of(context).colorScheme.secondary : null, // Icône rouge si favori
                    ),
                    onPressed: () {
                      appState.toggleFavorite(media);  // Basculer l'état favori
                    },
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
