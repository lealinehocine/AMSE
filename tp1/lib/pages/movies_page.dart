import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tp1/models/media.dart';
import 'package:tp1/services/media_service.dart';
import 'package:tp1/main.dart';
import 'package:tp1/pages/media_detail_page.dart';

class MoviesPage extends StatefulWidget {
  @override
  _MoviesPageState createState() => _MoviesPageState();
}

class _MoviesPageState extends State<MoviesPage> {
  String selectedGenre = 'Tout';
  List<String> genres = ['Tout'];

  @override
  void initState() {
    super.initState();
  }

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
          List<Media> movies = snapshot.data!
              .where((media) => media.type == 'movie')
              .toList();

          // Extraire les genres uniques à partir des films
          Set<String> genreSet = Set.from(movies.map((movie) => movie.genre));

          // Ajouter les genres à la liste genres seulement une fois
          if (genres.length == 1) {
            genres.addAll(genreSet);
          }

          // Appliquer le filtre
          List<Media> filteredMovies = selectedGenre == 'Tout'
              ? movies
              : movies.where((movie) => movie.genre == selectedGenre).toList();

          return Column(
            children: [
              // Affichage horizontal des genres
              Container(
                height: 60,  // Fixe une hauteur pour les genres
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
                  itemCount: filteredMovies.length,
                  itemBuilder: (context, index) {
                    var movie = filteredMovies[index];
                    var appState = Provider.of<MyAppState>(context);
                    bool isFavorite = appState.isFavorite(movie);

                    return Card(
                      margin: const EdgeInsets.all(10),
                      child: ListTile(
                        leading: Image.asset(movie.imageUrl, width: 50, height: 75),
                        title: Text(movie.title),
                        subtitle: Text(movie.genre),
                        trailing: IconButton(
                          icon: Icon(
                            isFavorite ? Icons.favorite : Icons.favorite_border,
                          ),
                          onPressed: () {
                            appState.toggleFavorite(movie);
                          },
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
                ),
              ),
            ],
          );
        } else {
          return Center(child: Text('Aucun film trouvé'));
        }
      },
    );
  }
}
