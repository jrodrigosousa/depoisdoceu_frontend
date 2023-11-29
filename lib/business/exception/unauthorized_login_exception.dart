class UnauthorizedLoginException implements Exception {
  final String message;

  UnauthorizedLoginException(this.message);
}