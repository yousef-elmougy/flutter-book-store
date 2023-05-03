import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class BookImageWidget extends StatelessWidget {
  const BookImageWidget({
    super.key,
    required this.image,
  });

  final String image;

  @override
  Widget build(BuildContext context) => ClipRRect(
        borderRadius: BorderRadius.circular(16),
        child: AspectRatio(
          aspectRatio: .66,
          child: CachedNetworkImage(
            fit: BoxFit.fill,
            imageUrl: image,
            errorWidget: (context, url, error) => const Icon(
              Icons.error_outline,
              color: Colors.red,
              size: 50,
            ),
          ),
        ),
      );
}
