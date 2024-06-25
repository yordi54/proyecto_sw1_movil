import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:proyecto_sw1/utils/constants.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UserService {

  static Future<Map<String, dynamic>> searchUsers(String query) async{
    String token = await SharedPreferences.getInstance().then((prefs) => prefs.getString('token') ?? '');
    try{
      final response = await http.get(
        Uri.parse('${AppConstant.apiUrl}/users?userQuery=$query'),
        headers: {
          'Accept': 'application/json',
          'Authorization': 'Bearer $token'
        },

      );
      if (response.statusCode == 200) {
        var data = jsonDecode(response.body);
        return data;
      } else {
        throw Exception('Failed to search users. Status code: ${response.statusCode}');
      }

    }catch(e){
      // ignore: avoid_print
      print('Error during searchUsers: $e');
      throw Exception('Failed to search users: $e');
    }
  }
}