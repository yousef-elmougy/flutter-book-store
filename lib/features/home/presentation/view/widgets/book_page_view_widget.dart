import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../../../../core/routes/app_router.dart';
import '../../../../../core/widgets/loader_widget.dart';
import '../../manager/best_books_cubit/best_books_cubit.dart';
import 'book_image_widget.dart';

class BooksPageViewWidget extends StatefulWidget {
  const BooksPageViewWidget({super.key});

  @override
  State<BooksPageViewWidget> createState() => _BooksPageViewWidgetState();
}

class _BooksPageViewWidgetState extends State<BooksPageViewWidget> {
  int currentPage = 0;

  @override
  Widget build(BuildContext context) => SizedBox(
        height: 250,
        width: double.infinity,
        child: BlocBuilder<BestBooksCubit, BestBooksState>(
          builder: (context, state) {
            switch (state.status) {
              case BestBooksStatus.initial:
                return const LoaderWidget();
           
              case BestBooksStatus.loading:
                return const LoaderWidget();
            
              case BestBooksStatus.error:
                return const LoaderWidget();
            
              case BestBooksStatus.success:
                final books = state.books;
                return PageView.builder(
                  controller: PageController(
                    viewportFraction: .45,
                    initialPage: currentPage,
                  ),
                  physics: const BouncingScrollPhysics(),
                  padEnds: false,
                  onPageChanged: (value) => setState(() => currentPage = value),
                  itemCount: books.length,
                  itemBuilder: (context, index) => GestureDetector(
                      onTap: () => context.go(
                        AppRouter.layoutToDetails,
                        extra: books[index],
                      ),
                      child: AnimatedPadding(
                        duration: const Duration(milliseconds: 500),
                        curve: Curves.easeInOut,
                        padding: currentPage == index
                            ? const EdgeInsets.all(0)
                            : const EdgeInsets.all(10),
                        child: BookImageWidget(image: books[index].thumbnail),
                      ),
                    ),
                );
            }
          },
        ),
      );
}
