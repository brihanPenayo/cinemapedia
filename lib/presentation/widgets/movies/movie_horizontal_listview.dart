import 'package:animate_do/animate_do.dart';
import 'package:cinemapedia/config/helpers/human_formats.dart';
import 'package:cinemapedia/domain/entities/movies.dart';
import 'package:cinemapedia/presentation/screens/movies/movie_screen.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class MovieHorizontalListview extends StatefulWidget {
  final List<Movie> movies;
  final String? title;
  final String? date;
  final VoidCallback? onMore;
  const MovieHorizontalListview(
      {super.key, required this.movies, this.title, this.date, this.onMore});

  @override
  State<MovieHorizontalListview> createState() =>
      _MovieHorizontalListviewState();
}

class _MovieHorizontalListviewState extends State<MovieHorizontalListview> {
  final ScrollController _scrollController = ScrollController();
  @override
  void initState() {
    super.initState();
    _scrollController.addListener(() {
      if (widget.onMore == null) return;
      if ((_scrollController.position.pixels + 200) >=
          _scrollController.position.maxScrollExtent) {
        widget.onMore!();
      }
    });
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (widget.title != null || widget.date != null)
          _Title(title: widget.title, date: widget.date),
        SizedBox(
          height: 290,
          width: double.infinity,
          child: ListView.builder(
            controller: _scrollController,
            scrollDirection: Axis.horizontal,
            itemCount: widget.movies.length,
            physics: const BouncingScrollPhysics(),
            itemBuilder: (ctx, idx) {
              return FadeInRight(child: _Slide(movie: widget.movies[idx]));
            },
          ),
        ),
      ],
    );
  }
}

class _Slide extends StatelessWidget {
  final Movie movie;
  const _Slide({required this.movie});

  @override
  Widget build(BuildContext context) {
    final textStyle = Theme.of(context).textTheme;
    const width = 150.0;
    return GestureDetector(
      onTap: () {
        context.push('/movie/${movie.id}');
      },
      child: Container(
        width: width,
        margin: const EdgeInsets.only(left: 15),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              width: width,
              height: 225,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(20),
                child: Container(
                  decoration: const BoxDecoration(
                    color: Colors.black12,
                  ),
                  child: Image.network(
                    movie.posterPath,
                    width: width,
                    height: 225,
                    fit: BoxFit.cover,
                    loadingBuilder: (context, child, loadingProgress) {
                      if (loadingProgress != null) {
                        return const Center(
                          child: CircularProgressIndicator(),
                        );
                      }
                      return child;
                    },
                    errorBuilder: (context, error, stackTrace) {
                      return const Icon(Icons.error);
                    },
                  ),
                ),
              ),
            ),
            const SizedBox(height: 10),
            SizedBox(
              width: width,
              child: Text(
                movie.title,
                maxLines: 2,
                style: textStyle.titleMedium?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            Row(
              children: [
                const Icon(Icons.star, color: Colors.amber, size: 16),
                Text(
                  movie.voteAverage.toStringAsFixed(2),
                  style: textStyle.bodyMedium?.copyWith(
                      fontWeight: FontWeight.bold, color: Colors.black45),
                ),
                const Spacer(),
                Text(
                  HumanFormats.number(movie.popularity),
                  style: textStyle.bodyMedium?.copyWith(
                      fontWeight: FontWeight.bold, color: Colors.black45),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class _Title extends StatelessWidget {
  final String? title;
  final String? date;
  const _Title({this.title, this.date});

  @override
  Widget build(BuildContext context) {
    final textStyle = Theme.of(context).textTheme.titleLarge;
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 15),
      padding: const EdgeInsets.symmetric(horizontal: 15),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          if (title != null)
            Text(
              title!,
              style: textStyle?.copyWith(fontWeight: FontWeight.bold),
            ),
          if (date != null)
            FilledButton.tonal(
              onPressed: () {},
              style: const ButtonStyle(visualDensity: VisualDensity.compact),
              child: Text(
                date!,
                style: const TextStyle(
                  fontSize: 16,
                ),
              ),
            ),
        ],
      ),
    );
  }
}
