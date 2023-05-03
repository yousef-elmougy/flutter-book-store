part of 'internet_cubit.dart';

enum InternetStatus { initial, connect, disconnect }

class InternetState {
  final String text;
  final InternetStatus status;

  const InternetState({
    this.text = '',
    this.status = InternetStatus.initial,
  });

  InternetState copyWith({
    final String? text,
    final InternetStatus? status,
  }) =>
      InternetState(
        text: text ?? this.text,
        status: status ?? this.status,
      );

  @override
  String toString() => 'InternetState(status: $status,text: $text)';
}
