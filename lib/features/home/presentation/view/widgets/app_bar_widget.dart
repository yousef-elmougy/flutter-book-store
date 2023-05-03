import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';
import 'package:hive/hive.dart';

import '../../../../../core/cache/cache_service_impl.dart';
import '../../../../../core/constants/assets.dart';
import '../../../../../core/functions/show_toast.dart';
import '../../../../../core/routes/app_router.dart';
import '../../../data/model/books/book.dart';

class AppBarWidget extends StatefulWidget {
  const AppBarWidget({
    super.key,
    required this.isDetails,
    this.book = const Book(),
  });

  final bool isDetails;
  final Book book;

  @override
  State<AppBarWidget> createState() => _AppBarWidgetState();
}

class _AppBarWidgetState extends State<AppBarWidget> {
  @override
  Widget build(BuildContext context) {
    final isMarked =
        Hive.box<Book>(CacheKeys.bookMarked.name).containsKey(widget.book.id);

    final bookMarkedIcon = Icon(
      isMarked ? Icons.bookmark_added : Icons.bookmark_add_outlined,
      size: 40,
    );

    final searchIcon = SvgPicture.asset(Assets.searchIcon);

    return Padding(
      padding: const EdgeInsets.only(right: 30, bottom: 30),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          if (widget.isDetails) const CloseButton(),
          if (!widget.isDetails) SvgPicture.asset(Assets.logo),
          IconButton(
            onPressed: widget.isDetails ? _markedBook : _goToSearch,
            icon: widget.isDetails ? bookMarkedIcon : searchIcon,
            tooltip: widget.isDetails ? 'Book Marked' : 'Search',
          ),
        ],
      ),
    );
  }

  void _goToSearch() => context.go(AppRouter.searchScreen);

  Future<void> _markedBook() async {
    final box = Hive.box<Book>(CacheKeys.bookMarked.name);
    if (box.containsKey(widget.book.id)) {
      await _deleteBook(box);
    } else {
      await _addBook(box);
    }
    setState(() {});
  }

  Future<void> _addBook(Box<Book> box) async {
    final book = widget.book;
    await box.put(
      book.id,
      Book(
        id: book.id,
        title: book.title,
        thumbnail: book.thumbnail,
        authors: book.authors,
        averageRating: book.averageRating,
        ratingsCount: book.ratingsCount,
        saleability: book.saleability,
      ),
    );
    cancelToast();
    showToast('Book Added Successfully');
  }

  Future<void> _deleteBook(Box<Book> box) async {
    await box.delete(widget.book.id);
    cancelToast();
    showToast('Book Deleted Successfully');
  }
}
