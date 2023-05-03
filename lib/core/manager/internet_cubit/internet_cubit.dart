import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';

part 'internet_state.dart';

class InternetCubit extends Cubit<InternetState> {
  InternetCubit() : super(const InternetState()) {
    _checkInternet();
  }

  void _checkInternet() => InternetConnectionChecker().onStatusChange.listen(
        (status) {
          switch (status) {
            case InternetConnectionStatus.connected:
              return emit(state.copyWith(
                text: 'connected to the internet',
                status: InternetStatus.connect,
              ));
            case InternetConnectionStatus.disconnected:
              return emit(state.copyWith(
                text: 'check the internet connection',
                status: InternetStatus.disconnect,
              ));
          }
        },
      );
}
