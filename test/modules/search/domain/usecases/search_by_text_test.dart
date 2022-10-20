import 'package:clean_dart_search_bloc/modules/search/domain/entities/result_search.dart';
import 'package:clean_dart_search_bloc/modules/search/domain/errors/errors.dart';
import 'package:clean_dart_search_bloc/modules/search/domain/repositories/search_repository.dart';
import 'package:clean_dart_search_bloc/modules/search/domain/usecases/search_by_text.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';

// Cria uma implementação fack do repository
class SearchRepositoryMock implements SearchRepository {
  @override
  Future<Either<FailureSearch, List<ResultSearch>>> search(
      String? searchText) async {
    if ((searchText == null) || (searchText == "")) {
      return Left(InvalidTextError());
    }

    return await Future.value(const Right(<ResultSearch>[]));
  }
}

void main() {
  final searchRepository = SearchRepositoryMock();
  final searchByTextUC = SearchByTextImpl(searchRepository);

  test('deve retornar uma lista de ResultSearch', () async {
    final result = await searchByTextUC("Yuri");
    expect(result.getOrElse(() => []), isA<List<ResultSearch>>());
  });

  test('deve retornar um exception caso o texto seja invalido', () async {
    final result = await searchByTextUC(null);

    expect(result.fold((l) => l, (r) => r), isA<InvalidTextError>());
  });
}
