class ApiException implements Exception {
  final String message;
  final String errorCode;
  static const String defaultMessage =
      'Hmm… something went wrong. No worries — you can try again in a moment!';

  ApiException([this.message = defaultMessage, this.errorCode = '']);

  @override
  String toString() => message;
}
