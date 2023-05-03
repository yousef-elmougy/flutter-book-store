import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../core/constants/text_styles.dart';
import '../../../data/model/books/book.dart';
import '../../manager/similar_books_cubit/similar_books_cubit.dart';
import 'app_bar_widget.dart';
import 'book_image_widget.dart';
import 'price_or_free_preview_button_widget.dart';
import 'rating_bar_widget.dart';
import 'similar_books_list_widget.dart';

class BookDetailsBodyWidget extends StatefulWidget {
  const BookDetailsBodyWidget({super.key, required this.book});

  final Book book;

  @override
  State<BookDetailsBodyWidget> createState() => _BookDetailsBodyWidgetState();
}

class _BookDetailsBodyWidgetState extends State<BookDetailsBodyWidget> {
  @override
  void initState() {
    super.initState();
    context
        .read<SimilarBooksCubit>()
        .fetchSimilarBooks(widget.book.categories[0]);
  }

  @override
  Widget build(BuildContext context) => CustomScrollView(
        slivers: [
          SliverFillRemaining(
            hasScrollBody: false,
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 30, top: 40),
                  child: AppBarWidget(
                    isDetails: true,
                    book: widget.book,
                  ),
                ),
                SizedBox(
                  height: 240,
                  child: BookImageWidget(
                    image: widget.book.thumbnail,
                  ),
                ),
                const SizedBox(height: 40),
                Text(
                  widget.book.title,
                  style: Style.textNormal_30,
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 6),
                Text(
                  widget.book.authors[0],
                  style: Style.textMedium_18,
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 16),
                RatingBarWidget(
                  averageRating: widget.book.averageRating,
                  ratingsCount: widget.book.ratingsCount,
                ),
                const SizedBox(height: 40),
                PriceOrFreePreviewButtonWidget(book: widget.book),
                const Expanded(child: SizedBox(height: 50)),
                Row(
                  children: const [
                    SizedBox(width: 30),
                    Text('You can also like', style: Style.textSemiBold_14),
                  ],
                ),
                const SizedBox(height: 16),
                const SimilarBooksListWidget(),
                const SizedBox(height: 40),
              ],
            ),
          ),
        ],
      );
}
