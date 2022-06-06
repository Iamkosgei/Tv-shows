import 'package:flutter/material.dart';
import 'package:fade_shimmer/fade_shimmer.dart';

class MovieListLoadingShimmer extends StatelessWidget {
  const MovieListLoadingShimmer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      itemBuilder: (_, i) {
        final delay = (i * 300);
        return Card(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8.0),
          ),
          clipBehavior: Clip.antiAlias,
          color: Colors.white,
          elevation: 8.0,
          child: SizedBox(
            height: 400,
            width: double.infinity,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    flex: 3,
                    child: FadeShimmer(
                      height: double.infinity,
                      width: double.infinity,
                      radius: 4,
                      millisecondsDelay: delay,
                      fadeTheme: FadeTheme.light,
                    ),
                  ),
                  const SizedBox(
                    height: 16,
                  ),
                  FadeShimmer(
                    height: 8,
                    width: 150,
                    radius: 4,
                    millisecondsDelay: delay,
                    fadeTheme: FadeTheme.light,
                  ),
                  const SizedBox(
                    height: 16,
                  ),
                  FadeShimmer(
                    height: 8,
                    millisecondsDelay: delay,
                    width: 170,
                    radius: 4,
                    fadeTheme: FadeTheme.light,
                  ),
                  const SizedBox(
                    height: 16,
                  ),
                ],
              ),
            ),
          ),
        );
      },
      itemCount: 20,
      separatorBuilder: (_, __) => const SizedBox(
        height: 16,
      ),
    );
  }
}
