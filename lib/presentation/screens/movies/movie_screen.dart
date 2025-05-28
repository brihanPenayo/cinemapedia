import 'package:cinemapedia/domain/entities/movies.dart';
import 'package:cinemapedia/presentation/providers/movies/movie_detail_provider.dart';
import 'package:cinemapedia/presentation/widgets/shared/full_screen_loader.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class MovieScreen extends ConsumerStatefulWidget {
  static const routeName = 'movie-screen';
  final String movieID;

  const MovieScreen({super.key, required this.movieID});

  @override
  ConsumerState<MovieScreen> createState() => _MovieScreenState();
}

class _MovieScreenState extends ConsumerState<MovieScreen> {
  @override
  void initState() {
    super.initState();
    ref.read(movieDetailProvider.notifier).loadMovie(widget.movieID);
  }

  @override
  Widget build(BuildContext context) {
    final Movie? movie = ref.watch(movieDetailProvider)[widget.movieID];

    if (movie == null) {
      return const Scaffold(body: Center(child: CircularProgressIndicator()));
    }
    return Scaffold(
      appBar: AppBar(
        title: Text('Movie ID: ${movie.originalTitle}'),
      ),
    );
  }
}
