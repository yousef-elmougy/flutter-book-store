import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';

import '../../../../../../core/cache/cache_service_impl.dart';
import '../../../../../../core/widgets/empty_widget.dart';
import '../../../../data/model/books/book.dart';
import '../../widgets/book_item_widget.dart';

class BookMarkedTab extends StatelessWidget {
  const BookMarkedTab({super.key});

  @override
  Widget build(BuildContext context) => Center(
        child: Padding(
          padding: const EdgeInsets.only(top: 50),
          child: ValueListenableBuilder(
            valueListenable:
                Hive.box<Book>(CacheKeys.bookMarked.name).listenable(),
            builder: (context, value, child) {
              final books = value.values.toList();
              return books.isEmpty
                  ? const EmptyWidget(
                      icon: Icon(Icons.bookmark_add_outlined, size: 200),
                      text: 'Add Some Books',
                    )
                  : ListView.builder(
                      itemCount: books.length,
                      itemBuilder: (context, index) =>
                          BookItemWidget(book: books[index]),
                    );
            },
          ),
        ),
      );
}
