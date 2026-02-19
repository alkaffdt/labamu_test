class GeneralException implements Exception {
  final String message;
  static const String defaultMessage =
      'Hmm… something went wrong. No worries - you can try again in a moment!';

  GeneralException([this.message = defaultMessage]);

  @override
  String toString() => message;
}
