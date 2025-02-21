import 'dart:convert';
import 'package:flutter/services.dart';
import 'package:tp1/models/media.dart'; 

class MediaService {
  // Charge et parse le fichier JSON
  Future<List<Media>> loadMediaData() async {
    // Charger le fichier JSON depuis les assets
    String jsonString = await rootBundle.loadString('assets/data/media.json');
    
    // Convertir la chaîne JSON en une liste d'objets Media
    List<dynamic> jsonList = json.decode(jsonString);
    
    // Mapper chaque élément du JSON en objet Media
    return jsonList.map((json) => Media.fromJson(json)).toList();
  }
}
