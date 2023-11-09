import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:app_quitamda_virtual/src/services/UtilServices.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../config/custom_colors.dart';
import '../../../page_routes/app_pages.dart';
import '../../../services/validators.dart';
import '../../common_widgets/app_name_widget.dart';
import '../../common_widgets/custom_text_field.dart';
import '../controller/auth_controller.dart';
import 'components/forgot_password_dialog.dart';

// ignore: must_be_immutable
class SignInScreen extends StatelessWidget {
  SignInScreen({super.key});

  final emailController = TextEditingController();
  final passWordController = TextEditingController();

  final _formKey = GlobalKey<FormState>();

  UtilServices utilServices = UtilServices();

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: CustomColors.customSwatchColor,
      body: SingleChildScrollView(
        child: SizedBox(
          height: size.height,
          width: size.width,
          child: Column(
            children: [
              Expanded(
                  child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  GestureDetector(
                    onTap: () {
                      utilServices.showToast(text: "Logotipo da empresa");
                    },
                    child: const AppNameWidget(
                      sizeGreen: 40,
                      colorGreen: Colors.white,
                    ),
                  ),
                  SizedBox(
                    height: 22,
                    child: DefaultTextStyle(
                      style: const TextStyle(color: Colors.white, fontSize: 18),
                      child: AnimatedTextKit(
                        pause: Duration.zero,
                        repeatForever: true,
                        animatedTexts: [
                          FadeAnimatedText('Frutas'),
                          FadeAnimatedText('Legumes'),
                          FadeAnimatedText('Carnes'),
                          FadeAnimatedText('Grão'),
                          FadeAnimatedText('Temperos'),
                          FadeAnimatedText('Sereais')
                        ],
                      ),
                    ),
                  )
                ],
              )),

              //formulario
              Container(
                padding:
                    const EdgeInsets.symmetric(vertical: 32, horizontal: 40),
                decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.vertical(
                    top: Radius.circular(45),
                  ),
                ),
                child: Form(
                  key: _formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      //Email
                      CustomTextField(
                          textInputType: TextInputType.emailAddress,
                          controller: emailController,
                          icon: Icons.email,
                          label: 'E-mail',
                          validator: emailValidator
                          ),

                      //senha
                      CustomTextField(
                          controller: passWordController,
                          isSecret: true,
                          icon: Icons.lock,
                          label: 'Senha',
                          validator: passWordValidator
                          ),

                      const SizedBox(height: 3),

                      //Buttom entrar
                      SizedBox(
                        height: 40,
                        child: GetX<AuthController>(
                          builder: (authController) {
                            return ElevatedButton(
                              onPressed: authController.isLoandig.value
                                  ? null
                                  : () {

                                      FocusScope.of(context).unfocus();

                                      if (_formKey.currentState!.validate()) {
                                        String email = emailController.text;
                                        String passWord = passWordController.text;

                                        authController.signIn(
                                            email: email, passWord: passWord);
                                      } else {
                                        print("Os dados não passaram!");
                                      }
                                      //Get.offNamed(PageRoutes.baseRoute);
                                    },
                              style: ElevatedButton.styleFrom(
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(10)),
                                  backgroundColor: Colors.green),
                              child: authController.isLoandig.value
                                  ? const CircularProgressIndicator()
                                  : const Text("Entrar",
                                      style: TextStyle(
                                          color: Colors.white, fontSize: 16)),
                            );
                          },
                        ),
                      ),

                      //esqueceu a senha
                      Align(
                        alignment: Alignment.topRight,
                        child: TextButton(
                          onPressed: () async {
                            final bool? result = await showDialog(
                              context: context,
                              builder: (_){
                                                             
                                return ForgotPasswordDialog(email: emailController.text);
                            }
                            );

                            if(result ?? false){
                               
                                utilServices.showToast(text: "Um link de recuperação foi enviado para seu email.");
                            }

                          },
                          child: Text(
                            'Esqueceu a senha?',
                            style: TextStyle(
                                color: CustomColors.customContrastColor),
                          ),
                        ),
                      ),

                      //divisor ou
                      Padding(
                        padding: const EdgeInsets.only(bottom: 5),
                        child: Row(
                          children: [
                            Expanded(
                              child: Divider(
                                  color: Colors.grey.withAlpha(90),
                                  thickness: 2),
                            ),
                            const Padding(
                              padding: EdgeInsets.symmetric(horizontal: 5),
                              child: Text(
                                "Ou",
                                style: TextStyle(color: Colors.black),
                              ),
                            ),
                            Expanded(
                              child: Divider(
                                  color: Colors.grey.withAlpha(90),
                                  thickness: 2),
                            )
                          ],
                        ),
                      ),

                      //buttoum entrar
                      SizedBox(
                        height: 40,
                        child: OutlinedButton(
                          onPressed: () {
                            Get.toNamed(PageRoutes.sinUpRoute);
                          },
                          style: OutlinedButton.styleFrom(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                              side: const BorderSide(
                                  color: Colors.green, width: 2)),
                          child: const Text(
                            "Criar conta",
                            style: TextStyle(color: Colors.green, fontSize: 15),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
