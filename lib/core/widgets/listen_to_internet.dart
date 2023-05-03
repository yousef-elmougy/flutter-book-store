import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../manager/internet_cubit/internet_cubit.dart';

class ListenToInternet extends StatelessWidget {
  const ListenToInternet({
    super.key,
    required this.child,
    required this.connect,
    required this.disConnect,
  });

  final Widget child;
  final void Function(String) connect;
  final void Function(String) disConnect;

  @override
  Widget build(BuildContext context) =>
      BlocListener<InternetCubit, InternetState>(
        listener: (context, state) {
          switch (state.status) {
            case InternetStatus.initial:
              return ;
            case InternetStatus.connect:
              return connect(state.text);
            case InternetStatus.disconnect:
              return disConnect(state.text);
          }
        },
        child: child,
      );
}
