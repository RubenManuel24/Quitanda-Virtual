import 'package:json_annotation/json_annotation.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:add_to_cart_animation/add_to_cart_animation.dart';
import 'package:add_to_cart_animation/add_to_cart_icon.dart';
import 'package:flutter/material.dart';
import 'package:badges/badges.dart' as badges;
import '../../../config/custom_colors.dart';
import '../../../config/appData.dart' as appData;
import '../../base/controller/NavigationController.dart';
import '../../cart/controller/cart_controller.dart';
import '../../common_widgets/app_name_widget.dart';
import '../../common_widgets/custom_shimmer.dart';
import 'components/CategoryTile.dart';
import 'components/item_tile.dart';
import 'package:get/get.dart';

import '../controllers/home_controller.dart';

class HomeTab extends StatefulWidget {
  const HomeTab({super.key});

  @override
  State<HomeTab> createState() => _HomeTabState();
}

@JsonSerializable()
class _HomeTabState extends State<HomeTab> {
  GlobalKey<CartIconKey> globalKeyCartItems = GlobalKey<CartIconKey>();

  final controller = Get.find<CartController>();
  final controllerNavigation = Get.find<NavigationController>();

  late Function(GlobalKey) runAddToCardAnimation;

  final searchController = TextEditingController();

  void itemSelectCartAnimations(GlobalKey keyImagem) {
    runAddToCardAnimation(keyImagem);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //App Bar
      appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          centerTitle: true,
          title: const AppNameWidget(),
          actions: [
            //carrinho de add
            Padding(
                padding: EdgeInsets.only(right: 18),
                child: GetBuilder<CartController>(
                  builder: (controller) {
                    return GestureDetector(
                      onTap: () {

                        controllerNavigation.navegationPageview( NavegationTab.cart);

                      },
                      child: badges.Badge(
                        position:
                            badges.BadgePosition.topEnd(top: -10, end: -12),
                        badgeContent: Text(
                          controller.getCartTotalItems().toString(),
                          style: TextStyle(color: Colors.white, fontSize: 12),
                        ),
                        badgeStyle: badges.BadgeStyle(
                            badgeColor: CustomColors.customContrastColor),
                        child: AddToCartIcon(
                          key: globalKeyCartItems,
                          icon: Icon(
                            Icons.shopping_cart,
                            color: CustomColors.customSwatchColor,
                          ),
                        ),
                      ),
                    );
                  },
                )),
          ]),
      body: AddToCartAnimation(
        gkCart: globalKeyCartItems,
        previewCurve: Curves.linearToEaseOut,
        previewDuration: const Duration(milliseconds: 200),
        receiveCreateAddToCardAnimationMethod: (addToCardAnimationMethod) {
          runAddToCardAnimation = addToCardAnimationMethod;
        },
        child: Column(
          children: [
            //Campo pesquisa
            GetBuilder<HomeController>(
              builder: (controllerTextField) {
                return Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 20,
                    vertical: 10,
                  ),
                  child: TextFormField(
                    controller: searchController,
                    onChanged: (value1) {
                      controllerTextField.searchTitle.value = value1;
                    },
                    decoration: InputDecoration(
                        filled: true,
                        fillColor: Colors.white,
                        prefixIcon: Icon(
                          Icons.search,
                          color: CustomColors.customContrastColor,
                          size: 21,
                        ),
                        suffixIcon: controllerTextField
                                .searchTitle.value.isNotEmpty
                            ? IconButton(
                                onPressed: () {
                                  searchController.clear();
                                  controllerTextField.searchTitle.value = "";
                                  FocusScope.of(context).unfocus();
                                },
                                icon: Icon(Icons.clear,
                                    color: CustomColors.customContrastColor,
                                    size: 21),
                              )
                            : null,
                        isDense: true,
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(60),
                            borderSide: const BorderSide(
                              width: 0,
                              style: BorderStyle.none,
                            ))),
                  ),
                );
              },
            ),

            //Categorias
            GetBuilder<HomeController>(builder: (controller) {
              return Padding(
                padding: const EdgeInsets.only(left: 20, right: 15),
                child: SizedBox(
                  height: 40,
                  child: !controller.isCategoryLoading
                      ? ListView.separated(
                          scrollDirection: Axis.horizontal,
                          itemBuilder: (_, index) {
                            return CategoryTile(
                              onpress: () {
                                controller.selectCategory(
                                    controller.listCategory[index]);
                              },
                              categotiaName:
                                  controller.listCategory[index].title,
                              isSelect: controller.currentCategory ==
                                  controller.listCategory[index],
                            );
                          },
                          separatorBuilder: (_, index) =>
                              const SizedBox(width: 10),
                          itemCount: controller.listCategory.length,
                        )
                      : ListView(
                          scrollDirection: Axis.horizontal,
                          children: List.generate(
                            10,
                            (index) => Container(
                              padding: const EdgeInsets.only(right: 10),
                              alignment: Alignment.center,
                              child: CustomShimmer(
                                height: 20,
                                width: 80,
                                borderRadius: BorderRadius.circular(20),
                              ),
                            ),
                          ),
                        ),
                ),
              );
            }),

            //Grid
            GetBuilder<HomeController>(
              builder: (controller) {
                return Expanded(
                  child: !controller.isProdutLoading
                      ? Visibility(
                          visible: (controller.currentCategory?.itens ?? [])
                              .isNotEmpty,
                          replacement: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(
                                Icons.search_off,
                                color: CustomColors.customSwatchColor,
                                size: 40,
                              ),
                              const Text("Não há itens para representar!")
                            ],
                          ),
                          child: GridView.builder(
                            padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
                            physics: const BouncingScrollPhysics(),
                            gridDelegate:
                                const SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 2,
                              mainAxisSpacing: 10,
                              crossAxisSpacing: 10,
                              childAspectRatio: 9 / 11.5,
                            ),
                            itemCount: controller.allProduts.length,
                            itemBuilder: (_, index) {
                              //Lógica para saber se está apresentado ultimo item na tela.
                              if (((index + 1) ==
                                      controller.allProduts.length) &&
                                  !controller.isLastPage) {
                                controller.loadMoreProducts();
                              }

                              return ItemTile(
                                  itemsModels: controller.allProduts[index],
                                  cartAnimationMethod:
                                      itemSelectCartAnimations);
                            },
                          ),
                        )
                      : GridView.count(
                          padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
                          physics: const BouncingScrollPhysics(),
                          crossAxisCount: 2,
                          mainAxisSpacing: 10,
                          crossAxisSpacing: 10,
                          childAspectRatio: 9 / 11.5,
                          children: List.generate(
                            10,
                            (index) => CustomShimmer(
                              height: double.infinity,
                              width: double.infinity,
                              borderRadius: BorderRadius.circular(20),
                            ),
                          )),
                );
              },
            )
          ],
        ),
      ),
    );
  }
}
