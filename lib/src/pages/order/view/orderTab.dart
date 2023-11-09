import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../config/appData.dart' as appData;
import '../controller/order_controller.dart';
import 'components/order_tile.dart';

class OrderTab extends StatelessWidget {
  const OrderTab({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.green,
          title: const Text(
            "Pedidos",
            style: TextStyle(color: Colors.white),
          ),
        ),
        body: GetBuilder<OrderController>(
          builder: (controller) {
            return RefreshIndicator(
              onRefresh: () => controller.getAllOrders(),
              child: ListView.separated(
                padding: const EdgeInsets.all(16),
                physics: const AlwaysScrollableScrollPhysics(),
                itemCount: controller.listOrder1.length,
                separatorBuilder: (_, index) => const SizedBox(height: 12),
                itemBuilder: (_, index) {
                  return OrderTile(orderModel: controller.listOrder1[index]);
                },
              ),
            );
          },
        ));
  }

  @override
  List<Object?> get props => [];
}
