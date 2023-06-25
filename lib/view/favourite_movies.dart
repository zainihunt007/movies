import 'package:flutter/material.dart';

import '../model/movie.dart';

class FavoriteMoviesList extends StatelessWidget {
  final List<Movie> movies;

  const FavoriteMoviesList({Key? key, required this.movies}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final favoriteMovies = movies.where((movie) => movie.isFavorite).toList();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Favorite Movies'),
      ),
      body: GridView.builder(
        itemCount: favoriteMovies.length,
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          childAspectRatio: 0.7,
        ),
        itemBuilder: (context, index) {
          final movie = favoriteMovies[index];
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
              ],
            ),
          );
        },
      ),
    );
  }
}