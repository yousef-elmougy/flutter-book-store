import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../core/widgets/custom_error_widget.dart';
import '../../../../../core/widgets/loader_widget.dart';
import '../../../../../core/widgets/pagination_widget.dart';
import '../../../data/model/books/book.dart';
import '../../manager/search_book_cubit/search_book_cubit.dart';
import '../widgets/book_item_widget.dart';

class SearchResultScreen extends StatefulWidget {
  const SearchResultScreen({
    super.key,
    this.book,
    this.value = '',
  });
  
  final Book? book;
  final String value;

  @override
  State<SearchResultScreen> createState() => _SearchResultScreenState();
}

class _SearchResultScreenState extends State<SearchResultScreen> {
  @override
  void initState() {
    super.initState();
    _getSearchedBooks();
  }

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(),
        body: BlocBuilder<SearchBookCubit, SearchBookState>(
          builder: (context, state) {
            switch (state.status) {
              case SearchBookStatus.initial:
                return const LoaderWidget();

              case SearchBookStatus.loading:
                return const LoaderWidget();

              case SearchBookStatus.error:
                return CustomErrorWidget(
                  subTitle: state.error,
                  onPressed: _getSearchedBooks,
                );

              case SearchBookStatus.success:
                final books = state.books;
                return books.isEmpty
                    ? Text(state.error)
                    : PaginationWidget(
                        onScrollEnd: _getSearchedBooks,
                        child: (context, controller) => ListView.builder(
                          controller: controller,
                          itemCount: _listLength(state, books),
                          itemBuilder: (context, index) =>
                              (index >= books.length)
                                  ? const LoaderWidget()
                                  : BookItemWidget(book: books[index]),
                        ),
                      );
            }
          },
        ),
      );

  Future<void> _getSearchedBooks() async {
    widget.book?.title == ''
        ? await context.read<SearchBookCubit>().getSearchedBooks(widget.value)
        : await context
            .read<SearchBookCubit>()
            .getSearchedBooks(widget.book!.title);
  }

  int _listLength(SearchBookState state, List<Book> books) =>
      state.hasReachedMax ? books.length : books.length + 1;
}
