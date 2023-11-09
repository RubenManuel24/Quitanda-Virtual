import 'package:app_quitamda_virtual/src/pages/product/product_screen.dart';
import 'package:get/get.dart';

import '../pages/SplashScreen/splashScreen.dart';
import '../pages/auth/view/sign_in_screen.dart';
import '../pages/auth/view/sing_up_screen.dart';
import '../pages/base/Binding/navigation_bindig.dart';
import '../pages/base/base_screen.dart';
import '../pages/cart/binding/cart_bindig.dart';
import '../pages/home/binding/home_binding.dart';
import '../pages/order/binding/order_binding.dart';

abstract class AppPages{

  static final pages = <GetPage>[

     GetPage(
      name:PageRoutes.productRoute,
      page: () =>  ProductScreen(),
     ),

     GetPage(
      name: PageRoutes.splashRoute, 
      page: () => const SplashScreen(),
     ),
     
     GetPage(
      name: PageRoutes.signInRoute, 
      page: () =>  SignInScreen(),
     ),

     GetPage(
      name: PageRoutes.sinUpRoute, 
      page: () => const SingUpScreen(),
     ),

     GetPage(
      name: PageRoutes.baseRoute , 
      page: () => const BaseScreen(),
      bindings:[
        NavigationBindig(),
        HomeBinding(),
        CartBinding(),
        OrderBinding()
      ]
     ),


  ];
}


abstract class PageRoutes{

  static const String splashRoute = '/splash';
  static const String signInRoute = '/signin';
  static const String sinUpRoute = '/signup';
  static const String baseRoute = '/base';
  static const String productRoute = '/product';

}


