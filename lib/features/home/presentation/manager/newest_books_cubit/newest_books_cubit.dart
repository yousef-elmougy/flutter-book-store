import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../data/model/books/book.dart';
import '../../../data/repository/books_repository.dart';

part 'newest_books_state.dart';

class NewestBooksCubit extends Cubit<NewestBooksState> {
  NewestBooksCubit(this.homeRepository) : super(const NewestBooksState());

  final BooksRepository homeRepository;

  Future<void> refreshNewestBooks() async {
    emit(state.copyWith(status: NewestBooksStatus.loading));
    final newestBooks = await homeRepository.getNewestBooks();
    newestBooks.fold(
      (error) => emit(state.copyWith(
        error: error.toString(),
        status: NewestBooksStatus.error,
      )),
      (newestBooks) => emit(state.copyWith(
        books: newestBooks,
        status: NewestBooksStatus.success,
        hasReachedMax: false,
      )),
    );
  }

  Future<void> fetchNewestBooks() async {
    if (state.hasReachedMax) return;
    if (state.status == NewestBooksStatus.loading) {
      final newestBooks = await homeRepository.getNewestBooks();
      newestBooks.fold(
        (error) => emit(state.copyWith(
          error: error.toString(),
          status: NewestBooksStatus.error,
        )),
        (newestBooks) => newestBooks.isEmpty
            ? emit(state.copyWith(
                status: NewestBooksStatus.success,
                hasReachedMax: true,
              ))
            : emit(state.copyWith(
                books: newestBooks,
                status: NewestBooksStatus.success,
                hasReachedMax: false,
              )),
      );
    } else {
      final newestBooks =
          await homeRepository.getNewestBooks(state.books.length);
      newestBooks.fold(
        (error) => emit(state.copyWith(
          error: error.toString(),
          status: NewestBooksStatus.error,
        )),
        (newestBooks) => newestBooks.isEmpty
            ? emit(state.copyWith(hasReachedMax: true))
            : emit(state.copyWith(
                books: List.of(state.books)..addAll(newestBooks),
                status: NewestBooksStatus.success,
                hasReachedMax: false,
              )),
      );
    }
  }
}
