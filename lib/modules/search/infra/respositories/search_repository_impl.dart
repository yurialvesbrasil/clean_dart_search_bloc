import 'package:clean_dart_search_bloc/modules/search/domain/errors/errors.dart';
import 'package:clean_dart_search_bloc/modules/search/domain/entities/result_search.dart';
import 'package:clean_dart_search_bloc/modules/search/domain/repositories/search_repository.dart';
import 'package:clean_dart_search_bloc/modules/search/infra/datasources/search_datasource.dart';
import 'package:dartz/dartz.dart';

class SearchRepositoryImpl implements SearchRepository {
  final SearchDatasource datasource;

  SearchRepositoryImpl(this.datasource);

  @override
  Future<Either<FailureSearch, List<ResultSearch>>> search(
      String? searchText) async {
    try {
      final result = await datasource.getResultSearch(searchText);
      return Right(result ?? []);
    } on DatasourceException catch (e) {
      return Left(e);
    } catch (e) {
      return Left(DatasourceException(e.toString()));
    }
  }
}
