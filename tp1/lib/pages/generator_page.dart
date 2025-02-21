import 'package:flutter/material.dart';
import '../widgets/big_card.dart';
import 'package:provider/provider.dart';
import '../main.dart';
import '../models/media.dart';
import '../services/media_service.dart';

class GeneratorPage extends StatefulWidget {
  @override
  _GeneratorPageState createState() => _GeneratorPageState();
}

class _GeneratorPageState extends State<GeneratorPage> {
  Media? randomMedia;

  @override
  void initState() {
    super.initState();
    _loadRandomMedia();
  }

  // Charger un média aléatoire
  Future<void> _loadRandomMedia() async {
    var mediaList = await MediaService().loadMediaData();
    mediaList.shuffle(); // Mélange aléatoire
    setState(() {
      randomMedia = mediaList.first; // Prendre un média au hasard
    });
  }

  @override
  Widget build(BuildContext context) {
    var appState = context.watch<MyAppState>();

    if (randomMedia == null) {
      return Center(child: CircularProgressIndicator());
    }

    bool isFavorite = appState.isFavorite(randomMedia!);

    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          BigCard(media: randomMedia!), // Affiche les infos du média
          SizedBox(height: 10),
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              ElevatedButton.icon(
                onPressed: () {
                  appState.toggleFavorite(randomMedia!); // Gérer les favoris
                },
                icon: Icon(isFavorite ? Icons.favorite : Icons.favorite_border),
                label: Text('Like'),
              ),
              SizedBox(width: 10),
              ElevatedButton(
                onPressed: () {
                  _loadRandomMedia(); // Charger un autre média
                },
                child: Text('Next'),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
