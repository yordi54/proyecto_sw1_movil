import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:proyecto_sw1/controllers/auth.controller.dart';

 class LoginPage extends StatelessWidget {
  final AuthController _authController = Get.find();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  LoginPage({super.key}); 

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Colors.greenAccent, Colors.white],
          ),
        ),
        child: Center(
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Form(
                key: _formKey, // Asignar la clave al formulario
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset('assets/images/logo.png', width: 150, height: 150, color: Colors.green ),
                    const SizedBox(height: 16),
                    const Text('Inicio de Sesión', style: TextStyle(fontSize: 24, color: Colors.white )),
                    const SizedBox(height: 16),
                    Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: TextFormField(
                        controller: emailController,
                        keyboardType: TextInputType.emailAddress, 
                        decoration: const InputDecoration(
                          labelText: 'Correo electrónico',
                          border: OutlineInputBorder( 
                            borderRadius: BorderRadius.all(Radius.circular(10.0))
                          ),
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Por favor, introduce tu correo electrónico';
                          }
                          if (!GetUtils.isEmail(value)) {
                            return 'Por favor, introduce un correo electrónico válido';
                          }
                          return null;
                        },
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: TextFormField(
                        controller: passwordController,
                        obscureText: true, // Ocultar texto de la contraseña
                        decoration: const InputDecoration(
                          labelText: 'Contraseña',
                          border: OutlineInputBorder( 
                            borderRadius: BorderRadius.all(Radius.circular(10.0))
                          ),
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Por favor, introduce tu contraseña';
                          }
                          return null;
                        },
                      ),
                    ),
                    const SizedBox(height: 16),
                    SizedBox(
                      width: double.infinity,
                      child: Obx(() {
                        return ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.green,
                            padding: const EdgeInsets.symmetric(vertical: 16.0),
                          ),
                          onPressed: _authController.isLoading.value
                              ? null
                              : () {
                                  // Validar el formulario antes de iniciar sesión
                                  if (_formKey.currentState!.validate()) {
                                    _authController.login(
                                      emailController.text,
                                      passwordController.text,
                                    );
                                  }
                                },
                          child: _authController.isLoading.value
                              ? const CircularProgressIndicator()
                              : const Text('Iniciar sesión', style: TextStyle(fontSize: 16, color: Colors.white))
                        );
                      }),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
