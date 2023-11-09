import 'package:flutter/material.dart';
import 'package:app_quitamda_virtual/src/services/UtilServices.dart';
import 'package:get/get.dart';
import '../../../../config/custom_colors.dart';
import '../../../../models/cartModels.dart';
import '../../../common_widgets/quantity_widget.dart';
import '../../controller/cart_controller.dart';

class CartTile extends StatefulWidget {
   const CartTile({
    Key? key,
    required this.cartModels,
    required this.remove,
  }) : super(key: key);

  final CartModels cartModels;
  final Function(CartModels cartModels) remove;

  @override
  State<CartTile> createState() => _CartTileState();
}

class _CartTileState extends State<CartTile> {
  UtilServices utilServices = UtilServices();

  final controller = Get.find<CartController>();

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.fromLTRB(10, 10, 10, 0),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(18),),
      child: ListTile(
        //Imagem
        leading: Image.network(
          widget.cartModels.product.picture,
          height: 50,
          width: 50,
        ),
        

        //Titulo
          title: Text(
          widget.cartModels.product.title,
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),

        //Subtitulo
        subtitle: Text(
          utilServices.priceToCurrency(widget.cartModels.priceQuantity()),
          style: TextStyle(fontSize: 12, color: CustomColors.customSwatchColor),
        ),

        //Quantidade
         trailing: QuantityWidget(
          itemQuantity: widget.cartModels.quantity, 
          uniy: widget.cartModels.product.unit, 
          removable: true,
          value: (quantity) {

             controller.modifyItemQuantity(item: widget.cartModels, quantity: quantity);
            
          }, 
        ), 
      ),
    );
  }
}
