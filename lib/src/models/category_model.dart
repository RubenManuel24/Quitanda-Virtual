import 'package:app_quitamda_virtual/src/models/itemsModels.dart';

class CategoryModel {
  String title;
  String id;
  List<ItemsModels> itens;
  int pagination;

    CategoryModel({
    required this.title,
    required this.id,
    required this.itens,
    required this.pagination
  });

  factory CategoryModel.fromMap(Map<String, dynamic> map) {
    return CategoryModel(
      title: map["title"],
      id: map["id"],
      itens: (map["itens"] as List<dynamic>?)?.map((e) => ItemsModels.fromMap(e as Map<String, dynamic> )).toList() ?? [],
      pagination: map["numberPage"] ?? 0
    );
  }

  Map<String, dynamic> toMap() {
    return {"title": title, "id": id};
  }

  @override
  String toString() {
    return 'CategoryModel{title=$title, id=$id, itens=$itens}';
  }
  CategoryModel copyWith({
    String? title,
    String? id,
    List<ItemsModels>? itens,
    int? pagination    
  }) {
    return CategoryModel(
          title: title ?? this.title,
      id: id ?? this.id,
      itens: itens ?? this.itens,
      pagination: pagination ?? this.pagination
    );
  }
}
