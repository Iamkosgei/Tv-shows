import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_tv_shows/data/models/shows_list_response.dart';
import 'package:flutter_tv_shows/utils/constants.dart';

class MovieItem extends StatelessWidget {
  final Show show;
  const MovieItem({Key? key, required this.show}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(4.0),
      ),
      clipBehavior: Clip.antiAlias,
      color: Colors.white,
      elevation: 8.0,
      child: SizedBox(
        height: 400,
        width: double.infinity,
        child: Column(
          children: [
            Expanded(
              flex: 2,
              child: CachedNetworkImage(
                width: double.infinity,
                fit: BoxFit.cover,
                imageUrl: show.imageUrl ?? noImageFound,
                placeholder: (context, url) =>
                    const Center(child: CircularProgressIndicator()),
                errorWidget: (context, url, error) => const Icon(Icons.error),
              ),
            ),
            const SizedBox(
              height: 16,
            ),
            Expanded(
              flex: 1,
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      // flex: 1,
                      child: Text(
                        show.title ?? '',
                        style: const TextStyle(
                          color: Colors.black,
                          fontSize: 24,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 16,
                    ),
                    Expanded(
                      // flex: 2,
                      child: Text(
                        show.description ?? '',
                        overflow: TextOverflow.ellipsis,
                        softWrap: false,
                        style: const TextStyle(color: Colors.black),
                      ),
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
