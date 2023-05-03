import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../core/constants/text_styles.dart';
import '../../../../../core/widgets/pagination_widget.dart';
import '../../manager/best_books_cubit/best_books_cubit.dart';
import '../../manager/newest_books_cubit/newest_books_cubit.dart';
import 'app_bar_widget.dart';
import 'book_page_view_widget.dart';
import 'newest_books_list_widget.dart';

class HomeBodyWidget extends StatelessWidget {
  const HomeBodyWidget({super.key});

  @override
  Widget build(BuildContext context) => PaginationWidget(
      onScrollEnd: context.read<NewestBooksCubit>().fetchNewestBooks,    
      child:(context, controller) => RefreshIndicator(
        onRefresh: () async => await _refresh(context),
        child: CustomScrollView(
          controller: controller,
          slivers: [
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.only(left: 30, top: 40),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: const [
                    AppBarWidget(isDetails: false),
                    BooksPageViewWidget(),
                    SizedBox(height: 50),
                    Text(
                      'Newest',
                      style: Style.textBold_18,
                      textAlign: TextAlign.start,
                    ),
                    SizedBox(height: 20),
                  ],
                ),
              ),
            ),
            const NewestBooksListWidget(),
          ],
        ),
      ),
    );

  Future<void> _refresh(BuildContext context) async {
    context.read<BestBooksCubit>().fetchBestBooks();
    context.read<NewestBooksCubit>().refreshNewestBooks();
  }
}
