import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../data/model/books/book.dart';
import '../../../data/repository/books_repository.dart';

part 'similar_books_state.dart';

class SimilarBooksCubit extends Cubit<SimilarBooksState> {
  SimilarBooksCubit(this.homeRepository) : super(const SimilarBooksState());

  final BooksRepository homeRepository;

  Future<void> fetchSimilarBooks(String category) async {
    emit(state.copyWith(status: SimilarBooksStatus.loading));
    final similarBooks = await homeRepository.getSimilarBooks(category);
    similarBooks.fold(
      (error) => emit(state.copyWith(
        status: SimilarBooksStatus.error,
        error: error.toString(),
      )),
      (similarBooks) => emit(state.copyWith(
        status: SimilarBooksStatus.success,
        books: similarBooks,
      )),
    );
  }
}
