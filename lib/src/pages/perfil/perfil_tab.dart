import 'package:json_annotation/json_annotation.dart';
import 'package:flutter/material.dart';
import '../../services/validators.dart';
import '../auth/controller/auth_controller.dart';
import 'package:get/get.dart';
import '../common_widgets/custom_text_field.dart';
import '../../config/appData.dart' as appData;

class PerfilTab extends StatefulWidget {
  const PerfilTab({super.key});

  @override
  State<PerfilTab> createState() => _PerfilTabState();
}

@JsonSerializable()
class _PerfilTabState extends State<PerfilTab> {
  final _formKey = GlobalKey<FormState>();
  final newPasswordController = TextEditingController();
  final currentPasswordController = TextEditingController();

  final authController = Get.find<AuthController>();
  Future<bool?> updatePassword() {
    return showDialog(
      context: context,
      builder: (context) {
        return Dialog(
          backgroundColor: Colors.white,
          child: Stack(
            children: [
              //Icon close
              Positioned(
                top: 5,
                right: 5,
                child: IconButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  icon: const Icon(Icons.close),
                ),
              ),

              Padding(
                padding: const EdgeInsets.fromLTRB(14, 20, 14, 14),
                child: Form(
                  key: _formKey,
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        //texto
                        const Padding(
                          padding: EdgeInsets.only(bottom: 14),
                          child: Text(
                            "Atualição de senha",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                fontSize: 18, fontWeight: FontWeight.bold),
                          ),
                        ),

                        //senha atual
                        CustomTextField(
                          controller: currentPasswordController,
                          isSecret: true,
                          icon: Icons.lock,
                          label: 'Senha atual',
                          validator: passWordValidator,
                        ),

                        //nova senha
                        CustomTextField(
                          controller: newPasswordController,
                          isSecret: true,
                          icon: Icons.lock_outline,
                          label: 'Nova senha',
                          validator: passWordValidator,
                        ),

                        //confirmar nova senha
                        CustomTextField(
                          isSecret: true,
                          icon: Icons.lock_outline,
                          label: 'Confirmar nova senha',
                          validator: (password) {
                            final result = passWordValidator(password);

                            if (result != null) {
                              return result;
                            }

                            if (password != newPasswordController.text) {
                              return "As senhas não são equivalentes";
                            }

                            return null;
                          },
                        ),

                        //botao atualizar
                        SizedBox(
                          height: 45,
                          child: Obx(() => ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: Colors.green,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(30),
                                  ),
                                ),
                                onPressed: authController.isLoandig.value
                                    ? null
                                    : () {
                                        if (_formKey.currentState!.validate()) {
                                          authController.changePassword(
                                              currentPassword:
                                                  currentPasswordController
                                                      .text,
                                              newPassword:
                                                  newPasswordController.text);
                                        }
                                      },
                                child: authController.isLoandig.value
                                    ? const CircularProgressIndicator()
                                    : Text(
                                        "Atualizar",
                                        style: TextStyle(color: Colors.white),
                                      ),
                              )),
                        )
                      ]),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.green,
        title: const Text(
          'Perfil do usuário',
          style: TextStyle(color: Colors.white),
        ),
        actions: [
          IconButton(
            onPressed: () {
              authController.signOut();
            },
            icon: const Icon(Icons.login_outlined, color: Colors.white),
          )
        ],
      ),
      body: ListView(
        padding: const EdgeInsets.fromLTRB(16, 32, 16, 0),
        children: [
          //E-mail
          CustomTextField(
            readOly: true,
            initialValue: authController.user.email,
            icon: Icons.email,
            label: 'E-mail',
          ),

          //Nome
          CustomTextField(
            readOly: true,
            initialValue: authController.user.name,
            icon: Icons.person,
            label: 'Nome',
          ),

          //Celular
          CustomTextField(
            readOly: true,
            initialValue: authController.user.phone,
            icon: Icons.phone,
            label: 'Celular',
          ),

          //CPF
          CustomTextField(
            readOly: true,
            initialValue: authController.user.cpf,
            icon: Icons.file_copy,
            label: 'CPF',
            isSecret: true,
          ),

          //Botao de atulizar senha
          SizedBox(
            height: 50,
            child: OutlinedButton(
              style: OutlinedButton.styleFrom(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20)),
                side: const BorderSide(color: Colors.green),
              ),
              onPressed: () {
                updatePassword();
              },
              child: const Text(
                "Atualizar senha",
                style: TextStyle(color: Colors.green),
              ),
            ),
          )
        ],
      ),
    );
  }
}
