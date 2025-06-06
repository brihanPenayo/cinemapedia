import 'package:cinemapedia/domain/entities/movies.dart';

abstract class MoviesDatasource {
  Future<List<Movie>> getNowPlayingMovies({int page = 1});
  Future<List<Movie>> getPopularMovies({int page = 1});
  Future<List<Movie>> getTopRatedMovies({int page = 1});
  Future<List<Movie>> getUpcomingMovies({int page = 1});
  Future<Movie> getMovieById(String id);
}
