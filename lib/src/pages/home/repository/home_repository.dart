import 'package:app_quitamda_virtual/src/models/itemsModels.dart';

import '../../../constants/endpoints.dart';
import '../../../models/category_model.dart';
import '../../../services/http_manager.dart';
import '../result/home_result.dart';

class HomeRepository {
  final HttpManager _httpManager = HttpManager();

  Future<HomeResult<CategoryModel>> getAllCategories() async {
    final result = await _httpManager.restRequest(
        urlEndPonit: Endpoints.getAllCategories, method: HttMethods.post);

    if (result["result"] != null) {
      List<CategoryModel> data =
          (List<Map<String, dynamic>>.from(result["result"]))
              .map((e) => CategoryModel.fromMap(e))
              .toList();

      return HomeResult<CategoryModel>.sucess(data);
    } else {
      return HomeResult.error(
          "Ocorreu um erro inesperado ao recuperar as categorias");
    }
  }

  Future<HomeResult<ItemsModels>> getAllProduts(Map<String, dynamic> body) async {
    final result = await _httpManager.restRequest(
      urlEndPonit: Endpoints.getAllProduts,
      method: HttMethods.post,
      body: body
    );

    if (result["result"] != null) {
      List<ItemsModels> data =
          (List<Map<String, dynamic>>.from(result["result"]))
              .map((e) => ItemsModels.fromMap(e))
              .toList();

      return HomeResult.sucess(data);
    } else {
      return HomeResult.error("Ocorreu um erro inesperado os recuperar itens");
    }
  }
}
