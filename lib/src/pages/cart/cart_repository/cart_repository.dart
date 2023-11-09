import '../../../constants/endpoints.dart';
import '../../../models/cartModels.dart';
import '../../../models/orderModels.dart';
import '../../../services/http_manager.dart';
import '../cart_result/cart_result.dart';

class CartRepository {
  final HttpManager _httpManager = HttpManager();

  Future<CartResult<List<CartModels>>> getCartItems(
      {required String userId, required String token}) async {
    final result = await _httpManager.restRequest(
        urlEndPonit: Endpoints.getCartItems,
        method: HttMethods.post,
        headers: {"X-Parse-Session-Token": token},
        body: {"user": userId});

    if (result["result"] != null) {
      List<CartModels> data = List<Map<String, dynamic>>.from(result["result"])
          .map((e) => CartModels.fromMap(e))
          .toList();

      return CartResult<List<CartModels>>.sucess(data);
    } else {
      return CartResult.error(
          "Ocorreu um erro ao recuperar os itens do carrinho!");
    }
  }

  Future<CartResult<String>> addItemToCart(
      {required String user,
      required int quantity,
      required String productId,
      required String token}) async {
    final result = await _httpManager.restRequest(
        urlEndPonit: Endpoints.addItemToCart,
        method: HttMethods.post,
        body: {"user": user, "quantity": quantity, "productId": productId},
        headers: {"X-Parse-Session-Token": token});

    if (result["result"] != null) {
      return CartResult<String>.sucess(result["result"]["id"]);
    } else {
      return CartResult<String>.error(
          "Não foi possível adicionar o item ao carrinho");
    }
  }

  Future<bool> modifyItemQuantity(
      {required String cartItemId,
      required int quantity,
      required String token}) async {
    final result = await _httpManager.restRequest(
        urlEndPonit: Endpoints.modifyItemQuantity,
        method: HttMethods.post,
        body: {"cartItemId": cartItemId, "quantity": quantity},
        headers: {"X-Parse-Session-Token": token});

    return result.isEmpty;
  }

  Future<CartResult<OrderModels>> checkout({required double total, required String token}) async {
    final result = await _httpManager.restRequest(
      urlEndPonit: Endpoints.checkout,
      method: HttMethods.post,
      body: {"total": total},
      headers: {"X-Parse-Session-Token": token},
    );
    
    if(result["result"] != null ){
      final order = OrderModels.fromMap(result["result"]);
      return CartResult<OrderModels>.sucess(order);
    }
    else{
      return CartResult<OrderModels>.error("Não foi possível realizar o pedido!");
    }

  }
}
