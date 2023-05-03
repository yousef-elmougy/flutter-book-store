import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';

class Exceptions extends Equatable implements Exception {
  final String message;

  const Exceptions(this.message);

  @override
  List<Object?> get props => [message];

  @override
  String toString() => message;
}

class ServerException extends Exceptions {
  const ServerException(super.message);

  factory ServerException._handleResponseException(DioError error) {
    switch (error.response?.statusCode) {
      case 400:
        return const ServerException('Bad Request');

      case 403:
      case 401:
        return const ServerException('Un authorized');

      case 404:
        return ServerException('Not Found Error 404 : ${error.response?.data}');

      case 409:
        return const ServerException('Conflict Error');

      case 502:
        return const ServerException('Bad getWay');

      case 500:
        return const ServerException('Internal Server Error');
    }
    return const UnExpectedException();
  }

  factory ServerException.getDioException(DioError error) {
    switch (error.type) {
      case DioErrorType.connectionTimeout:
        return const ServerException('Connection Time Out');

      case DioErrorType.sendTimeout:
        return const ServerException('Send Time Out');

      case DioErrorType.receiveTimeout:
        return const ServerException('Receive Time Out');

      case DioErrorType.cancel:
        return const ServerException('Canceled');

      case DioErrorType.connectionError:
        return const ServerException('Connection Error Check the Internet');

      case DioErrorType.unknown:
        return const ServerException('Connection Error Check the Internet');

      case DioErrorType.badCertificate:
        return const ServerException('Invalidate Certificate');

      case DioErrorType.badResponse:
        ServerException._handleResponseException(error);
        break;
      default:
        return const UnExpectedException();
    }
    return const UnExpectedException();
  }
}

class UnExpectedException extends ServerException {
  const UnExpectedException(
      [super.message = 'Oops Something Went Wrong, please try again']);
}

class CacheException extends Exceptions {
  const CacheException(super.message);
}
