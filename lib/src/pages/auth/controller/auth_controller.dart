import 'package:get/get.dart';

import '../../../constants/storage_key.dart';
import '../../../models/userModels.dart';
import '../../../page_routes/app_pages.dart';
import '../../../services/UtilServices.dart';
import '../repository/auth_repository.dart';
import '../result/auth_result.dart';

class AuthController extends GetxController {
  
  RxBool isLoandig = false.obs;
  
  final authRepository = AuthRepository();
  final utilServices = UtilServices();

   UserModel user = UserModel();

   //@override
   //void onInit(){
   //super.onInit();
   
   // validateToken();
     
   //}

  Future<void> validateToken()async{

    // Recuperar o token que foi salvo localmente
    String? token = await utilServices.getLocalData(key: StorageKey.tokenKey);

    if(token == null){
       Get.offAllNamed(PageRoutes.signInRoute);
       return;
    }

    AuthResult result = await authRepository.validateToken(token);

    result.when(
    sucess: (user){
      this.user = user;
      Get.offAllNamed(PageRoutes.baseRoute);

    }, 
    error:(error){
       signOut();
    });
    
  }


  Future<void> changePassword({required String currentPassword, required String newPassword}) async {

    isLoandig.value = true;

   final result = await authRepository.changePassword(
      email: user.email!, 
      currentPassword: currentPassword, 
      newPassword: newPassword, 
      token: user.token!
      );

      isLoandig.value = false;

    if(result){
      utilServices.showToast(text: "A senha foi atualizada com sucesso!");
      signOut();
    }
    else{
       utilServices.showToast(text: "A senha a senha atual está incorreta!", isError: true);
    }

  }



  Future<void> signOut()async{
    //Zeraro user
    this.user = UserModel();

    // Remover o token
    utilServices.removeLocalData(key: StorageKey.tokenKey);

    //Ir para o SignIn
    Get.offAllNamed(PageRoutes.signInRoute);
  }
  
  void saveTokenAndProceedToBase(){

    // Salva o token
    utilServices.salveLocalData(key: StorageKey.tokenKey, data: user.token!);

    // Ir para a base
     Get.offAllNamed(PageRoutes.baseRoute);
     
  }


  Future<void> signUp()async{
    isLoandig.value = true;

    //Validação no Back-End
    AuthResult authResult = await authRepository.signUp(user);

    isLoandig.value = false;

    authResult.when(
      sucess: (user){
        this.user = user;

        saveTokenAndProceedToBase();  
      }, 
      error: (error){
        utilServices.showToast(text: error, isError: true);
      }
    );

  }

  Future<void> signIn({required String email, required String passWord}) async {
    isLoandig.value = true;

    //Validação no Back-End
    AuthResult authResult = await authRepository.signin(email: email, password: passWord);

    isLoandig.value = false;

    authResult.when(
      sucess: (user) {
        this.user = user;

        saveTokenAndProceedToBase();
      }, 
      error: (error) {
        utilServices.showToast(text: error, isError: true);
      }
    );
  }

   Future<void> resetPassWord(String email)async{

     await authRepository.resetPassword(email);

   }
}
