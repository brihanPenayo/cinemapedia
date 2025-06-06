import 'package:cinemapedia/config/constants/environment.dart';
import 'package:cinemapedia/domain/datasources/movies_datasource.dart';
import 'package:cinemapedia/domain/entities/movies.dart';
import 'package:cinemapedia/infrastructure/mappers/movie_mapper.dart';
import 'package:cinemapedia/infrastructure/models/movieDB/movie_details.dart';
import 'package:cinemapedia/infrastructure/models/movieDB/moviedb_response.dart';
import 'package:dio/dio.dart';

class MoviedbDatasource extends MoviesDatasource {
  final dio = Dio(BaseOptions(
      baseUrl: 'https://api.themoviedb.org/3',
      queryParameters: {
        'api_key': Environment.movieDBApiKey,
        'language': 'es-MX'
      }));

  List<Movie> _jsonToMovies(Map<String, dynamic> json) {
    final movieDBresponse = MovieDbResponse.fromJson(json);
    final List<Movie> movies = movieDBresponse.results
        .map((movieDB) => MovieMapper.movieDBtoEntity(movieDB))
        .toList();
    return movies;
  }

  @override
  Future<List<Movie>> getNowPlayingMovies({int page = 1}) async {
    final response =
        await dio.get('/movie/now_playing', queryParameters: {'page': page});
    return _jsonToMovies(response.data);
  }

  @override
  Future<List<Movie>> getPopularMovies({int page = 1}) async {
    final response =
        await dio.get('/movie/popular', queryParameters: {'page': page});
    return _jsonToMovies(response.data);
  }

  @override
  Future<List<Movie>> getTopRatedMovies({int page = 1}) async {
    final res =
        await dio.get('/movie/top_rated', queryParameters: {'page': page});
    return _jsonToMovies(res.data);
  }

  @override
  Future<List<Movie>> getUpcomingMovies({int page = 1}) async {
    final res =
        await dio.get('/movie/upcoming', queryParameters: {'page': page});
    return _jsonToMovies(res.data);
  }

  @override
  Future<Movie> getMovieById(String id) async {
    final response = await dio.get('/movie/$id');
    if (response.statusCode != 200) {
      throw Exception('Movie not found');
    }
    final movieDetails = MovieDetails.fromJson(response.data);
    final Movie movie = MovieMapper.movieDetailsToEntity(movieDetails);
    return movie;
  }
}
