class NetworkRequestException implements Exception {
  final String cause;
  final int httpCode;

  NetworkRequestException(this.cause, this.httpCode);
}
