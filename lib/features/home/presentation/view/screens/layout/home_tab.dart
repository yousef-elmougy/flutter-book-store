import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../../core/widgets/custom_error_widget.dart';
import '../../../manager/best_books_cubit/best_books_cubit.dart';
import '../../../manager/newest_books_cubit/newest_books_cubit.dart';
import '../../widgets/home_body_widget.dart';


class HomeTab extends StatelessWidget {
  const HomeTab({super.key});

  @override
  Widget build(BuildContext context) =>
      BlocBuilder<BestBooksCubit, BestBooksState>(
        builder: (context, state) {
          if (state.status == BestBooksStatus.error) {
            return CustomErrorWidget(
              subTitle: state.error,
              onPressed: context.read<BestBooksCubit>().fetchBestBooks,
            );
          }
          return BlocBuilder<NewestBooksCubit, NewestBooksState>(
            builder: (context, state) {
              if (state.status == NewestBooksStatus.error) {
                return CustomErrorWidget(
                  subTitle: state.error,
                  onPressed: context.read<NewestBooksCubit>().fetchNewestBooks,
                );
              }
              return const HomeBodyWidget();
            },
          );
        },
      );
}
