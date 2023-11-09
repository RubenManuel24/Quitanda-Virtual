import 'cartModels.dart';

class OrderModels {
  String id;
  double total;
  String qrCodeImage;
  String copiaecola;
  String status;
  DateTime? createdAt;
  DateTime due;
  List<CartModels> itens;

      OrderModels({
    required this.id,
    required this.total,
    required this.qrCodeImage,
    required this.copiaecola,
    required this.status,
    required this.due,
    required this.itens,
    this.createdAt
  });

  bool get isOverdue => due.isBefore(DateTime.now());
 
  factory OrderModels.fromMap(Map<String, dynamic> map){
    return OrderModels(
       id: map["id"],
       total: map["total"],
       qrCodeImage: map["qrCodeImage"],
       copiaecola: map["copiaecola"],
       status: map["status"],
       due: DateTime.parse(map["due"]),
       itens: (map["itens"] as List<dynamic>?)?.map((e) => CartModels.fromMap(e as Map<String, dynamic> )).toList() ?? [],
       createdAt: map["createdAt"] == null 
            ? null 
            : DateTime.parse(map["createdAt"])
    );
  }

  Map<String, dynamic> toMap(){
   return {
     "id": id,
     "total": total,
     "qrCodeImage": qrCodeImage,
     "copiaecola": copiaecola,
     "status": status,
     "due": due,
     "itens": itens,
     "createdAt": createdAt,
   };
  }


  @override
  String toString() {
    return 'OrderModels(id: $id, total: $total, qrCodeImage: $qrCodeImage, copiaecola: $copiaecola, status: $status, createdAt: $createdAt, due: $due, itens: $itens)';
  }
}

