//routes con getx
import 'package:get/get.dart';
import 'package:proyecto_sw1/screens/chat_screen.dart';
import 'package:proyecto_sw1/screens/home_screen.dart';
import 'package:proyecto_sw1/screens/login.dart';
import 'package:proyecto_sw1/screens/register.dart';

class AppRoutes {
  static const String home = '/';
  static const String login = '/login';
  static const String register = '/register';
  static const String chat = '/chat';

  static final routes = [
    GetPage(
      name: home,
      page: () => const HomeScreen(),
    ),
    GetPage(
      name: login,
      page: () => LoginPage(),
    ),
    GetPage(
      name: register,
      page: () => RegisterPage(),
    ),
    GetPage(
      name: chat, 
      page: () => const ChatScreen(),
    )
    
  ];
}
