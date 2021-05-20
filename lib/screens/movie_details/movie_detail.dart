import 'package:flutter/material.dart';
import 'package:flutter_app/repository/model/movie.dart';
import 'package:flutter_app/screens/movie_details/movie_detail_viewmodel.dart';

class MovieDetailArgs {
  final Movie movie;

  MovieDetailArgs(this.movie);
}

class MovieDetail extends StatefulWidget {
  static final String routeName = "/movie-detail";

  final Movie _movie;

  MovieDetail(this._movie);

  @override
  State<StatefulWidget> createState() {
    return MovieDetailState(_movie);
  }
}

class MovieDetailState extends State<MovieDetail> {
  final Movie _movie;
  final _vm = MovieDetailViewModel();

  MovieDetailState(this._movie);

  @override
  void initState() {
    super.initState();
    _vm.setMovieId(_movie.id);
  }

  @override
  void dispose() {
    super.dispose();
    _vm.dispose();
  }

  Widget favIcon() {
    return StreamBuilder(
      stream: _vm.isFavorite,
      initialData: false,
      builder: (context, snapshot) {
        bool isFavorite = snapshot.data;
        return isFavorite
            ? Icon(
          Icons.favorite,
          size: 24.0,
          color: Colors.red,
        )
            : Icon(
          Icons.favorite_border_outlined,
          size: 24.0,
          color: Colors.white,
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: _movie.title,
      theme: ThemeData.dark(),
      home: Scaffold(
        body: SingleChildScrollView(
          child: Column(
            children: [
              Stack(
                children: [
                  Image.network(
                    _movie.backdrop,
                    height: 240,
                    fit: BoxFit.cover,
                  ),
                  Positioned.fill(
                    bottom: 16,
                    left: 16,
                    child: Align(
                      alignment: Alignment.bottomLeft,
                      child: Text(
                        _movie.title,
                        style: TextStyle(color: Colors.white, fontSize: 22),
                      ),
                    ),
                  ),
                  Positioned.fill(
                    bottom: 16,
                    right: 16,
                    child: Align(
                      alignment: Alignment.bottomRight,
                      child: InkWell(
                        splashColor: Colors.red,
                        customBorder: CircleBorder(),
                        child: favIcon(),
                        onTap: () {
                          _vm.addOrRemoveToFavorites(_movie.id);
                        },
                      ),
                    ),
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Text(
                  _movie.overview,
                  style: TextStyle(height: 1.4),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}


