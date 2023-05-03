import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../data/model/books/book.dart';
import '../../../data/repository/books_repository.dart';

part 'search_book_state.dart';

class SearchBookCubit extends Cubit<SearchBookState> {
  SearchBookCubit(this.homeRepository) : super(const SearchBookState());

  final BooksRepository homeRepository;

  Future<void> searchBookByTitle(String query) async {
    final searchBook = await homeRepository.searchBookByTitle(query);
    searchBook.fold(
      (error) => emit(state.copyWith(
        error: error.toString(),
        status: SearchBookStatus.error,
      )),
      (searchBook) {
        final book = searchBook
            .where((book) =>
                book.title.toLowerCase().contains(query.toLowerCase()) &&
                book.title.toLowerCase().startsWith(query.toLowerCase()))
            .toList();
        emit(state.copyWith(
          books: book,
          status: SearchBookStatus.success,
          hasReachedMax: false,
        ));
      },
    );
  }

  Future<void> getSearchedBooks(String query) async {
    if (state.hasReachedMax) return;
    if (state.status == SearchBookStatus.loading) {
      final searchBook = await homeRepository.getSearchedBooks(query);
      searchBook.fold(
        (error) => emit(state.copyWith(
          error: error.toString(),
          status: SearchBookStatus.error,
        )),
        (searchBook) {
          emit(state.copyWith(
            books: searchBook,
            status: SearchBookStatus.success,
            hasReachedMax: false,
          ));
        },
      );
    } else {
      final searchBook =
          await homeRepository.getSearchedBooks(query, state.books.length);
      searchBook.fold(
        (error) => emit(state.copyWith(
          error: error.toString(),
          status: SearchBookStatus.error,
        )),
        (searchBook) => searchBook.isEmpty
            ? emit(state.copyWith(hasReachedMax: true))
            : emit(state.copyWith(
                books: List.of(state.books)..addAll(searchBook),
                status: SearchBookStatus.success,
                hasReachedMax: false,
              )),
      );
    }
  }
}
