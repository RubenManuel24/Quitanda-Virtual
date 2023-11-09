import 'package:json_annotation/json_annotation.dart';
import 'package:get/get.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:app_quitamda_virtual/src/services/UtilServices.dart';
import 'package:flutter/material.dart';
import '../../../config/custom_colors.dart';
// ignore: library_prefixes
import '../../../config/appData.dart' as appData;
import '../../../models/cartModels.dart';
import '../../common_widgets/Payment_pix.dart';
import '../controller/cart_controller.dart';
import 'component/cart_tile.dart';

class CartScreen extends StatefulWidget {
  const CartScreen({super.key});

  @override
  State<CartScreen> createState() => _CartScreenState();
}
class _CartScreenState extends State<CartScreen> {
  UtilServices utilServices = UtilServices();
  final controller = Get.find<CartController>();

  Future<bool?> showDialogConfirm() {
    return showDialog<bool?>(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text(
            "Confirmação",
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          content: const Text(
            "Deseja realmente concluir o pedido?",
            style: TextStyle(fontSize: 13),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(false);
              },
              child: const Text(
                "Não",
                style: TextStyle(color: Colors.green),
              ),
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(backgroundColor: Colors.green),
              onPressed: () {
                Navigator.of(context).pop(true);
              },
              child: const Text(
                "Sim",
                style: TextStyle(color: Colors.white),
              ),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.green,
        title: const Text(
          "Carrrinho",
          style: TextStyle(color: Colors.white),
        ),
      ),
      body: Column(
        children: [
          Expanded(
            child: GetBuilder<CartController>(
              builder: (controller) {
                return ListView.builder(
                  itemCount: controller.cartModels.length,
                  itemBuilder: (_, index) {
                    return CartTile(
                      cartModels: controller.cartModels[index],
                      remove: (CartModels cartModels) {},
                    );
                  },
                );
              },
            ),
          ),
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
                color: Colors.white,
                borderRadius:
                    const BorderRadius.vertical(top: Radius.circular(30)),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.shade300,
                    blurRadius: 3,
                    spreadRadius: 2,
                  )
                ]),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                const Text(
                  "Total geral",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 12),
                ),
                GetBuilder<CartController>(
                  builder: (controller) {
                    return Text(
                      utilServices.priceToCurrency(controller.priceTotal()),
                      style: TextStyle(
                          color: CustomColors.customSwatchColor, fontSize: 23),
                    );
                  },
                ),
                SizedBox(
                  height: 50,
                  child: GetBuilder<CartController>(
                    builder: (controller) {
                      return ElevatedButton(
                                      style: ElevatedButton.styleFrom(
                                        backgroundColor: Colors.green,
                                        shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(18),
                                        ),
                                      ),
                                      onPressed:controller.isCheckoutLoading
                                       ? null
                                       : () async {
                                        bool? result;
                  
                                        result = await showDialogConfirm();
                  
                                        if (result ?? false) {
                                          // ignore: use_build_context_synchronously
                                          controller.checkout();
                                        } else {
                                          utilServices.showToast(text: "Pedido não confirmado");
                                        }
                                        
                                      },
                                      child: controller.isCheckoutLoading 
                                      ? const CircularProgressIndicator()
                                      :const Text(
                                        "Concluir pedido",
                                        style: TextStyle(color: Colors.white, fontSize: 18),
                                      ),
                                    ); 
                    },
                  ),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}