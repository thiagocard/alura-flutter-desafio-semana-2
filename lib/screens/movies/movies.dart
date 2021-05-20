import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_app/repository/model/movie.dart';

import '../movie_details/movie_detail.dart';
import 'movies_viewmodel.dart';

class MoviesState extends State<Movies> {
  final MoviesViewModel _vm = MoviesViewModel();
  StreamSubscription<List<Movie>> _subscription;
  List<Movie> _movies = [];

  @override
  void initState() {
    super.initState();
    _vm.getPopularMovies();
    _subscription = _vm.movies.listen((event) {
      setState(() {
        _movies = event;
      });
    });
  }

  @override
  void dispose() {
    super.dispose();
    _subscription.cancel();
    _vm.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Movies'),
        ),
        body: ListView.builder(
          itemBuilder: (context, index) => MovieItem(_movies[index]),
          itemCount: _movies != null ? _movies.length : 0,
        ));
  }
}

class Movies extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return MoviesState();
  }
}

class MovieItem extends StatelessWidget {
  final Movie movie;

  MovieItem(this.movie);

  @override
  Widget build(BuildContext context) {
    return Card(
      child: InkWell(
        onTap: () => Navigator.pushNamed(context, MovieDetail.routeName,
            arguments: MovieDetailArgs(movie)),
        child: Row(
          children: [
            Expanded(
              flex: 1,
              child: Image.network(movie.poster, fit: BoxFit.fitHeight),
            ),
            Expanded(
              flex: 5,
              child: Row(
                children: [
                  Expanded(
                    flex: 5,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        movie.title,
                        style: TextStyle(fontSize: 12),
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 1,
                    child: Icon(
                      movie.isFavorite
                          ? Icons.favorite
                          : Icons.favorite_border_outlined,
                      size: 24,
                      color: movie.isFavorite ? Colors.red : Colors.white,
                    ),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
