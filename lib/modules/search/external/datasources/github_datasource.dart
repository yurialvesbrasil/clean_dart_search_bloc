import 'dart:developer';

import 'package:clean_dart_search_bloc/modules/search/domain/errors/errors.dart';
import 'package:clean_dart_search_bloc/modules/search/infra/datasources/search_datasource.dart';
import 'package:clean_dart_search_bloc/modules/search/infra/models/result_search_model.dart';
import 'package:clean_dart_search_bloc/shared/client_http.dart';

extension on String {
  toSearchTextNormalize() {
    return replaceAll(" ", "+");
  }
}

class GithubDatasource implements SearchDatasource {
  final ClientHttp clientHttp;

  GithubDatasource(this.clientHttp);

  @override
  Future<List<ResultSearchModel>>? getResultSearch(String? serachText) async {
    try {
      if ((serachText == null) || (serachText == "")) {
        throw Exception();
      }

      final response = await clientHttp.get(serachText);

      if (response?.statusCode == 200) {
        return response?.data?['items']
            .map((key, value) => ResultSearchModel.fromMap(value))
            .toList();
      } else {
        throw DatasourceException('Erro no DataSource',
            statusCode: response?.statusCode ?? 500);
      }
    } catch (e) {
      throw Exception(e);
    }
  }
}
