import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../config/custom_colors.dart';
import '../../models/itemsModels.dart';
import '../../services/UtilServices.dart';
import '../base/controller/NavigationController.dart';
import '../cart/controller/cart_controller.dart';
import '../common_widgets/quantity_widget.dart';

class ProductScreen extends StatefulWidget {
  final ItemsModels itemsModels = Get.arguments;

  ProductScreen({super.key});

  @override
  State<ProductScreen> createState() => _ProductScreenState();
}

class _ProductScreenState extends State<ProductScreen> {
  final UtilServices utilServices = UtilServices();

  final navigationController = Get.find<NavigationController>();
  final cartController = Get.find<CartController>();

  int valorInicial = 1;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white.withAlpha(230),
      body: Stack(
        children: [
          Column(
            children: [
              //Imagem do produto
              Expanded(
                child: Hero(
                  tag: widget.itemsModels.picture,
                  child: Image.network(widget.itemsModels.picture),
                ),
              ),

              //Informacoes do produto
              Expanded(
                child: Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius:
                          const BorderRadius.vertical(top: Radius.circular(50)),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withAlpha(600),
                          offset: const Offset(0, 2),
                        )
                      ],
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(25),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          //Nome produto - Quantidade
                          Row(
                            children: [
                              Expanded(
                                child: Text(
                                  widget.itemsModels.title,
                                  maxLines: 2,
                                  style: const TextStyle(
                                    fontSize: 27,
                                    fontWeight: FontWeight.bold,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ),
                              ),
                              QuantityWidget(
                              itemQuantity: valorInicial, 
                              uniy: widget.itemsModels.unit, 
                              value: (quantity) { 
                                setState((){
                                  valorInicial = quantity;
                                });
                                  
                               },),
                            ],
                          ),

                          //Preco
                          Text(
                            utilServices.priceToCurrency(widget.itemsModels.price),
                            style: TextStyle(
                              color: CustomColors.customSwatchColor,
                              fontSize: 23,
                            ),
                          ),

                          //Descreicao do produto
                          Expanded(
                            child: Padding(
                              padding: const EdgeInsets.symmetric(vertical: 10),
                              child: SingleChildScrollView(
                                child: Text(
                                  widget.itemsModels.description,
                                  style: const TextStyle(height: 1.5),
                                ),
                              ),
                            ),
                          ),

                          //Botao
                          SizedBox(
                            height: 45,
                            child: ElevatedButton.icon(
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.green,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(15),
                                ),
                              ),
                              onPressed: () {
                               
                                //Fechar a tela
                                Get.back();
                                
                                //Add produto no carrinho
                                cartController.addItemToCart(
                                  product: widget.itemsModels, 
                                  quantity: valorInicial
                                  );

                                //Ir para a tela de carrinho
                                navigationController.navegationPageview(NavegationTab.cart);
                                
                              },
                              icon: const Icon(Icons.shopping_cart_outlined,
                                  color: Colors.white),
                              label: const Text(
                                "Add no carrinho",
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                          )
                        ],
                      ),
                    )),
              )
            ],
          ),
          Positioned(
            left: 10,
            top: 10,
            child: SafeArea(
              child: IconButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                icon: const Icon(Icons.arrow_back_ios),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
