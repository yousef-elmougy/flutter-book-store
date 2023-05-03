import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../data/model/books/book.dart';
import '../../../data/repository/books_repository.dart';

part 'best_books_state.dart';

class BestBooksCubit extends Cubit<BestBooksState> {
  BestBooksCubit(this.homeRepository) : super(const BestBooksState());

  final BooksRepository homeRepository;

  Future<void> fetchBestBooks() async {
    emit(state.copyWith(status: BestBooksStatus.loading));
    final bestBooks = await homeRepository.getBestBooks();
    bestBooks.fold(
      (error) => emit(state.copyWith(
        status: BestBooksStatus.error,
        error: error.toString(),
      )),
      (bestBooks) => emit(state.copyWith(
        status: BestBooksStatus.success,
        books: bestBooks,
      )),
    );
  }
}
