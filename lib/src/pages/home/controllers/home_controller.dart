import 'package:json_annotation/json_annotation.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:app_quitamda_virtual/src/models/itemsModels.dart';
import 'package:get/get.dart';
import '../../../models/category_model.dart';
import '../../../services/UtilServices.dart';
import '../repository/home_repository.dart';
import '../result/home_result.dart';

@JsonSerializable()
class HomeController extends GetxController {
  final homeRepository = HomeRepository();
  final utilServices = UtilServices();

  final RxString searchTitle = "".obs;

  List<CategoryModel> listCategory = [];

  bool isCategoryLoading = false;
  bool isProdutLoading = true;
  int itemsPerPage = 6;
  CategoryModel? currentCategory;

  List<ItemsModels> get allProduts => currentCategory?.itens ?? [];

  //Lógica para saber se estamos na última página ou não
  bool get isLastPage {
    if (currentCategory!.itens.length < itemsPerPage) return true;
    return currentCategory!.pagination * itemsPerPage > allProduts.length;
  }

  void selectCategory(CategoryModel category) {
    currentCategory = category;
    update();

    if (currentCategory!.itens.isNotEmpty) return;
    getAllProduts(canLaod: false);
  }

  void setCategoryLoading(bool value) {
    isCategoryLoading = value;
    update();
  }

  void setProdutLoading(bool value) {
    isProdutLoading = value;
    update();
  }

  void loadMoreProducts() {
    currentCategory!.pagination++;
    getAllProduts(canLaod: false);
  }

  @override
  void onInit() {
    super.onInit();

    debounce(
      searchTitle,
      (_) { filterByTitle(); }, 
      time: const Duration(milliseconds: 800),
    );

    getAllCategories();
  }

  void filterByTitle() {
    //Apagar todas as categorias
    for (var category in listCategory) {
      category.itens.clear();
      category.pagination = 0;
    }

    if (searchTitle.value.isEmpty) {
      listCategory.removeAt(0);
    } else {

      CategoryModel? c = listCategory.firstWhereOrNull((cat) => cat.id == "");

      if(c == null){

      // Criar uma nova categoria com todos os produtos
      final allProductCategory = CategoryModel(
            title: "Todos", 
            id: "", itens: [], 
            pagination: 0
          );

      listCategory.insert(0, allProductCategory);

      }else{
        c.itens.clear();
        c.pagination = 0;
      }

    }

     currentCategory = listCategory.first;

     update();

     getAllProduts();

  }

  Future<void> getAllCategories() async {
    setCategoryLoading(true);
    HomeResult<CategoryModel> result = await homeRepository.getAllCategories();
    setCategoryLoading(false);

    result.when(sucess: (data) {
      listCategory.assignAll(data);

      if (listCategory.isEmpty) return;
      selectCategory(listCategory.first);
    }, error: (message) {
      utilServices.showToast(text: message);
    });
  }

  Future<void> getAllProduts({bool canLaod = true}) async {
    if (canLaod) {
      setProdutLoading(true);
    }
     
    Map<String, dynamic> body = {
      "page": currentCategory!.pagination,
      "categoryId": currentCategory!.id,
      "itemsPerPage": itemsPerPage,
    };
     
     if(searchTitle.value.isNotEmpty){
        body["title"] = searchTitle.value;

        if(currentCategory!.id == ""){
           body.remove("categoryId");
        }
     }


    HomeResult<ItemsModels> result = await homeRepository.getAllProduts(body);
    setProdutLoading(false);

    result.when(sucess: (data) {
      currentCategory!.itens.addAll(data);
    }, error: (message) {
      utilServices.showToast(text: message);
    });
  }
}
