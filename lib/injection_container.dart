import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';

import 'core/api/api_interceptor.dart';
import 'core/api/api_service.dart';
import 'core/api/api_service_impl.dart';
import 'core/cache/cache_service_impl.dart';
import 'core/manager/internet_cubit/internet_cubit.dart';
import 'features/home/data/repository/books_repository.dart';
import 'features/home/data/repository/books_repository_iml.dart';
import 'features/home/presentation/manager/best_books_cubit/best_books_cubit.dart';
import 'features/home/presentation/manager/book_category_cubit/book_category_cubit.dart';
import 'features/home/presentation/manager/newest_books_cubit/newest_books_cubit.dart';
import 'features/home/presentation/manager/search_book_cubit/search_book_cubit.dart';
import 'features/home/presentation/manager/similar_books_cubit/similar_books_cubit.dart';

GetIt sl = GetIt.instance;

Future<void> initGetIt() async {
  /// cubit

  sl.registerFactory(() => InternetCubit());
  sl.registerFactory(() => BestBooksCubit(sl())..fetchBestBooks());
  sl.registerFactory(() => NewestBooksCubit(sl())..fetchNewestBooks());
  sl.registerFactory(() => SimilarBooksCubit(sl()));
  sl.registerFactory(() => BookCategoryCubit(sl()));
  sl.registerFactory(() => SearchBookCubit(sl()));

  /// repository
  sl.registerLazySingleton<BooksRepository>(
    () => BooksRepositoryImpl(sl(), sl()),
  );

  /// core
  sl.registerLazySingleton(() => const CacheServiceImpl());
  sl.registerLazySingleton<ApiService>(() => ApiServiceImpl(sl()));

  /// EXTERNAL
  sl.registerLazySingleton(() => InternetConnectionChecker());
  sl.registerLazySingleton(() => Dio());
  sl.registerLazySingleton(() => AppInterceptors());
  sl.registerLazySingleton(
    () => LogInterceptor(
      request: true,
      requestBody: true,
      requestHeader: true,
      responseBody: true,
      responseHeader: true,
      error: true,
    ),
  );
}
