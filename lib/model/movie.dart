class Movie {
  final String title;
  final DateTime releaseDate;
  final String overview;
  final String poster_path;
  bool isFavorite;
  final int id;

  Movie({
    required this.id,
    required this.title,
    required this.releaseDate,
    required this.overview,
    required this.poster_path,
    this.isFavorite = false,
  });
}