import 'package:flutter/material.dart';

//iniciar las rutas

import 'package:get/get.dart';
import 'package:proyecto_sw1/controllers/auth.controller.dart';
import 'package:proyecto_sw1/route.dart';
import 'package:proyecto_sw1/utils/colors.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Chat App',
      debugShowCheckedModeBanner: false,
      initialRoute: AppRoutes.login,
      getPages: AppRoutes.routes,
      initialBinding: BindingsBuilder(() {
        // Inicializar el AuthController 
        Get.put(AuthController());
      }),
      theme: ThemeData(
        primaryColor: AppColors.primary,
        scaffoldBackgroundColor: AppColors.background,
        colorScheme: const ColorScheme.light(
          primary: AppColors.primary,
          secondary: AppColors.accent,
        ),
      ),

          
        
        
    );
  }
}

