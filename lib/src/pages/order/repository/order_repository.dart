import '../../../constants/endpoints.dart';
import '../../../models/cartModels.dart';
import '../../../models/orderModels.dart';
import '../../../services/http_manager.dart';
import '../result/order_result.dart';

class OrderRepository {
  final HttpManager _httpManager = HttpManager();

  Future<OrderResult<List<OrderModels>>> getAllOrder(
      {required String user, required String token}) async {
    final result = await _httpManager.restRequest(
        urlEndPonit: Endpoints.getAllOrder,
        method: HttMethods.post,
        body: {"user": user},
        headers: {"X-Parse-Session-Token": token});

    if (result["result"] != null) {
      List<OrderModels> order =
          List<Map<String, dynamic>>.from(result["result"])
              .map((e) => OrderModels.fromMap(e))
              .toList();

      return OrderResult<List<OrderModels>>.succe(order);
    } else {
      return OrderResult.error("Não foi possível recuperar os pedidos");
    }
  }

  Future<OrderResult<List<CartModels>>> getOrderItems({required String orderId, required String token}) async {
    final result = await _httpManager.restRequest(
        urlEndPonit: Endpoints.getOrderItems,
        method: HttMethods.post,
        body: {"orderId": orderId},
        headers: {"X-Parse-Session-Token": token});

    if (result["result"] != null) {
      List<CartModels> orderItems =
          List<Map<String, dynamic>>.from(result["result"])
              .map((e) => CartModels.fromMap(e))
              .toList();

      return  OrderResult<List<CartModels>>.succe(orderItems);
    }
    else{
      return OrderResult.error("Não foi possível recuperar os produtos do pedidos");
    }
  }
}
