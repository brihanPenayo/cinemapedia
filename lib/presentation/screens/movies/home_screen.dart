import 'package:cinemapedia/presentation/providers/movies/movies_providers.dart';
import 'package:cinemapedia/presentation/widgets/shared/custom_appbar.dart';
import 'package:cinemapedia/presentation/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class HomeScreen extends StatelessWidget {
  static const routeName = 'home-screen';
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: _HomeView(),
    );
  }
}

class _HomeView extends ConsumerStatefulWidget {
  const _HomeView();

  @override
  _HomeViewState createState() => _HomeViewState();
}

class _HomeViewState extends ConsumerState<_HomeView> {
  bool _isLoadMore = false; // Flag to track loading state

  @override
  void initState() {
    super.initState();
    ref.read(nowPlayingMoviesProvider.notifier).loadNextPage();
  }

  // Function to load next page, managing the loading state
  Future<void> loadNextPage() async {
    if (_isLoadMore) return; // Prevent concurrent loads

    setState(() {
      _isLoadMore = true;
    });

    // Assuming loadNextPage returns a Future
    await ref.read(nowPlayingMoviesProvider.notifier).loadNextPage();

    // Check if the widget is still mounted before calling setState
    if (mounted) {
      setState(() {
        _isLoadMore = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final nowPlayingMovies = ref.watch(nowPlayingMoviesProvider);

    return Column(children: [
      const CustomAppbar(),
      MoviesSlideshow(movies: nowPlayingMovies)
    ]);
  }
}
