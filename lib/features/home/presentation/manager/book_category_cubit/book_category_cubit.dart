import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../data/model/books/book.dart';
import '../../../data/repository/books_repository.dart';

part 'book_category_state.dart';

class BookCategoryCubit extends Cubit<BookCategoryState> {
  BookCategoryCubit(this.homeRepository) : super(const BookCategoryState());

  final BooksRepository homeRepository;

  Future<void> refreshBooksByCategory(String category) async {
    emit(state.copyWith(status: BookCategoryStatus.loading));
    final bookCategory = await homeRepository.getBooksByCategory(category);
    bookCategory.fold(
      (error) => emit(state.copyWith(
        error: error.toString(),
        status: BookCategoryStatus.error,
      )),
      (bookCategory) => emit(state.copyWith(
        books: bookCategory,
        status: BookCategoryStatus.success,
        hasReachedMax: false,
      )),
    );
  }

  Future<void> fetchBooksByCategory(String category) async {
    if (state.hasReachedMax) return;
    if (state.status == BookCategoryStatus.loading) {
      final bookCategory = await homeRepository.getBooksByCategory(category);
      bookCategory.fold(
        (error) => emit(state.copyWith(
          error: error.toString(),
          status: BookCategoryStatus.error,
        )),
        (bookCategory) => bookCategory.isEmpty
            ? emit(state.copyWith(
                status: BookCategoryStatus.success,
                hasReachedMax: true,
              ))
            : emit(state.copyWith(
                books: bookCategory,
                status: BookCategoryStatus.success,
                hasReachedMax: false,
              )),
      );
    } else {
      final bookCategory =
          await homeRepository.getBooksByCategory(category, state.books.length);
      bookCategory.fold(
        (error) => emit(state.copyWith(
          error: error.toString(),
          status: BookCategoryStatus.error,
        )),
        (bookCategory) => bookCategory.isEmpty
            ? emit(state.copyWith(hasReachedMax: true))
            : emit(state.copyWith(
                books: List.of(state.books)..addAll(bookCategory),
                status: BookCategoryStatus.success,
                hasReachedMax: false,
              )),
      );
    }
  }
}
