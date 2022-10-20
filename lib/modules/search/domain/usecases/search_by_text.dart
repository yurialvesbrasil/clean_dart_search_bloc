import 'package:dartz/dartz.dart';
import '../entities/result_search.dart';
import '../errors/errors.dart';
import '../repositories/search_repository.dart';

// Dessa forma a classe pode ser implementada de várias formas
abstract class SearchByText {
  Future<Either<FailureSearch, List<ResultSearch>>> call(String searchText);
}

class SearchByTextImpl implements SearchByText {
  final SearchRepository searchRepository;

  SearchByTextImpl(this.searchRepository);

  @override
  Future<Either<FailureSearch, List<ResultSearch>>> call(
      String? searchText) async {
    if ((searchText == null) || (searchText == "")) {
      return Left(InvalidTextError());
    }
    Either<FailureSearch, List<ResultSearch>> result =
        await searchRepository.search(searchText);
    return result;
  }
}
