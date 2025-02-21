import 'package:flutter/material.dart';
import '../models/media.dart';

class BigCard extends StatelessWidget {
  final Media media;

  const BigCard({Key? key, required this.media}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 8, // Ombre pour donner du relief
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      margin: const EdgeInsets.all(16),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
            child: Image.asset(
              media.imageUrl,
              height: 250, // Taille plus grande pour l'affiche
              fit: BoxFit.cover, // Remplir sans déformer
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  media.title,
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 8),
                Text(
                  'Genre: ${media.genre}',
                  style: TextStyle(fontSize: 16, color: Colors.grey[700]),
                ),
                SizedBox(height: 8),
                Text(
                  'Durée: ${media.duration} • Sortie: ${media.releaseDate}',
                  style: TextStyle(fontSize: 14, color: Colors.grey[600]),
                ),
                SizedBox(height: 8),
                Text(
                  'Réalisateur: ${media.director}',
                  style: TextStyle(fontSize: 14, color: Colors.grey[600]),
                ),
                SizedBox(height: 12),
                Text(
                  media.description,
                  style: TextStyle(fontSize: 14),
                  textAlign: TextAlign.justify,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
