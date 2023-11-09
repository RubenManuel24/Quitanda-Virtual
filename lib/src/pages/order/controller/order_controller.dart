import 'package:json_annotation/json_annotation.dart';
import 'package:get/get.dart';
import '../../../models/orderModels.dart';
import '../../../services/UtilServices.dart';
import '../../auth/controller/auth_controller.dart';
import '../repository/order_repository.dart';
import '../result/order_result.dart';

class OrderController extends GetxController{
 final _orderRepository = OrderRepository();
 final authController = Get.find<AuthController>();
 UtilServices _utilServices = UtilServices();

 List<OrderModels> listOrder1 = [];

 @override
 onInit(){
  super.onInit();
  getAllOrders();
 }


  Future<void> getAllOrders()async{

    OrderResult<List<OrderModels>> result = await _orderRepository.getAllOrder(
      user: authController.user.id!, 
      token: authController.user.token!
      );

     result.when(
      succe:(listOrder2){
        listOrder1 = listOrder2..sort((a, b) => b.createdAt!.compareTo(a.createdAt!));
        update();

      }, 
      error: (message){
        _utilServices.showToast(text: message);
      }
      );
  }

}