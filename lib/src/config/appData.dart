import 'package:app_quitamda_virtual/src/models/itemsModels.dart';
import '../models/cartModels.dart';
import '../models/orderModels.dart';
import '../models/userModels.dart';


final apple = ItemsModels(
  description:
      'A melhor mãça da região e que conta com omelhor preço de qualquer quitanda. Este item conta com vitaminas essenciais para o fortalecimento corporal, resultando em uma vida saudável.',
  title: 'Mãça',
  picture: 'assets/frutas/apple.png',
  price: 5.5,
  unit: 'kg',
);

final grape = ItemsModels(
  description:
      'A melhor uva da região e que conta com omelhor preço de qualquer quitanda. Este item conta com vitaminas essenciais para o fortalecimento corporal, resultando em uma vida saudável.',
  title: 'Uva',
  picture: 'assets/frutas/grape.png',
  price: 7.4,
  unit: 'kg',
);

final guava = ItemsModels(
  description:
      'A melhor goiaba da região e que conta com omelhor preço de qualquer quitanda. Este item conta com vitaminas essenciais para o fortalecimento corporal, resultando em uma vida saudável.',
  title: 'Goiaba',
  picture: 'assets/frutas/guava.png',
  price: 11.5,
  unit: 'kg',
);

final kiwi = ItemsModels(
  description:
      'A melhor kiwi da região e que conta com omelhor preço de qualquer quitanda. Este item conta com vitaminas essenciais para o fortalecimento corporal, resultando em uma vida saudável.',
  title: 'Kiwi',
  picture: 'assets/frutas/kiwi.png',
  price: 2.5,
  unit: 'kg',
);

final mango = ItemsModels(
  description:
      'A melhor Manga da região e que conta com omelhor preço de qualquer quitanda. Este item conta com vitaminas essenciais para o fortalecimento corporal, resultando em uma vida saudável.',
  title: 'Manga',
  picture: 'assets/frutas/mango.png',
  price: 2.5,
  unit: 'kg',
);

final papaya = ItemsModels(
  description:
      'A melhor Mamão da região e que conta com omelhor preço de qualquer quitanda. Este item conta com vitaminas essenciais para o fortalecimento corporal, resultando em uma vida saudável.',
  title: 'Mamão',
  picture: 'assets/frutas/papaya.png',
  price: 8,
  unit: 'kg',
);

// Lista de produtos
List<ItemsModels> itensFrute = [apple, grape, guava, kiwi, mango, papaya];

//Lista de categorias
List<String> categories = [
  "Frutas",
  "Temperos",
  "Grãos",
  "Sereais",
  "Verduras",
  "Carnes",
];

// List<CartModels> cartmodels = [
//   CartModels(product: kiwi, quantity: 1),
//   CartModels(product: papaya, quantity: 10),
//   CartModels(product: apple, quantity: 1),
//   CartModels(product: mango, quantity: 10),
//   CartModels(product: guava, quantity: 1),
// ];

UserModel userModel = UserModel(
  name: 'Ruben Manuel',
  email: 'rubenmanuel@gmail.com',
  phone: '999-999-999',
  cpf: '000-000-000-00',
);

List<OrderModels> itemOrder = [

  // OrderModels(
  //   id: "q1w2e3r4eu2", 
  //   createdDateTime: DateTime.parse("2023-09-04 10:00:10.300"), 
  //   orderDateTime: DateTime.parse("2023-09-04 11:00:10.300"), 
  //   items: [
     
      
  //   ], 
  //   status: "pending_payment", 
  //   copyAndPaste: "as34id4k3", 
  //   total: 0
  //   ),

  // OrderModels(
  //   id: "q1w2e3r4eu2", 
  //   createdDateTime: DateTime.parse("2023-10-04 13:00:10.100"), 
  //   orderDateTime: DateTime.parse("2023-10-04 17:00:10.100"), 
  //   items: [
     
//     ], 
//     status: "refunded", 
//     copyAndPaste: "as2d6id3", 
//     total: 0
//     ),

// OrderModels(
//   id: "q1w2e3r4eu2", 
//     createdDateTime: DateTime.parse("2023-10-06 16:00:10.100"), 
//     orderDateTime: DateTime.parse("2023-10-08 17:00:10.100"), 
//     items: [

      
//     ], 
//     status: "delivered", 
//     copyAndPaste: "co4di94j5", 
//     total: 0
//     )

];
