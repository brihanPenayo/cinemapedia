import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class FullScreenLoader extends StatelessWidget {
  const FullScreenLoader({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: _SkeletonLoader(),
    );
  }
}

class _SkeletonLoader extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: Colors.grey[300]!,
      highlightColor: Colors.grey[100]!,
      child: ListView(
        children: [
          _buildHeader(),
          const SizedBox(height: 30),
          _buildSectionTitle(),
          const SizedBox(height: 24),
          _buildMovieList(),
          const SizedBox(height: 24),
          _buildSectionTitle(),
          const SizedBox(height: 24),
          _buildMovieList(),
        ],
      ),
    );
  }

  Widget _buildHeader() {
    return Container(
      height: 200,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
      ),
    );
  }

  Widget _buildSectionTitle() {
    return Container(
      width: 150,
      height: 24,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(4),
      ),
    );
  }

  Widget _buildMovieList() {
    return SizedBox(
      height: 225,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: 5,
        itemBuilder: (context, index) {
          return Container(
            margin: const EdgeInsets.only(right: 12),
            width: 150,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(8),
            ),
          );
        },
      ),
    );
  }
}
