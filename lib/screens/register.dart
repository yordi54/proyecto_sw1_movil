//page register

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:proyecto_sw1/controllers/auth.controller.dart';
import 'package:proyecto_sw1/route.dart';

class RegisterPage extends StatelessWidget {
  final AuthController _authController = Get.find();
  final TextEditingController firstNameController = TextEditingController();
  final TextEditingController lastNameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController languageIdController = TextEditingController();
  final _formKey =
      GlobalKey<FormState>(); // Clave para identificar el formulario

  RegisterPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
            child: SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey, // Asignar la clave al formulario
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                'Registrarse',
                style: TextStyle(fontSize: 24),
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: firstNameController,
                decoration: const InputDecoration(
                  labelText: 'Nombre',
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Por favor, ingrese su nombre';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: lastNameController,
                decoration: const InputDecoration(
                  labelText: 'Apellido',
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Por favor, ingrese su apellido';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: emailController,
                decoration: const InputDecoration(
                  labelText: 'Correo electrónico',
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Por favor, ingrese su correo electrónico';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: passwordController,
                obscureText: true, // Ocultar texto de la contraseña
                decoration: const InputDecoration(
                  labelText: 'Contraseña',
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Por favor, ingrese su contraseña';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: languageIdController,
                keyboardType: TextInputType.number, // Teclado numérico
                decoration: const InputDecoration(
                  labelText: 'Idioma',
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Por favor, ingrese su idioma';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),
              Obx(() => ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blue,
                      padding: const EdgeInsets.symmetric(
                          vertical: 16.0, horizontal: 16.0),
                    ),
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        _authController.register(
                          firstNameController.text, lastNameController.text, emailController.text,
                          passwordController.text, int.parse(languageIdController.text)
                        );
                      }
                    },
                    child: _authController.isLoading.isTrue
                        ? const CircularProgressIndicator(
                            valueColor:
                                AlwaysStoppedAnimation<Color>(Colors.white),
                          )
                        : const Text('Registrarse',
                            style:
                                TextStyle(color: Colors.white, fontSize: 16)),
                  )),
              const SizedBox(height: 16),
              TextButton(
                onPressed: () {
                  Get.offAllNamed(AppRoutes.login);
                },
                child: const Text('¿Ya tienes una cuenta? Inicia sesión'),
              ),
            ],
          ),
        ),
      ),
    )));
  }
}
