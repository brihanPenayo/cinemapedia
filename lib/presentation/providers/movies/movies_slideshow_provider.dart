import 'package:cinemapedia/domain/entities/movies.dart';
import 'package:cinemapedia/presentation/providers/movies/movies_providers.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final moviesSlideshowProvider = Provider<List<Movie>>((ref) {
  final nowPlaying = ref.watch(nowPlayingMoviesProvider);
  if (nowPlaying.isEmpty) return [];
  return nowPlaying.sublist(0, 6);
});
