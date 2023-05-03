import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../injection_container.dart';
import '../../../data/model/books/book.dart';
import '../../manager/similar_books_cubit/similar_books_cubit.dart';
import '../widgets/book_details_body_widget.dart';

class BookDetailsScreen extends StatelessWidget {
  const BookDetailsScreen({super.key, required this.book});

  final Book book;

  @override
  Widget build(BuildContext context) => BlocProvider(
        create: (_) => sl<SimilarBooksCubit>(),
        child: Scaffold(
          body: BookDetailsBodyWidget(book: book),
        ),
      );
}
