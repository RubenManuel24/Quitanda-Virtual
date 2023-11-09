import 'package:json_annotation/json_annotation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';
import '../../../config/custom_colors.dart';
import '../../../services/validators.dart';
import '../../common_widgets/custom_text_field.dart';
import '../controller/auth_controller.dart';

@JsonSerializable()
class SingUpScreen extends StatelessWidget {
  const SingUpScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final cpfmaskFormatter = MaskTextInputFormatter(
        mask: '###.###.###-##', filter: {"#": RegExp(r'[0-9]')});
    final tlfmaskFormatter = MaskTextInputFormatter(
        mask: '###-###-###', filter: {"#": RegExp(r'[0-9]')});
    final size = MediaQuery.of(context).size;

    final _formKey = GlobalKey<FormState>();

    final authController = Get.find<AuthController>();

    return Scaffold(
      backgroundColor: CustomColors.customSwatchColor,
      body: SingleChildScrollView(
        child: SizedBox(
          height: size.height,
          width: size.width,
          child: Stack(
            children: [
              //Icon Arrow
              Positioned(
                left: 10,
                top: 10,
                child: SafeArea(
                  child: IconButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    icon: const Icon(Icons.arrow_back_ios, color: Colors.white),
                  ),
                ),
              ),

              Column(
                children: [
                  const Expanded(
                    child: Center(
                      child: Text(
                        "Cadastro",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 35,
                        ),
                      ),
                    ),
                  ),

                  // Formulario
                  Container(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 32, vertical: 40),
                    decoration: const BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.vertical(
                        top: Radius.circular(
                          45,
                        ),
                      ),
                    ),
                    child: Form(
                      key: _formKey,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          CustomTextField(
                              textInputType: TextInputType.emailAddress,
                              icon: Icons.email,
                              label: 'Email',
                              validator: emailValidator,
                              onSaved: (email) {
                                authController.user.email = email;
                              }),
                          CustomTextField(
                              icon: Icons.lock,
                              label: 'Senha',
                              isSecret: true,
                              validator: passWordValidator,
                              onSaved: (password) {
                                authController.user.password = password;
                              }),
                          CustomTextField(
                              icon: Icons.person,
                              label: 'Nome',
                              validator: nameValidator,
                              onSaved: (name) {
                                authController.user.name = name;
                              }),
                          CustomTextField(
                              textInputType: TextInputType.phone,
                              textInputFormatter: [tlfmaskFormatter],
                              icon: Icons.phone,
                              label: 'Celular',
                              validator: phoneValidator,
                              onSaved: (phone) {
                                authController.user.phone = phone;
                              }),
                          CustomTextField(
                              textInputType: TextInputType.number,
                              textInputFormatter: [cpfmaskFormatter],
                              icon: Icons.file_copy,
                              label: 'CPF',
                              validator: cpfValidator,
                              onSaved: (cpf) {
                                authController.user.cpf = cpf;
                              }),
                          SizedBox(
                            height: 40,
                            child: Obx(() => ElevatedButton(
                                   onPressed: authController.isLoandig.value
                                      ? null
                                      : () {
                                          
                                          FocusScope.of(context).unfocus();

                                          if (_formKey.currentState!.validate()) {
                                            _formKey.currentState!.save();
                                            print(authController.user);
                                            authController.signUp();
                                          }
                                        },
                                  child: authController.isLoandig.value
                                      ? const CircularProgressIndicator()
                                      : const Text(
                                          "Cadastrar usuário",
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 16),
                                        ),
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: Colors.green,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                  ),
                                )),
                          )
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
