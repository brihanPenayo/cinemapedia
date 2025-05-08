import 'package:cinemapedia/domain/entities/movies.dart';
import 'package:cinemapedia/presentation/providers/providers.dart';
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
      bottomNavigationBar: CustomBottomNavigationBar(),
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
    ref.read(popularMoviesProvider.notifier).loadNextPage();
    ref.read(topRatedMoviesProvider.notifier).loadNextPage();
    ref.read(upcomingMoviesProvider.notifier).loadNextPage();
  }

  // Function to load next page, managing the loading state
  Future<void> loadNextPage() async {
    if (_isLoadMore) return; // Prevent concurrent loads

    setState(() {
      _isLoadMore = true;
    });

    // Assuming loadNextPage returns a Future
    await ref.read(nowPlayingMoviesProvider.notifier).loadNextPage();
    await ref.read(popularMoviesProvider.notifier).loadNextPage();
    await ref.read(upcomingMoviesProvider.notifier).loadNextPage();
    await ref.read(topRatedMoviesProvider.notifier).loadNextPage();

    // Check if the widget is still mounted before calling setState
    if (mounted) {
      setState(() {
        _isLoadMore = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final isLoading = ref.watch(initialLoadingProvider);

    if (isLoading) return const FullScreenLoader();

    final slideShowMovies = ref.watch(moviesSlideshowProvider);
    final nowPlayingMovies = ref.watch(nowPlayingMoviesProvider);
    final popularMovies = ref.watch(popularMoviesProvider);
    final topRatedMovies = ref.watch(topRatedMoviesProvider);
    final upcomingMovies = ref.watch(upcomingMoviesProvider);

    return _CustomScrollView(
        slideShowMovies: slideShowMovies,
        upcomingMovies: upcomingMovies,
        ref: ref,
        nowPlayingMovies: nowPlayingMovies,
        popularMovies: popularMovies,
        topRatedMovies: topRatedMovies);
  }
}

class _CustomScrollView extends StatelessWidget {
  const _CustomScrollView({
    required this.slideShowMovies,
    required this.upcomingMovies,
    required this.ref,
    required this.nowPlayingMovies,
    required this.popularMovies,
    required this.topRatedMovies,
  });

  final List<Movie> slideShowMovies;
  final List<Movie> upcomingMovies;
  final WidgetRef ref;
  final List<Movie> nowPlayingMovies;
  final List<Movie> popularMovies;
  final List<Movie> topRatedMovies;

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      slivers: [
        const SliverAppBar(
          floating: true,
          flexibleSpace: FlexibleSpaceBar(
            centerTitle: true,
            title: CustomAppbar(),
          ),
        ),
        SliverList(
          delegate: SliverChildBuilderDelegate(
              (context, index) => Column(children: [
                    MoviesSlideshow(movies: slideShowMovies),
                    MovieHorizontalListview(
                      movies: upcomingMovies,
                      title: 'Upcoming',
                      date: '2025',
                      onMore: () => ref
                          .read(upcomingMoviesProvider.notifier)
                          .loadNextPage(),
                    ),
                    MovieHorizontalListview(
                      movies: nowPlayingMovies,
                      title: 'Now Playing',
                      // date: '2025',
                      onMore: () => ref
                          .read(nowPlayingMoviesProvider.notifier)
                          .loadNextPage(),
                    ),
                    MovieHorizontalListview(
                      movies: popularMovies,
                      title: 'Popular',
                      // date: '2025',
                      onMore: () => ref
                          .read(popularMoviesProvider.notifier)
                          .loadNextPage(),
                    ),
                    MovieHorizontalListview(
                      movies: topRatedMovies,
                      title: 'Top Rated',
                      onMore: () => ref
                          .read(topRatedMoviesProvider.notifier)
                          .loadNextPage(),
                    ),
                  ]),
              childCount: 1),
        )
      ],
    );
  }
}
