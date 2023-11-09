import 'package:flutter/material.dart';
import 'package:get/get.dart';

abstract class NavegationTab{
  static const int home = 0;
  static const int cart = 1;
  static const int order = 2;
  static const int perfil = 3;
}

class NavigationController extends GetxController {
  late PageController _pageController;
  late RxInt _currentIndex;

  //Método para iniciar a navegação
  void _initNavigation({required PageController pageController, required int currentIndex}) {
    _pageController = pageController;
    _currentIndex = currentIndex.obs;
  }

  PageController get  pagecontroller => _pageController;
  int get currentIndex => _currentIndex.value;

  @override
  void onInit() {
    super.onInit();
    _initNavigation(
      pageController: PageController(initialPage: NavegationTab.home), 
      currentIndex: NavegationTab.home
    );
  }

  //Metodo para navegar entre as páginas
  void navegationPageview(int page){

    if(_currentIndex.value == page) return;

    _pageController.jumpToPage(page);
    _currentIndex.value = page;

  }


}
