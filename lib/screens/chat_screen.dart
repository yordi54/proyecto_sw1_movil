import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:proyecto_sw1/controllers/auth.controller.dart';
import 'package:proyecto_sw1/controllers/chat.controller.dart';
import 'package:proyecto_sw1/models/member.dart';
import 'package:proyecto_sw1/widgets/build_message.dart';
import 'package:proyecto_sw1/widgets/build_message_input.dart';
//import 'package:pusher_channels_flutter/pusher_channels_flutter.dart';

class ChatScreen extends StatefulWidget {
  const ChatScreen({super.key});

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final AuthController authController = Get.find();
  final ChatController chatController = Get.find();
  
  /* PusherChannelsFlutter pusher = PusherChannelsFlutter.getInstance();
  AuthController _authController = Get.find();


  void initPusher() async {
    final userId = _authController.user.value!.id;
    try{
       await pusher.init(
        apiKey: '5c23fb9bd20e85ee24b1',
        cluster: 'us2',
        onSubscriptionSucceeded: onSubscriptionSucceeded,
        onEvent: onEvent,
        onSubscriptionError: onSubscriptionError,
        onError: onError ,
        onConnectionStateChange: onConnectionStateChange,
      );
      
      await pusher.connect();
      await pusher.subscribe(channelName: 'chatUsers.$userId');
      print('Conectado a Pusher');

    }catch(e){
      print('Error al conectar con Pusher: $e');
    }
  }

  void onSubscriptionSucceeded(String channelName, dynamic data) {
    print("onSubscriptionSucceeded: $channelName data: $data");
  }

  void onEvent(PusherEvent event) {
    print("onEvent: ${event.toString()}");
  }

  void onSubscriptionError(String message, dynamic e) {
    print("onSubscriptionError: $message Exception: $e");
  }

  void onError(String message, int? code, dynamic e) {
  print("onError: $message code: $code exception: $e");
}

  void onConnectionStateChange(String currentState, String previousState) {
    print("onConnectionStateChange: $currentState from $previousState");
  }

  @override
  void initState() {
    super.initState();
    initPusher();
  } */


  @override
  Widget build(BuildContext context) {
    final arguments = Get.arguments as Map <String, dynamic>;
    final Member member = arguments['member'] as Member;
    
    return Scaffold(
      appBar:  AppBar(
        iconTheme: const IconThemeData(color: Colors.white),
        backgroundColor:  Theme.of(context).primaryColor ,
        titleTextStyle: const TextStyle(fontFamily: 'Roboto', color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold),
        title:  Row(
          children:  [
            CircleAvatar(
              backgroundImage: NetworkImage(member.photo)
            ),
            const SizedBox(width: 10),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children:  [
                Text('${member.firstName} ${member.lastName} ', style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                const Text('En línea', style: TextStyle(fontSize: 12, color: Colors.white)),
              ],
            )   
          ]
        ),
      ),
      body: Obx((){
        final currentChat = chatController.chats.value!.firstWhere((element) => element.members.contains(member));
        if(currentChat.messages.isEmpty){
          return const Center(child: Text('No hay mensajes'));
        }else{
          return Column(
            children: [
              Expanded(
                child: ListView.builder(
                  itemCount: currentChat.messages.length,
                  itemBuilder: (context, index) {
                    final message = currentChat.messages[index];
                    final isMe = message.userId == authController.user.value!.id;
                    return BuildMessage(message: message, isMe: isMe);
                  },
                ),
              ),
              BuildMessageInput(chatId: currentChat.id)
            ],
          );
        }
      })
    );
  }
}