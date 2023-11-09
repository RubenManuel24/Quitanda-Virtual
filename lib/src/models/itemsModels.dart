class ItemsModels {
  String id;
  String description;
  String title;
  String picture;
  double price;
  String unit;
  
  ItemsModels({
    this.id = " ",
    required this.description,
    required this.title,
    required this.picture,
    required this.price,
    required this.unit,
  });
 
   factory ItemsModels.fromMap(Map<String, dynamic> map){
    return ItemsModels(
       id: map["id"],
       description: map["description"],
       title: map["title"],
       picture: map["picture"],
       price: map["price"],
       unit: map["unit"]
    );
   }

   Map<String, dynamic> toMap(){
    return {
      "id": id,
      "description": description,
      "title": title,
      "picture": picture,
      "price": price,
      "unit": unit
    };
   }

   
  @override
  String toString() {
  
    return "Title: $title | Price: $price | Unit: $unit | Description: $description";
  }

}
