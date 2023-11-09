import 'package:flutter/material.dart';
import '../../../../config/custom_colors.dart';
import '../../../../models/cartModels.dart';
import '../../../../models/orderModels.dart';
import '../../../../services/UtilServices.dart';
import '../../../common_widgets/Payment_pix.dart';
import '../../controller/all_orderItemsController.dart';
import 'order_status_widget.dart';
import 'package:get/get.dart';

class OrderTile extends StatelessWidget {
  final OrderModels orderModel;

  OrderTile({
    Key? key,
    required this.orderModel,
  }) : super(key: key);

  final UtilServices utilServices = UtilServices();

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
      child: Theme(
          data: Theme.of(context).copyWith(dividerColor: Colors.transparent),
          child: GetBuilder<AllOrderItemsController>(
              init: AllOrderItemsController(orderModel),
              global: false,
              builder: (controller) {
                return ExpansionTile(
                  onExpansionChanged: (value) {
                    if (value) {
                      controller.getOrderItems();
                    }
                  },
                  //initiallyExpanded: orderModel.status == 'pending_payment',
                  title: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Pedido: ${orderModel.id}',
                          style:
                              TextStyle(color: CustomColors.customSwatchColor)),
                      Text(
                        utilServices.formatDateTime(orderModel.createdAt!),
                        style: const TextStyle(
                          fontSize: 12,
                          color: Colors.black,
                        ),
                      ),
                    ],
                  ),
                  childrenPadding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
                  expandedCrossAxisAlignment: CrossAxisAlignment.stretch,
                  children: controller.isLoading
                      ? [
                          Container(
                              alignment: Alignment.center,
                              height: 40,
                              child: const CircularProgressIndicator(),
                           
                          )
                        ]
                      : [
                          IntrinsicHeight(
                            child: Row(
                              children: [
                                // Lista de produtos
                                Expanded(
                                  flex: 3,
                                  child: SizedBox(
                                    height: 150,
                                    child: ListView(
                                      children:
                                          orderModel.itens.map((orderItem) {
                                        return _OrderItemWidget(
                                          utilServices: utilServices,
                                          orderItem: orderItem,
                                        );
                                      }).toList(),
                                    ),
                                  ),
                                ),

                                // Divisão
                                VerticalDivider(
                                  color: Colors.grey.shade300,
                                  thickness: 2,
                                  width: 8,
                                ),

                                // Status do pedido
                                Expanded(
                                  flex: 2,
                                  child: OrderStatusWidget(
                                    status: orderModel.status,
                                    isOverdue:
                                        orderModel.due.isBefore(DateTime.now()),
                                  ),
                                ),
                              ],
                            ),
                          ),

                          // Total
                          Text.rich(
                            TextSpan(
                              style: const TextStyle(
                                fontSize: 20,
                              ),
                              children: [
                                const TextSpan(
                                  text: 'Total ',
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                TextSpan(
                                  text: utilServices
                                      .priceToCurrency(orderModel.total),
                                ),
                              ],
                            ),
                          ),

                          // Botão pagamento
                          Visibility(
                            visible: orderModel.status == 'pending_payment' && !orderModel.isOverdue,
                            child: ElevatedButton.icon(
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.green,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(20),
                                ),
                              ),
                              onPressed: () {
                                showDialog(
                                  context: context,
                                  builder: (_) {
                                    return PaymentPix(
                                      orderModel: orderModel,
                                    );
                                  },
                                );
                              },
                              icon: Image.asset(
                                'assets/pix_image/pix.png',
                                height: 18,
                              ),
                              label: const Text('Ver QR Code Pix',
                                  style: TextStyle(color: Colors.white)),
                            ),
                          ),
                        ],
                );
              })),
    );
  }
}

class _OrderItemWidget extends StatelessWidget {
  const _OrderItemWidget({
    Key? key,
    required this.utilServices,
    required this.orderItem,
  }) : super(key: key);

  final UtilServices utilServices;
  final CartModels orderItem;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: Row(
        children: [
          Text(
            '${orderItem.quantity} ${orderItem.product.unit} ',
            style: const TextStyle(
              fontWeight: FontWeight.bold,
            ),
          ),
          Expanded(child: Text(orderItem.product.title)),
          Text(utilServices.priceToCurrency(orderItem.priceQuantity()))
        ],
      ),
    );
  }
}
