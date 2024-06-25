import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:proyecto_sw1/utils/constants.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ChatService {
  static Future<Map<String, dynamic>> getChats(int userId) async {
    String token = await SharedPreferences.getInstance().then((prefs) => prefs.getString('token') ?? '');
    try {
      final response = await http.get(
        Uri.parse('${AppConstant.apiUrl}/users/$userId/chats'),
        //bearer token
        headers: {'Authorization': 'Bearer $token'},
        
      );
      // ignore: avoid_print
      print(response.body);
      if (response.statusCode == 200) {
        var data = jsonDecode(response.body);
        return data;
      } else {
        throw Exception('Failed to get chats. Status code: ${response.statusCode}');
      }
    } catch (e) {
      // ignore: avoid_print
      print('Error during getChats: $e');
      throw Exception('Failed to get chats: $e');
    }
  
  }

  //enviar mensaje

  static Future<Map<String, dynamic>> sendMessage(int chatId, String message) async {
    String token = await SharedPreferences.getInstance().then((prefs) => prefs.getString('token') ?? '');
    try {
      final response = await http.post(
        Uri.parse('${AppConstant.apiUrl}/messages'),
        headers: {'Content-Type': 'application/json', 'Accept': 'application/json', 'Authorization': 'Bearer $token'},
        body: jsonEncode({
          'chatId': chatId,
          'content': message,
          'type': 0,
        }),
      );

      if (response.statusCode == 200) {
        var data = jsonDecode(response.body);
        return data;
      } else {
        throw Exception('Failed to send message. Status code: ${response.statusCode}');
      }
    } catch (e) {
      // ignore: avoid_print
      print('Error during sendMessage: $e');
      throw Exception('Failed to send message: $e');
    }
  }

}