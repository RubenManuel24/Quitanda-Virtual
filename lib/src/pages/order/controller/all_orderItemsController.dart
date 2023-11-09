import 'package:get/get.dart';

import '../../../models/cartModels.dart';
import '../../../models/orderModels.dart';
import '../../../services/UtilServices.dart';
import '../../auth/controller/auth_controller.dart';
import '../repository/order_repository.dart';
import '../result/order_result.dart';

class AllOrderItemsController extends GetxController{
   OrderModels orderModel;
   AllOrderItemsController(this.orderModel);

  final orderRepository = OrderRepository();
  final utilService = UtilServices();
  final authController = Get.find<AuthController>();
  bool isLoading = false;

  void setLoading(bool value){
    isLoading = value;
    update();
  }

  Future<void> getOrderItems()async{
       
       setLoading(true);

      OrderResult<List<CartModels>> result = await orderRepository.getOrderItems(
      orderId:  orderModel.id, 
      token: authController.user.token!);

       setLoading(false);

      result.when(
        succe: (itens){
          orderModel.itens = itens;
          update();
        }, 
        error: (message){
          utilService.showToast(text: message, isError: true);
        }
      );

  }
  
}