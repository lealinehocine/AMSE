# tp1

Médiathèque de films et séries faite par Léa-Line SAAD.

## Description

La Médiathèque est une application permettant de gérer et visualiser une collection de films et séries favoris. Elle offre la possibilité de consulter des informations détaillées sur chaque média, telles que : le titre du film ou de la série, son affiche, son genre, sa durée ou la durée moyenne d'un épisode, sa date de sortie, son réalisateur et une description succincte du scénario. 
Les utilisateurs peuvent également organiser les médias par catégorie (films et séries) et filtrer par genre.

## Fonctionnalités

Affichage d'une liste de films et de séries.
Informations détaillées pour chaque média, incluant :
- Titre
- Image de couverture
- Genre
- Durée
- Date de sortie
- Réalisateur
- Description

Catégorisation des médias en Films et Séries et possibilité de les filtrer par genre.

Page regroupant les favoris dans chaque catégorie.

Affichage du nombre de films et séries préférés sur la page d'accueil.


## Structure du projet

Pas d'API utilisée : la base de films et séries est disponible au format JSON dans le dossier assets/data.
Les données sont exploitées grâce aux classes définies dans le dossier models et aux services dans services.

Chaque page affichée dans l'application est liée à un fichier spécifique de code :
- home_page.dart : Page d'accueil.
- movies_page.dart : Affiche tous les films.
- series_page.dart : Affiche toutes les séries
- media_detail_page.dart  : Affiche les détails d'un film ou d'une série.
- favorites_page.dart : Page des favoris.


## Installation

Etapes d'installation et d'exécution:

``` bash
git clone https://github.com/lealinehocine/AMSE.git

cd AMSE tp1

flutter create .

flutter run
```