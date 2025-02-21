import 'package:flutter/material.dart';
import 'package:tp1/models/media.dart';  // Le modèle de données pour accéder aux films et séries

class MediaDetailPage extends StatelessWidget {
  final Media media;  // On reçoit l'objet Media (Film ou Série)

  const MediaDetailPage({Key? key, required this.media}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(media.title),  // Le titre du film ou de la série
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView(
          children: [
            // Afficher l'image en haut
            Image.asset(
              media.imageUrl,
              width: double.infinity,
              height: 250,  // Ajuste la taille à ton goût
              fit: BoxFit.cover,
            ),
            const SizedBox(height: 20),
            // Le titre du film ou de la série
            Text(
              media.title,
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),  // Style personnalisé
            ),
            const SizedBox(height: 10),
            // Le genre
            Text(
              "Genre: ${media.genre}",
              style: TextStyle(fontSize: 16, color: Colors.grey),  // Style personnalisé
            ),
            const SizedBox(height: 10),
            // La durée
            Text(
              "Durée: ${media.duration}",
              style: TextStyle(fontSize: 16, color: Colors.grey),  // Style personnalisé
            ),
            const SizedBox(height: 10),
            // La date de sortie
            Text(
              "Date de sortie: ${media.releaseDate}",
              style: TextStyle(fontSize: 16, color: Colors.grey),  // Style personnalisé
            ),
            const SizedBox(height: 10),
            // Le réalisateur
            Text(
              "Réalisateur: ${media.director}",
              style: TextStyle(fontSize: 16, color: Colors.grey),  // Style personnalisé
            ),
            const SizedBox(height: 20),
            // La description
            Text(
              media.description,
              style: TextStyle(fontSize: 14, color: Colors.black87),  // Style personnalisé
            ),
          ],
        ),
      ),
    );
  }
}
