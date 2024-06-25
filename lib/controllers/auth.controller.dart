
import 'package:get/get.dart';
import 'package:proyecto_sw1/models/user.model.dart';
import 'package:proyecto_sw1/route.dart';
import 'package:proyecto_sw1/services/auth.service.dart';

class AuthController extends GetxController {
  var isLoggedIn = false.obs;  // Observable para verificar si el usuario está conectado
  var user = Rxn<User>(); // Observable para almacenar el usuario actual
  var isLoading = false.obs; // Observable para verificar si la aplicación está cargando
  

  void login(String email, String password) async {
    try {
      isLoading(true);
      var response = await AuthService.login(email, password);
      user.value = User.fromJson(response['user']);
      isLoggedIn(true);
      Get.offAllNamed(AppRoutes
          .home); // Navegar a la pantalla principal después del inicio de sesión
    } catch (e) {
      Get.snackbar('Error', e.toString(), snackPosition: SnackPosition.BOTTOM);
    } finally {
      isLoading(false);
    }
  }

  void register(String firstName, String lastName, String email, String password, int languageId ) async {
    try {
      isLoading(true);
      var response = await AuthService.register(firstName, lastName, email, password, languageId);
      user.value = User.fromJson(response['user']);
      isLoggedIn(true);
      Get.offAllNamed(AppRoutes
          .home); // Navegar a la pantalla principal después del registro
    } catch (e) {
      Get.snackbar('Error', e.toString(), snackPosition: SnackPosition.BOTTOM);
    } finally {
      isLoading(false);
    }
  }

  void logout() async {
    try {
      isLoading(true);
      await AuthService.logout();
      user.value = null;
      isLoggedIn(false);
      Get.offAllNamed(AppRoutes.login);
    } catch (e) {
      Get.snackbar('Error', e.toString(), snackPosition: SnackPosition.BOTTOM);
    } finally {
      isLoading(false);
    }
  }
}
