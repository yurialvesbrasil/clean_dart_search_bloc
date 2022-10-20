abstract class FailureSearch implements Exception {}

class InvalidTextError implements FailureSearch {}

class DatasourceException implements FailureSearch {
  final String message;
  final int? statusCode;

  DatasourceException(this.message, {this.statusCode});
}
