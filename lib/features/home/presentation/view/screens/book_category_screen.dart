import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../../../../core/routes/app_router.dart';
import '../../../../../core/widgets/custom_error_widget.dart';
import '../../../../../core/widgets/loader_widget.dart';
import '../../../../../core/widgets/pagination_widget.dart';
import '../../../data/model/books/book.dart';
import '../../manager/book_category_cubit/book_category_cubit.dart';
import '../widgets/book_image_widget.dart';

class BookCategoryScreen extends StatefulWidget {
  const BookCategoryScreen({super.key, required this.category});

  final String category;

  @override
  State<BookCategoryScreen> createState() => _BookCategoryScreenState();
}

class _BookCategoryScreenState extends State<BookCategoryScreen> {
  @override
  void initState() {
    super.initState();
    _fetchBooksByCategory();
  }


  @override
  Widget build(BuildContext context) => RefreshIndicator(
        onRefresh: _refreshScreen,
        child: Scaffold(
          appBar: AppBar(leading: const CloseButton()),
          body: BlocBuilder<BookCategoryCubit, BookCategoryState>(
            builder: (context, state) {
              switch (state.status) {
                case BookCategoryStatus.initial:
                  return const LoaderWidget();

                case BookCategoryStatus.loading:
                  return const LoaderWidget();

                case BookCategoryStatus.error:
                  return CustomErrorWidget(
                    title: state.error,
                    onPressed: _fetchBooksByCategory,
                  );

                case BookCategoryStatus.success:
                  final books = state.books;
                  return books.isEmpty
                      ? Text(state.error)
                      : PaginationWidget(
                          onScrollEnd: _fetchBooksByCategory,
                          child:(context, controller) => GridView.builder(
                            controller: controller,
                            itemCount: _listLength(state, books),
                            gridDelegate:
                                const SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 3,
                              childAspectRatio: .66,
                              crossAxisSpacing: 10,
                              mainAxisSpacing: 10,
                            ),
                            itemBuilder: (context, index) => index >=
                                    books.length
                                ? const LoaderWidget()
                                : GestureDetector(
                                    onTap: () => context.go(
                                      AppRouter.layoutToDetails,
                                      extra: books[index],
                                    ),
                                    child: BookImageWidget(image: books[index].thumbnail),
                                  ),
                          ),
                        );
              }
            },
          ),
        ),
      );

  Future<void> _refreshScreen() async => await context
      .read<BookCategoryCubit>()
      .refreshBooksByCategory(widget.category);

  Future<void> _fetchBooksByCategory() async => await context
      .read<BookCategoryCubit>()
      .fetchBooksByCategory(widget.category);

  int _listLength(BookCategoryState state, List<Book> books) =>
      state.hasReachedMax ? books.length : books.length + 1;
}
