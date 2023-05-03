import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive_flutter/adapters.dart';

import 'app_bloc_observer.dart';
import 'core/cache/cache_service_impl.dart';
import 'core/constants/colors.dart';
import 'core/constants/strings.dart';
import 'core/functions/show_toast.dart';
import 'core/manager/internet_cubit/internet_cubit.dart';
import 'core/routes/app_router.dart';
import 'core/widgets/listen_to_internet.dart';
import 'features/home/data/model/books/book.dart';
import 'features/home/presentation/manager/best_books_cubit/best_books_cubit.dart';
import 'features/home/presentation/manager/newest_books_cubit/newest_books_cubit.dart';
import 'injection_container.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await SystemChrome.setPreferredOrientations(
    [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown],
  );
  await initGetIt();
  await Hive.initFlutter();
  Hive.registerAdapter(BookAdapter());
  Bloc.observer = AppBlocObserver();
  await Hive.openBox<Book>(CacheKeys.bookMarked.name);
  runApp(const MyApp()
      );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) => MultiBlocProvider(
        providers: [
          BlocProvider(create: (_) => sl<InternetCubit>()),
          BlocProvider(create: (_) => sl<BestBooksCubit>()),
          BlocProvider(create: (_) => sl<NewestBooksCubit>()),
        ],
        child: ListenToInternet(
          connect: showToast,
          disConnect: (text) => showToast(text, color: Colors.red),
          child: MaterialApp.router(
          
            useInheritedMediaQuery: true,
            routeInformationParser: AppRouter.router.routeInformationParser,
            routeInformationProvider: AppRouter.router.routeInformationProvider,
            routerDelegate: AppRouter.router.routerDelegate,
            debugShowCheckedModeBanner: false,
            theme: ThemeData(
              brightness: Brightness.dark,
              scaffoldBackgroundColor: kPrimaryColor,
              appBarTheme: const AppBarTheme(
                elevation: 0,
                backgroundColor: Colors.transparent,
              ),
              fontFamily: kMontserratFont,
            ),
          ),
        ),
      );
}
