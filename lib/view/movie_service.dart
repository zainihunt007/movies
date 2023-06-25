import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../data.dart';
import 'favourite_movies.dart';
import '../model/movie.dart';

class MoviesService extends StatefulWidget {
  @override
  _MoviesServiceState createState() => _MoviesServiceState();
}

class _MoviesServiceState extends State<MoviesService> {
  late List<Movie> movies = [];
  late SharedPreferences _prefs;
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    initializeMovies();
  }

  Future<void> initializeMovies() async {
    setState(() {
      isLoading = true;
    });

    movies = await fetchMovies();
    _prefs = await SharedPreferences.getInstance();
    for (var movie in movies) {
      bool isFavorite = _prefs.getBool(movie.id.toString()) ?? false;
      movie.isFavorite = isFavorite;
    }

    setState(() {
      isLoading = false;
    });
  }

  Future<void> toggleFavorite(Movie movie) async {
    setState(() {
      movie.isFavorite = !movie.isFavorite;
    });

    await _prefs.setBool(movie.id.toString(), movie.isFavorite);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Movie List'),
      ),
      body: isLoading
          ? const Center(
        child: CircularProgressIndicator(),
      )
          : GridView.builder(
        itemCount: movies.length,
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          childAspectRatio: 0.7,
        ),
        itemBuilder: (context, index) {
          final movie = movies[index];
          return Card(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Expanded(
                  child: Image.network(
                    movie.poster_path,
                    fit: BoxFit.cover,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    movie.title,
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
                IconButton(
                  icon: Icon(
                    movie.isFavorite ? Icons.favorite : Icons.favorite_border,
                    color: Colors.red,
                  ),
                  onPressed: () => toggleFavorite(movie),
                ),
              ],
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.favorite),
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => FavoriteMoviesList(movies: movies),
            ),
          );
        },
      ),
    );
  }
}
