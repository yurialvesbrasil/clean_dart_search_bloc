import 'package:clean_dart_search_bloc/modules/search/domain/errors/errors.dart';
import 'package:dartz/dartz.dart';
import '../entities/result_search.dart';

abstract class SearchRepository {
  Future<Either<FailureSearch, List<ResultSearch>>> search(String? searchText);
}
