import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tp1/models/media.dart';
import 'package:tp1/main.dart';
import 'package:tp1/pages/media_detail_page.dart';

class FavoritesPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    
    List<String> filters = ['Tout', 'Films', 'Séries'];

    return DefaultTabController(
      length: filters.length,  
      child: Scaffold(
        backgroundColor: Theme.of(context).colorScheme.primaryContainer,  // Utilise la couleur de fond définie dans le thème
        appBar: AppBar(
          bottom: TabBar(
            tabs: filters.map((filter) {
              return Tab(
                text: filter,
              );
            }).toList(),
            labelColor: Colors.black,  
            unselectedLabelColor: Colors.black, 
            indicatorColor: Theme.of(context).colorScheme.primary,  
          ),
          backgroundColor: Theme.of(context).colorScheme.primary,  
        ),
        body: TabBarView(
          children: [

            FavoriteList(filter: 'all'),
            FavoriteList(filter: 'movie'),
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
                      color: isFavorite ? Theme.of(context).colorScheme.secondary : null, 
                    ),
                    onPressed: () {
                      appState.toggleFavorite(media); 
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
