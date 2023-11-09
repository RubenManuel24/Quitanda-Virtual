import 'package:flutter/material.dart';

import 'package:app_quitamda_virtual/src/models/itemsModels.dart';
import 'package:get/get.dart';

import '../../../../config/custom_colors.dart';
import '../../../../page_routes/app_pages.dart';
import '../../../../services/UtilServices.dart';
import '../../../cart/controller/cart_controller.dart';
import '../../../product/product_screen.dart';

// ignore: must_be_immutable
class ItemTile extends StatefulWidget {
  final ItemsModels itemsModels;
  final void Function(GlobalKey) cartAnimationMethod;

  const ItemTile({
    Key? key,
    required this.itemsModels,
    required this.cartAnimationMethod,
  }) : super(key: key);

  @override
  State<ItemTile> createState() => _ItemTileState();
}

class _ItemTileState extends State<ItemTile> {
  final GlobalKey imagekey = GlobalKey();

  UtilServices utilServices = UtilServices();

  IconData tileIcon = Icons.shopping_cart_outlined;

  final controller = Get.find<CartController>();

  Future<void> switchIcon() async {
    setState(() => tileIcon = Icons.check);

    await Future.delayed(const Duration(milliseconds: 1500));

    setState(() => tileIcon = Icons.shopping_cart_outlined);
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        //Conteudo do card
        GestureDetector(
          onTap: () {

            Get.toNamed(PageRoutes.productRoute, arguments:  widget.itemsModels);


          },
          child: Card(
            color: Colors.white,
            shadowColor: Colors.grey.shade300,
            elevation: 1,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20),
            ),
            child: Padding(
              padding: const EdgeInsets.all(12),
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    //Imagem
                    Expanded(
                      child: Hero(
                        tag: widget.itemsModels.picture,
                        child: Image.network(widget.itemsModels.picture,
                            key: imagekey),
                      ),
                    ),

                    //Nome
                    Text(
                      widget.itemsModels.title,
                      style: const TextStyle(
                          fontSize: 16, fontWeight: FontWeight.bold),
                    ),

                    //Preco - unidade
                    Row(children: [
                      Text(
                        utilServices.priceToCurrency(widget.itemsModels.price),
                        style: TextStyle(
                            fontSize: 20,
                            color: CustomColors.customSwatchColor),
                      ),
                      Text(
                        widget.itemsModels.unit,
                        style: TextStyle(
                          fontSize: 12,
                          color: Colors.grey.shade500,
                        ),
                      ),
                    ])
                  ]),
            ),
          ),
        ),

        //Botao add carrinho
        Positioned(
            right: 4,
            top: 4,
            child: ClipRRect(
              borderRadius: const BorderRadius.only(
                topRight: Radius.circular(20),
                bottomLeft: Radius.circular(10),
              ),
              child: Material(
                child: InkWell(
                  onTap: () {

                    widget.cartAnimationMethod(imagekey);

                    controller.addItemToCart(product: widget.itemsModels,);
                    
                    switchIcon();
                  },
                  child: Ink(
                    height: 40,
                    width: 35,
                    decoration: BoxDecoration(
                      color: CustomColors.customSwatchColor,
                    ),
                    child: Icon(
                      tileIcon,
                      color: Colors.white,
                      size: 20,
                    ),
                  ),
                ),
              ),
            ))
      ],
    );
  }
}
