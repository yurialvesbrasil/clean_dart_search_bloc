import 'dart:convert';

import 'package:clean_dart_search_bloc/modules/search/domain/errors/errors.dart';
import 'package:clean_dart_search_bloc/modules/search/external/datasources/github_datasource.dart';
import 'package:clean_dart_search_bloc/shared/client_http.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import 'results/result_search.dart';

class ClientHttpMock extends Mock implements ClientHttp {}

main() {
  ClientHttp clientHttp = ClientHttpMock();
  final datasource = GithubDatasource(clientHttp);

  test("deve retornar uma lista de ResultSearchModel", () async {
    when(clientHttp.get("jacob")).thenAnswer(
        (_) async => Response(data: jsonDecode(githubResult), statusCode: 200));

    final future = await datasource.getResultSearch("jacob");
    expect(future, completes);
  });

  test("deve retornar um erro 401", () async {
    when(clientHttp.get("jacob"))
        .thenAnswer((_) async => Response(data: {}, statusCode: 401));

    final result = await datasource.getResultSearch("jacob");
    expect(result, throwsA(isA<DatasourceException>()));
  });

  test("deve retornar um Exception", () async {
    when(clientHttp.get("jacob")).thenThrow(Exception());

    final result = await datasource.getResultSearch("jacob");
    expect(result, throwsA(isA<Exception>()));
  });
}
