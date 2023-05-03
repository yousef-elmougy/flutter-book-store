import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../core/widgets/loader_widget.dart';
import '../../manager/newest_books_cubit/newest_books_cubit.dart';
import 'book_item_widget.dart';

class NewestBooksListWidget extends StatelessWidget {
  const NewestBooksListWidget({super.key});

  @override
  Widget build(BuildContext context) =>
      BlocBuilder<NewestBooksCubit, NewestBooksState>(
        builder: (context, state) {
          switch (state.status) {
            case NewestBooksStatus.initial:
              return const SliverToBoxAdapter(child: LoaderWidget());

            case NewestBooksStatus.loading:
              return const SliverToBoxAdapter(child: LoaderWidget());

            case NewestBooksStatus.error:
              return SliverToBoxAdapter(child: Text(state.error));

            case NewestBooksStatus.success:
              final books = state.books;
              return books.isEmpty
                  ? SliverToBoxAdapter(child: Text(state.error))
                  : SliverList(
                      delegate: SliverChildBuilderDelegate(
                        childCount: state.hasReachedMax
                            ? books.length
                            : books.length + 1,
                        (context, index) => index >= books.length
                            ? const LoaderWidget()
                            : BookItemWidget(
                                book: books[index],
                              ),
                      ),
                    );
          }
        },
      );
}
