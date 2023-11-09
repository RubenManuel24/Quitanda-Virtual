
import 'itemsModels.dart';

class CartModels {
  String id;
  int quantity;
  ItemsModels product;
  
    CartModels({
    required this.id,
    required this.quantity,
    required this.product
  });

   double priceQuantity(){
    return product.price * quantity;
   }

  factory CartModels.fromMap(Map<String, dynamic> map){
   return CartModels(
      id: map["id"],
      quantity: map["quantity"],
      product: ItemsModels.fromMap(map["product"])
    );
  }

  Map<String, dynamic>toMap(){
    return {
      "id": id,
      "quantity": quantity,
      "product": product
    };
  }

  @override
  String toString() => 'CartModels(id: $id, quantity: $quantity, product: $product)';
}
