class Media {
  final String title;
  final String imageUrl;
  final String genre;
  final String duration;
  final String releaseDate;
  final String director;
  final String type;
  final String description;

  Media({
    required this.title,
    required this.imageUrl,
    required this.genre,
    required this.duration,
    required this.releaseDate,
    required this.director,
    required this.type,
    required this.description,
  });

  // Méthode pour convertir le JSON en un objet Media
  factory Media.fromJson(Map<String, dynamic> json) {
    return Media(
      title: json['title'],
      imageUrl: json['imageUrl'],
      genre: json['genre'],
      duration: json['duration'],
      releaseDate: json['releaseDate'],
      director: json['director'],
      type: json['type'],
      description: json['description'],
    );
  }

  // Méthode pour convertir un objet Media en JSON
  Map<String, dynamic> toJson() {
    return {
      'title': title,
      'imageUrl': imageUrl,
      'genre': genre,
      'duration': duration,
      'releaseDate': releaseDate,
      'director': director,
      'type': type,
      'description': description,
    };
  }
}