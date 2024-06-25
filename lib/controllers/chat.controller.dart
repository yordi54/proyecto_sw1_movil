
import 'dart:convert';

import 'package:get/get.dart';
import 'package:proyecto_sw1/controllers/auth.controller.dart';
import 'package:proyecto_sw1/models/chat.model.dart';
import 'package:proyecto_sw1/models/message.model.dart';
import 'package:proyecto_sw1/models/transalated_text.model.dart';
import 'package:proyecto_sw1/services/chat.service.dart';
import 'package:pusher_channels_flutter/pusher_channels_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

class ChatController extends GetxController{
  var chats = Rxn<List<Chat>>();
  late PusherChannelsFlutter pusher;
  //canal
  late PusherChannel channel;
  AuthController  authController = Get.find();

  @override
  void onInit() {
    super.onInit();
    initializePusher();
  }

  @override
  void onClose() {
    super.onClose();
    //desuscribirse de los canales y desconectar
    pusher.unsubscribe(channelName: 'private-chatUsers.${authController.user.value!.id}');
    pusher.disconnect();
  } 

  Future<void> initializePusher() async {
    pusher = PusherChannelsFlutter.getInstance();
    try{
      await pusher.init(
        apiKey: '5c23fb9bd20e85ee24b1',
        cluster: 'us2',
        useTLS: true,
        onConnectionStateChange: onConnectionStateChange,
        onEvent: onEvent,
        onSubscriptionError: onSubscriptionError,
        onSubscriptionSucceeded: onSubscriptionSucceeded,
        onError: onError,
        onAuthorizer: onAuthorizer,
      );
      channel = await  pusher.subscribe(channelName: 'private-chatUsers.${authController.user.value!.id}');
      await pusher.connect();
    }catch (e){
      // ignore: avoid_print
      print('Error al conectar con Pusher: $e');
    }
    
  }

  dynamic onAuthorizer(String channelName, String socketId, dynamic options) async {
    try{
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String token = prefs.getString('token') ?? '';
      var authUrl = "http://35.188.53.99/api/broadcasting/auth";
      var result = await http.post(
        Uri.parse(authUrl),
        headers: {
          'Content-Type': 'application/x-www-form-urlencoded',
          'Authorization': 'Bearer $token',
        },
        body: 'socket_id=$socketId&channel_name=$channelName',
      );
      var json = jsonDecode(result.body);
      return json;

    }catch(e){
      // ignore: avoid_print
      print('Error al autorizar: $e');
    }
  }

  void onConnectionStateChange(String currentState, String previousState) {
    // ignore: avoid_print
    print('onConnectionStateChange: $currentState from $previousState');
  }

  void onError(String message, int? code, dynamic e) {
    // ignore: avoid_print
    print('onError: $message code: $code exception: $e');
  }

  void onSubscriptionError(String message, dynamic e) {
    // ignore: avoid_print
    print('onSubscriptionError: $message Exception: $e');
  }

  void onSubscriptionSucceeded(String channelName, dynamic data) {
    // ignore: avoid_print
    print('onSubscriptionSucceeded: $channelName data: $data');
  }



  void onEvent(PusherEvent event) {
   

    // Manejar eventos específicos de la aplicación
    // ignore: 
    if (event.eventName =='App\\Events\\MessageSent') {
      try {
        // ignore: avoid_print
        final eventData = Map<String, dynamic>.from(event.data);
        TranslatedTex translatedText = TranslatedTex(
          id: eventData['message']['text_messages'][1]['id'],
          messageId: eventData['message']['text_messages'][1]['message_id'],
          content: eventData['message']['text_messages'][1]['content'],
          isOriginal: eventData['message']['text_messages'][1]['is_original'],
          languageId: eventData['message']['text_messages'][1]['language_id'],
        );
        Message newMessage = Message(
          id: eventData['message']['id'],
          chatId: eventData['message']['chat_id'],
          type: eventData['message']['type'],
          sentAt: eventData['message']['sent_at'],
          userId: eventData['message']['user_id'],
          translatedText: translatedText,
        ); 
        /* print('Nuevo mensaje: $newMessage');  */ 

        final chatIndex = chats.value!.indexWhere((element) => element.id == newMessage.chatId);
        if (chatIndex != -1) {
          //chats.value![chatIndex].latestMessage = newMessage;
          chats.value![chatIndex].messages.add(newMessage);
          chats.refresh();
        } 
      } catch (e) {
        // ignore: avoid_print
        print('Error procesando el evento: $e');
      }
    }
    
  }


  void getChats(int userId) async{
    try{
      final response = await ChatService.getChats(userId);
      //response ['chats']
      chats.value = List<Chat>.from(response['chats'].map((x) => Chat.fromJson(x)));
      //notificar a los observadores
      update();

      
    }catch(e){
      Get.snackbar('Error', e.toString(), snackPosition: SnackPosition.BOTTOM);
    }

  }

  ///enviar mensaje
  void sendMessage(int chatId, String message) async{
    try{
      final response = await ChatService.sendMessage(chatId, message);
      //agregar el mensaje a la lista de mensaje segun el chatId
      Message newMessage =  Message(
        id: response['message']['id'],
        chatId: response['message']['chat_id'],
        type: response['message']['type'],
        sentAt: response['message']['sent_at'],
        userId: response['message']['user_id'],
        translatedText: TranslatedTex.fromJson(response['message']['original_text']),
      );
      final chatIndex = chats.value!.indexWhere((element) => element.id == chatId);
      chats.value![chatIndex].messages.add(newMessage); 
      //actualizar los cambios
      chats.refresh();

      

      
    }catch(e){
      Get.snackbar('Error', e.toString(), snackPosition: SnackPosition.BOTTOM);
    }

  }


}