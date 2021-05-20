import 'package:flutter/material.dart';
import 'package:flutter_app/screens/movie_details/movie_detail.dart';
import 'package:flutter_app/screens/movies/movies.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Movies',
      onGenerateRoute: (RouteSettings settings) {
        if (settings.name == MovieDetail.routeName) {
          final args = settings.arguments as MovieDetailArgs;
          return MaterialPageRoute(builder: (context) {
            return MovieDetail(args.movie);
          });
        }
        return null;
      },
      theme: ThemeData.dark(),
      home: Movies(),
    );
  }
}
