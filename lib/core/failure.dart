import 'dart:convert';

class Failure {
  final String message;
  final int? code;
  final StackTrace? stackTrace;
  Failure({
    required this.message,
    this.code = 400,
    this.stackTrace,
  });

  @override
  String toString() => jsonEncode({'code': code, 'message': message});
}
