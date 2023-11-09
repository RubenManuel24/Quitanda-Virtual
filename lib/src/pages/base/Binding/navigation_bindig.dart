import 'package:get/get.dart';

import '../controller/NavigationController.dart';

class NavigationBindig extends Bindings{
  @override
  void dependencies() {
   Get.lazyPut(() => NavigationController());
  }

}