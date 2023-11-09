import 'package:flutter/material.dart';
import 'package:get/get.dart' as a;
import 'package:get/get.dart';
import '../cart/view/cart_tab.dart';
import '../home/view/home_tab.dart';
import '../order/view/orderTab.dart';
import '../perfil/perfil_tab.dart';
import 'controller/NavigationController.dart';

class BaseScreen extends StatefulWidget {
  const BaseScreen({super.key});

  @override
  State<BaseScreen> createState() => _BaseScreenState();
}

class _BaseScreenState extends State<BaseScreen> {
  
  final navigationController = Get.find<NavigationController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: PageView(
          controller: navigationController.pagecontroller,
          physics: const NeverScrollableScrollPhysics(),
          children: const [
            HomeTab(), 
            CartScreen(), 
            OrderTab(), 
            PerfilTab()
          ],
        ),
        bottomNavigationBar: Obx(
          () => BottomNavigationBar(

          currentIndex: navigationController.currentIndex,
          onTap: (index) {
           
                navigationController.navegationPageview(index);
                navigationController.pagecontroller.animateToPage(
                  index,
                  duration: const Duration(milliseconds: 700),
                  curve: Curves.bounceIn,
                );
           
          },
          type: BottomNavigationBarType.fixed,
          backgroundColor: Colors.green,
          selectedItemColor: Colors.white,
          unselectedItemColor: Colors.white.withAlpha(100),
          items: const [
            BottomNavigationBarItem(
              icon: Icon(Icons.home_outlined),
              label: "Home",
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.shopping_cart_outlined),
              label: "Carrinho",
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.list),
              label: "Pedidos",
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.person_outlined),
              label: "Perfil",
            ),
          ],
        ))
        
        );
  }

@override
List<Object?> get props => [navigationController];
}
