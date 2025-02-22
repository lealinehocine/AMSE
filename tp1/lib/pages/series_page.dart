import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tp1/models/media.dart';
import 'package:tp1/services/media_service.dart';
import 'package:tp1/pages/media_detail_page.dart';
import 'package:tp1/main.dart'; 

class SeriesPage extends StatefulWidget {
  @override
  _SeriesPageState createState() => _SeriesPageState();
}

class _SeriesPageState extends State<SeriesPage> {
  String selectedGenre = 'Tout';
  List<String> genres = ['Tout'];

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
          List<Media> series = snapshot.data!.where((media) => media.type == 'series').toList();

          // Extraire les genres uniques
          Set<String> genreSet = Set.from(series.map((serie) => serie.genre));
          if (genres.length == 1) { 
            genres.addAll(genreSet);
          }

          // Appliquer le filtre
          List<Media> filteredSeries = selectedGenre == 'Tout'
              ? series
              : series.where((serie) => serie.genre == selectedGenre).toList();

          return Column(
            children: [
              // Affichage horizontal des genres
              Container(
                height: 60,  
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: genres.length,
                  itemBuilder: (context, index) {
                    String genre = genres[index];
                    return Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 4.0),
                      child: ChoiceChip(
                        label: Text(genre),
                        selected: selectedGenre == genre,
                        onSelected: (bool selected) {
                          setState(() {
                            selectedGenre = genre;
                          });
                        },
                      ),
                    );
                  },
                ),
              ),
              Expanded(
                child: ListView.builder(
                  itemCount: filteredSeries.length,
                  itemBuilder: (context, index) {
                    var serie = filteredSeries[index];
                    var appState = Provider.of<MyAppState>(context);
                    bool isFavorite = appState.isFavorite(serie);

                    return Card(
                      margin: const EdgeInsets.all(10),
                      child: ListTile(
                        contentPadding: const EdgeInsets.all(10),
                        leading: Image.asset(serie.imageUrl, width: 50, height: 75),
                        title: Text(serie.title),
                        subtitle: Text(serie.genre),
                        trailing: IconButton(
                          icon: Icon(
                            isFavorite ? Icons.favorite : Icons.favorite_border,
                          ),
                          onPressed: () {
                            appState.toggleFavorite(serie);
                          },
                        ),
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => MediaDetailPage(media: serie),
                            ),
                          );
                        },
                      ),
                    );
                  },
                ),
              ),
            ],
          );
        } else {
          return Center(child: Text('Aucune série trouvée'));
        }
      },
    );
  }
}
