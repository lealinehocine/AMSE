import 'pages/home_page.dart';
import 'pages/movies_page.dart';
import 'pages/series_page.dart';
import 'pages/favorites_page.dart';
import 'models/media.dart'; 
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => MyAppState(),
      child: MaterialApp(
        title: 'Mediatheque',
        theme: ThemeData(
          useMaterial3: true,
          colorScheme: ColorScheme.fromSeed(seedColor: const Color.fromARGB(255, 191, 150, 220)),
        ),
        home: MyHomePage(),
      ),
    );
  }
}

class MyAppState extends ChangeNotifier {
List<Media> favorites = []; // Liste des favoris basée sur Media

  void toggleFavorite(Media media) {
    if (favorites.any((fav) => fav.title == media.title)) {
      favorites.removeWhere((fav) => fav.title == media.title);
    } else {
      favorites.add(media);
    }
    notifyListeners();
  }

  bool isFavorite(Media media) {
    return favorites.any((fav) => fav.title == media.title);
  }
}

class MyHomePage extends StatefulWidget {
  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  var selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    Widget page;
    switch (selectedIndex) {
      case 0:
        page = HomePage();
        break;
      case 1:
        page = MoviesPage();
        break;
      case 2:
        page = SeriesPage();
        break;
      case 3:
        page = FavoritesPage();
        break;
      default:
        throw UnimplementedError('no widget for $selectedIndex');
    }


    return Scaffold(
      body: Container(
        color: Theme.of(context).colorScheme.primaryContainer,
        child: page,
      ),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        currentIndex: selectedIndex,
        onTap: (value) {
          setState(() {
            selectedIndex = value;
          });
        },
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Accueil',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.movie),
            label: 'Films',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.tv),
            label: 'Séries',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.favorite),
            label: 'Favoris',
          ),
        ],
      ),
    );
      }
}
