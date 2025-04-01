import 'package:cinemapedia/domain/entities/movies.dart';

abstract class MoviesDatasource {
  Future<List<Movie>> getNowPlayingMovies({int page = 1});
}
