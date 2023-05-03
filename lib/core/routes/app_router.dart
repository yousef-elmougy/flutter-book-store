import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../../features/home/presentation/view/screens/book_details_screen.dart';
import '../../../features/home/presentation/view/screens/search_screen.dart';
import '../../../features/splash/splash_screen.dart';
import '../../features/home/data/model/books/book.dart';
import '../../features/home/data/model/search_route_arguments.dart';
import '../../features/home/presentation/manager/book_category_cubit/book_category_cubit.dart';
import '../../features/home/presentation/manager/search_book_cubit/search_book_cubit.dart';
import '../../features/home/presentation/view/screens/book_category_screen.dart';
import '../../features/home/presentation/view/screens/layout/layout_screen.dart';
import '../../features/home/presentation/view/screens/search_results_screen.dart';
import '../../injection_container.dart';
import '../constants/assets.dart';
import '../widgets/custom_error_widget.dart';
import 'custom_transition_route.dart';

abstract class AppRouter {
  static const splashScreen = '/';
  static const layoutScreen = '/home';
  static const layoutToDetails = '$layoutScreen/book-details';
  static const layoutToBookCategory = '$layoutScreen/book-category';
  static const searchScreen = '$layoutScreen/search';
  static const searchResults = '$searchScreen/search-results';

  static final router = GoRouter(
    errorBuilder: (context, state) => CustomErrorWidget(
      subTitle: state.error.toString(),
      image: Assets.locationErrorSecond,
      onPressed: () => context.go('/'),
    ),
    routes: [
      GoRoute(
        path: splashScreen,
        builder: (context, state) => const SplashScreen(),
      ),
      GoRoute(
        path: layoutScreen,
        pageBuilder: (context, state) => _customTransition(
          state: state,
          child: const LayoutScreen(),
          transition: Transitions.fade,
          milliseconds: 3000,
        ),
        routes: [
          GoRoute(
            path: 'book-details',
            pageBuilder: (context, state) => _customTransition(
              state: state,
              child: BookDetailsScreen(book: state.extra as Book),
              transition: Transitions.leftToRight,
            ),
          ),
          GoRoute(
            path: 'book-category',
            pageBuilder: (context, state) => _customTransition(
              state: state,
              child: BlocProvider(
                create: (_) => sl<BookCategoryCubit>(),
                child: BookCategoryScreen(category: state.extra as String),
              ),
              transition: Transitions.leftToRight,
            ),
          ),
          GoRoute(
            path: 'search',
            pageBuilder: (context, state) => _customTransition(
              state: state,
              child: BlocProvider(
                create: (_) => sl<SearchBookCubit>(),
                child: const SearchScreen(),
              ),
              transition: Transitions.upToDown,
            ),
            routes: [
              GoRoute(
                path: 'search-results',
                pageBuilder: (context, state) => _customTransition(
                  state: state,
                  child: BlocProvider.value(
                    value: sl<SearchBookCubit>(),
                    child: SearchResultScreen(
                      book: (state.extra as SearchRouteArguments).book,
                      value: (state.extra as SearchRouteArguments).result,
                    ),
                  ),
                  transition: Transitions.leftToRight,
                ),
              ),
            ],
          ),
        ],
      ),
    ],
  );

  static CustomTransitionPage<dynamic> _customTransition({
    required GoRouterState state,
    required Widget child,
    required Transitions transition,
    int? milliseconds,
  }) =>
      CustomTransitionPage(
        key: state.pageKey,
        child: child,
        transitionDuration: Duration(milliseconds: milliseconds ?? 500),
        reverseTransitionDuration: const Duration(milliseconds: 500),
        transitionsBuilder: (_, animation, __, child) =>
            CustomTransitionRoute.selectTransition(
          child,
          animation,
          transition,
        ),
      );
}
