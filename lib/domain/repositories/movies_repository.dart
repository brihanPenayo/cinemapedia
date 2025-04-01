import 'package:cinemapedia/domain/entities/movies.dart';

abstract class MoviesRepository {
  Future<List<Movie>> getNowPlayingMovies({int page = 1});
}
