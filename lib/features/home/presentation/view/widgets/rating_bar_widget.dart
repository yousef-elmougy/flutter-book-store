import 'package:flutter/material.dart';

import '../../../../../core/constants/colors.dart';
import '../../../../../core/constants/text_styles.dart';

class RatingBarWidget extends StatelessWidget {
  const RatingBarWidget({
    super.key,
    required this.averageRating,
    required this.ratingsCount,
  });

  final num averageRating;
  final int ratingsCount;

  @override
  Widget build(BuildContext context) => Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Icon(Icons.star, color: kStarColor, size: 20),
          Text(
            ' $averageRating',
            style: Style.textMedium_16,
          ),
          Text(
            ' ($ratingsCount)',
            style: Style.textNormal_14,
          ),
        ],
      );
}
