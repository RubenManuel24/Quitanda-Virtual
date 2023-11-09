import 'package:flutter/material.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:app_quitamda_virtual/src/pages/cart/cart_result/cart_result.dart';
import 'package:get/get.dart';
import '../../../models/cartModels.dart';
import '../../../models/orderModels.dart';
import '../../../services/UtilServices.dart';
import '../../auth/controller/auth_controller.dart';
import '../../common_widgets/Payment_pix.dart';
import '../cart_repository/cart_repository.dart';
import '../../../models/itemsModels.dart';

class CartController extends GetxController {
  
  final _cartRepository = CartRepository();
  final controllerAuth = Get.find<AuthController>();
  final utilservices = UtilServices();
  List<CartModels> cartModels = [];

  bool isCheckoutLoading = false;

  @override
  onInit() {
    super.onInit();
    getCartItems();
  }

  double priceTotal() {
    double total = 0;

    for (var price in cartModels) {
      total += price.priceQuantity();
    }

    return total;
  }

  Future<void> getCartItems() async {
    final CartResult<List<CartModels>> result =
        await _cartRepository.getCartItems(
      userId: controllerAuth.user.id!,
      token: controllerAuth.user.token!,
    );

    result.when(sucess: (result) {
      cartModels = result;
      update();
    }, error: (message) {
      utilservices.showToast(text: message);
    });
  }

  int getCartTotalItems() {
    return cartModels.isEmpty
        ? 0
        : cartModels.map((e) => e.quantity).reduce((a, b) => a + b);
  }

  Future<bool> modifyItemQuantity(
      {required CartModels item, required int quantity}) async {
    final result = await _cartRepository.modifyItemQuantity(
        cartItemId: item.id,
        quantity: quantity,
        token: controllerAuth.user.token!);

    if (result) {
      if (quantity == 0) {
        cartModels.removeWhere((cartItemList) => cartItemList.id == item.id);
      } else {
        cartModels
            .firstWhere((cartItemList) => cartItemList.id == item.id)
            .quantity = quantity;
      }

      update();
    } else {
      utilservices.showToast(
          text: "Ocorreu um erro ao alterar a quantidade do produto!",
          isError: true);
    }

    return result;
  }

  int getItemindex(ItemsModels item) {
    return cartModels
        .indexWhere((itemInList) => itemInList.product.id == item.id);
  }

  Future<void> addItemToCart(
      {required ItemsModels product, int quantity = 1}) async {
    int itemIndex = getItemindex(product);

    if (itemIndex >= 0) {
      final product = cartModels[itemIndex];

      await modifyItemQuantity(
          item: product, quantity: (product.quantity + quantity));
    } else {
      CartResult<String> result = await _cartRepository.addItemToCart(
          user: controllerAuth.user.id!,
          quantity: quantity,
          productId: product.id,
          token: controllerAuth.user.token!);

      result.when(sucess: (cartItemId) {
        cartModels.add(
            CartModels(id: cartItemId, quantity: quantity, product: product));
      }, error: (message) {
        utilservices.showToast(text: message, isError: true);
      });
    }
    update();
  }

  void setIsLoaging(bool value){
    isCheckoutLoading = value;
    update();
  }
  Future<void> checkout() async {
    CartResult<OrderModels> result = await _cartRepository.checkout(
      total: priceTotal(),
      token: controllerAuth.user.token!,
    );

    result.when(
        sucess: (order) {

           setIsLoaging(true);

          cartModels.clear();
          update();

          showDialog(
              context: Get.context!,
              builder: (_) {
                return PaymentPix(
                  orderModel: order,
                );
              });

            setIsLoaging(false);
        },
        error: (message) {
         utilservices.showToast(text: message);
        });
  }

}
