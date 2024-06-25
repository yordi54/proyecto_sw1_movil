import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:proyecto_sw1/utils/constants.dart';
class AuthService {

  static Future<Map<String, dynamic>> login(
      String email, String password) async {
    try {
      final response = await http.post(
        Uri.parse('${AppConstant.apiUrl}/sanctum/token'),
        headers: {'Content-Type': 'application/json', 'Accept': 'application/json'},
        body: jsonEncode({'email': email, 'password': password, 'device_name': 'mobile'}),
      );

      if (response.statusCode == 200) {
        var data = jsonDecode(response.body);
        // Guardar el token en SharedPreferences
        SharedPreferences prefs = await SharedPreferences.getInstance();
        await prefs.setString('token', data['token']);
        return data;
      } else if (response.statusCode == 401) {
        // Si las credenciales son inválidas, lanzar una excepción con un mensaje personalizado
        throw Exception('Invalid credentials');
      } else {
        // Otro código de estado de respuesta, manejar según sea necesario
        throw Exception('Failed to login. Status code: ${response.statusCode}');
      }
    } catch (e) {
      // Manejar la excepción aquí
      // ignore: avoid_print
      print('Error during login: $e');
      throw Exception('Failed to login: $e');
    }
  }

  static Future<Map<String, dynamic>> register(
      String firstName, String lastName, String email, String password, int languageId ) async {
    try {
      final response = await http.post(
        Uri.parse('${AppConstant.apiUrl}/register'),
        headers: {'Content-Type': 'application/json', 'Accept': 'application/json'},
        body: jsonEncode({
          'first_name': firstName,
          'last_name': lastName,
          'email': email,
          'password': password,
          'password_confirmation': password, // Agregar este campo si se requiere confirmación de contraseña
          'language_id': languageId,
        }),
      );

      if (response.statusCode == 200) {
        var data = jsonDecode(response.body);
        // Guardar el token en SharedPreferences
        SharedPreferences prefs = await SharedPreferences.getInstance();
        await prefs.setString('token', data['token']);
        await prefs.setString('user', jsonEncode(data['user']));
        return data;
      } else {
        // Otro código de estado de respuesta, manejar según sea necesario
        throw Exception(
            'Failed to register. Status code: ${response.statusCode}');
      }
    } catch (e) {
      // Manejar la excepción aquí
      // ignore: avoid_print
      print('Error during registration: $e');
      throw Exception('Failed to register: $e');
    }
  }

  static Future<void> logout() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.remove('token');
    await prefs.remove('user');
  }

  static Future<Map<String, dynamic>?> getUserData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? userData = prefs.getString('user');
    if (userData != null) {
      return jsonDecode(userData);
    } else {
      return null;
    }
  }

  static Future<String?> getToken() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString('token');
  }


}
