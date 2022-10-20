import 'package:clean_dart_search_bloc/modules/search/domain/entities/result_search.dart';
import 'package:clean_dart_search_bloc/modules/search/domain/errors/errors.dart';
import 'package:clean_dart_search_bloc/modules/search/infra/datasources/search_datasource.dart';
import 'package:clean_dart_search_bloc/modules/search/infra/models/result_search_model.dart';
import 'package:clean_dart_search_bloc/modules/search/infra/respositories/search_repository_impl.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

class SearchDatasourceMock extends Mock implements SearchDatasource {}

main() {
  final datasource = SearchDatasourceMock();
  final repository = SearchRepositoryImpl(datasource);

  test('deve retornar uma lista de ResultSearch', () async {
    when(datasource.getResultSearch("Yuri"))
        .thenAnswer((_) async => <ResultSearchModel>[]);

    final result = await repository.search("Yuri");
    expect(result | [], isA<List<ResultSearch>>());
  });

  test('deve retornar uma error se o datasource falhar', () async {
    when(datasource.getResultSearch("Yuri"))
        .thenThrow(DatasourceException('Algum Erro'));
    final result = await repository.search("Yuri");
    expect(result.fold((l) => l, (r) => r), isA<DatasourceException>());
  });
}
