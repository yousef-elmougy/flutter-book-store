import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../../../core/constants/text_styles.dart';
import '../../../../../core/routes/app_router.dart';
import '../../../data/model/books/book.dart';
import 'book_image_widget.dart';
import 'rating_bar_widget.dart';

class BookItemWidget extends StatelessWidget {
  const BookItemWidget({super.key, required this.book});

  final Book book;

  @override
  Widget build(BuildContext context) => Padding(
        padding: const EdgeInsets.only(bottom: 20),
        child: GestureDetector(
          onTap: () => context.go(
            AppRouter.layoutToDetails,
            extra: book,
          ),
          child: ColoredBox(
            color: Colors.transparent,
            child: Row(
              children: [
                const SizedBox(width: 30),
                SizedBox(
                  height: 110,
                  child: BookImageWidget(image: book.thumbnail),
                ),
                const SizedBox(width: 30),
                Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      width: MediaQuery.of(context).size.width / 1.7,
                      child: Text(
                        book.title,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: Style.textNormal_20,
                      ),
                    ),
                    const SizedBox(height: 3),
                    SizedBox(
                      width: MediaQuery.of(context).size.width / 2,
                      child: Text(
                        book.authors[0],
                        overflow: TextOverflow.ellipsis,
                        style: Style.textMedium_14,
                      ),
                    ),
                    const SizedBox(height: 3),
                    SizedBox(
                      width: MediaQuery.of(context).size.width / 2,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            book.saleability,
                            style: Style.textBold_20,
                          ),
                          RatingBarWidget(
                            averageRating: book.averageRating,
                            ratingsCount: book.ratingsCount,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      );
}
