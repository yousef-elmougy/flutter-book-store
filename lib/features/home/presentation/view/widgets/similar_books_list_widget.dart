import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../../../../core/routes/app_router.dart';
import '../../../../../core/widgets/loader_widget.dart';
import '../../manager/similar_books_cubit/similar_books_cubit.dart';
import 'book_image_widget.dart';

class SimilarBooksListWidget extends StatelessWidget {
  const SimilarBooksListWidget({super.key});

  @override
  Widget build(BuildContext context) =>
      BlocBuilder<SimilarBooksCubit, SimilarBooksState>(
        builder: (context, state) {
          switch (state.status) {
            case SimilarBooksStatus.initial:
              return const LoaderWidget();

            case SimilarBooksStatus.loading:
              return const LoaderWidget();

            case SimilarBooksStatus.error:
              return Text(state.error);

            case SimilarBooksStatus.success:
              final books = state.books;
              return Padding(
                padding: const EdgeInsets.only(left: 30),
                child: SizedBox(
                  height: 110,
                  child: ListView.separated(
                    scrollDirection: Axis.horizontal,
                    physics: const BouncingScrollPhysics(),
                    itemCount: books.length,
                    separatorBuilder: (_, __) => const SizedBox(width: 10),
                    itemBuilder: (context, index) {
                      final book = books[index];
                      return GestureDetector(
                        onTap: () =>
                            context.go(AppRouter.layoutToDetails, extra: book),
                        child: BookImageWidget(image: book.thumbnail),
                      );
                    },
                  ),
                ),
              );
          }
        },
      );
}
