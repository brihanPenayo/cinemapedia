import 'package:cinemapedia/config/constants/environment.dart';
import 'package:cinemapedia/domain/datasources/movies_datasource.dart';
import 'package:cinemapedia/domain/entities/movies.dart';
import 'package:cinemapedia/infrastructure/mappers/movie_mapper.dart';
import 'package:cinemapedia/infrastructure/models/movieDB/moviedb_response.dart';
import 'package:dio/dio.dart';

class MoviedbDatasource extends MoviesDatasource {
  final dio = Dio(BaseOptions(
      baseUrl: 'https://api.themoviedb.org/3',
      queryParameters: {
        'api_key': Environment.movieDBApiKey,
        'language': 'es-MX'
      }));
  @override
  Future<List<Movie>> getNowPlayingMovies({int page = 1}) async {
    final response =
        await dio.get('/movie/now_playing', queryParameters: {'page': page});
    final movieDBresponse = MovieDbResponse.fromJson(response.data);
    final List<Movie> movies = movieDBresponse.results
        .map((movieDB) => MovieMapper.movieDBtoEntity(movieDB))
        .toList();
    return movies;
  }
}
