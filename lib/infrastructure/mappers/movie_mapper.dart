import 'package:cinemapedia/domain/entities/movies.dart';
import 'package:cinemapedia/infrastructure/models/movieDB/movie_moviedb.dart';

class MovieMapper {
  static Movie movieDBtoEntity(MovieFromMovieDB movieFromMovieDB) => Movie(
        adult: movieFromMovieDB.adult,
        backdropPath: movieFromMovieDB.backdropPath != ''
            ? 'https://image.tmdb.org/t/p/w500${movieFromMovieDB.backdropPath}'
            : 'https://static.vecteezy.com/system/resources/previews/004/639/366/non_2x/error-404-not-found-text-design-vector.jpg',
        genreIds: movieFromMovieDB.genreIds.map((id) => id.toString()).toList(),
        id: movieFromMovieDB.id,
        originalLanguage: movieFromMovieDB.originalLanguage,
        originalTitle: movieFromMovieDB.originalTitle,
        overview: movieFromMovieDB.overview,
        popularity: movieFromMovieDB.popularity,
        posterPath: movieFromMovieDB.posterPath != ''
            ? 'https://image.tmdb.org/t/p/w500${movieFromMovieDB.posterPath}'
            : 'https://linnea.com.ar/wp-content/uploads/2018/09/404PosterNotFound.jpg',
        releaseDate: movieFromMovieDB.releaseDate,
        title: movieFromMovieDB.title,
        video: movieFromMovieDB.video,
        voteAverage: movieFromMovieDB.voteAverage,
        voteCount: movieFromMovieDB.voteCount,
      );
}
