// ignore_for_file: public_member_api_docs, sort_constructors_first
class UserModel {
  String? id;
  String? name;
  String? email;
  String? password;
  String? phone;
  String? cpf;
  String? token;

  UserModel({
     this.id,
     this.name,
     this.email,
     this.password,
     this.phone,
     this.cpf,
     this.token,
  });


  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
        id: map["id"],
        name: map["fullname"],
        email: map["email"],
        password: map["password"],
        phone: map["phone"],
        cpf: map["cpf"],
        token: map["token"]);
  }

  Map<String, dynamic> toMap(){
    return {
      "id": id,
      "fullname": name,
      "email": email ,
      "password": password,
      "phone": phone,
      "cpf": cpf,
      "token": token
    };
  }
}
