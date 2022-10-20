import 'package:clean_dart_search_bloc/modules/search/infra/models/result_search_model.dart';

abstract class SearchDatasource {
  Future<List<ResultSearchModel>>? getResultSearch(String? serachText);
}
