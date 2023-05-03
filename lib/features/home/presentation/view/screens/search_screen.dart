import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';

import '../../../../../core/constants/assets.dart';
import '../../../../../core/routes/app_router.dart';
import '../../../../../core/widgets/custom_error_widget.dart';
import '../../../../../core/widgets/empty_widget.dart';
import '../../../../../core/widgets/loader_widget.dart';
import '../../../data/model/search_route_arguments.dart';
import '../../manager/search_book_cubit/search_book_cubit.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  String query = '';
  final _controller = TextEditingController();
  Timer? _debounce;

  @override
  void dispose() {
    super.dispose();
    _debounce?.cancel();
    _controller.dispose();
  }

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(
          title: TextField(
            controller: _controller,
            autofocus: true,
            onChanged: _onChanged,
            onSubmitted: (result) => context.go(
              AppRouter.searchResults,
              extra: SearchRouteArguments(result: result),
            ),
            cursorColor: Colors.white,
            decoration: InputDecoration(
              enabledBorder: InputBorder.none,
              errorBorder: InputBorder.none,
              focusedBorder: InputBorder.none,
              border: InputBorder.none,
              hintText: 'search',
              suffixIcon: IconButton(
                icon: const Icon(Icons.clear, color: Colors.white),
                onPressed: _clearText,
              ),
            ),
          ),
        ),
        body: BlocBuilder<SearchBookCubit, SearchBookState>(
          builder: (context, state) {
            switch (state.status) {
              case SearchBookStatus.initial:
                return EmptyWidget(
                  icon: SvgPicture.asset(Assets.searchIcon, height: 200),
                  text: 'Search for a Book',
                );

              case SearchBookStatus.loading:
                return const LoaderWidget();

              case SearchBookStatus.error:
                return CustomErrorWidget(
                  subTitle: state.error,
                  onPressed: _searchForBook,
                );

              case SearchBookStatus.success:
                final books = state.books;
                return ListView.builder(
                  itemCount: books.length,
                  itemBuilder: (context, index) => GestureDetector(
                    onTap: () => context.go(
                      AppRouter.searchResults,
                      extra: SearchRouteArguments(book: books[index]),
                    ),
                    child: ListTile(
                      title: Text(books[index].title),
                      leading: SvgPicture.asset(
                        Assets.searchIcon,
                        colorFilter: const ColorFilter.mode(
                          Colors.grey,
                          BlendMode.srcIn,
                        ),
                      ),
                    ),
                  ),
                );
            }
          },
        ),
      );

  void _clearText() {
    if (context.read<SearchBookCubit>().state.books.isEmpty) return;
    query = '';
    _controller.clear();
    context.read<SearchBookCubit>().state.books.clear();
    setState(() {});
  }

  void _onChanged(String value) {
    if (_debounce?.isActive ?? false) _debounce?.cancel();
    _debounce = Timer(const Duration(milliseconds: 300), () {
    query = value;

    _searchForBook();
    });
  }

  void _searchForBook() =>
      context.read<SearchBookCubit>().searchBookByTitle(query);
}
