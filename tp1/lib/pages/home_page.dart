import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tp1/main.dart';  // Assure-toi que MyAppState est importé ici

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // Accéder à l'instance de MyAppState via Provider
    var appState = Provider.of<MyAppState>(context); 

    // Compter les films et les séries favoris
    int favoriteMovies = appState.favorites.where((media) => media.type == 'movie').toList().length;
    int favoriteSeries = appState.favorites.where((media) => media.type == 'series').toList().length;

    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.primaryContainer,  
      appBar: AppBar(
        title: Text('Accueil'),
        backgroundColor: Theme.of(context).colorScheme.primary,  
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Bienvenue dans la Médiathèque!',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 20),
            Text(
              'Découvrez vos films et séries préférés.',
              style: TextStyle(fontSize: 18),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 20),  
            Image.asset(
              '../../assets/images/image_accueil.png',  // Utilise le bon chemin relatif
              width: 200,  
              height: 200,
            ),
            SizedBox(height: 20),
            
            Text(
              'Vous avez $favoriteMovies films préférés et $favoriteSeries séries préférées.',
              style: TextStyle(fontSize: 16),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}
