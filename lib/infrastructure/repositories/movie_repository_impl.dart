import 'package:cinemapedia/domain/entities/movies.dart';
import 'package:cinemapedia/domain/repositories/movies_repository.dart';
import 'package:cinemapedia/infrastructure/datasources/moviedb_datasource.dart';

class MovieRepositoryImpl extends MoviesRepository {
  final MoviedbDatasource dataSource;
  MovieRepositoryImpl({required this.dataSource});
  @override
  Future<List<Movie>> getNowPlayingMovies({int page = 1}) async {
    return dataSource.getNowPlayingMovies(page: page);
  }
}
