class NetworkException implements Exception {
  final String message;
  final bool isConnectionIssue;

  NetworkException(this.message, {this.isConnectionIssue = false});

  @override
  String toString() => message;
}

class ApiResponseException implements Exception {
  final String message;
  final int statusCode;
  ApiResponseException(this.message, this.statusCode);
}
