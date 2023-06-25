import 'dart:convert';
import 'model/movie.dart';
import 'package:http/http.dart' as http;

Future<List<Movie>> fetchMovies() async {
  final response = await http.get(
    Uri.parse('https://api.themoviedb.org/3/movie/11?api_key=9864dfc0ef080f27368f087381c85a94'),
  );
  if (response.statusCode == 200) {
    final data = json.decode(response.body);
    List<Movie> fetchedMovies = [];
    Movie movie = Movie(
      id: data['id'],
      title: data['title'],
      releaseDate: DateTime.parse(data['release_date']),
      overview: data['overview'],
      poster_path: 'https://image.tmdb.org/t/p/w500${data['poster_path']}',
      isFavorite: false,
    );
    fetchedMovies.add(movie);
    return fetchedMovies;
  } else {
    throw Exception('Failed to fetch movies');
  }
}
